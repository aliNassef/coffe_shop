import 'dart:async';
import 'dart:developer';
import 'package:coffe_shop/features/order/data/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../env/env.dart';
import '../../../order/presentation/widgets/track_order_map_top_bar.dart';
import '../controller/cubit/delivery_cubit.dart';

class DeliveryMapView extends StatefulWidget {
  const DeliveryMapView({super.key, required this.order});
  static const routeName = 'delivery-map';
  final OrderModel order;
  @override
  State<DeliveryMapView> createState() => _DeliveryMapViewState();
}

class _DeliveryMapViewState extends State<DeliveryMapView> {
  late GoogleMapController _mapController;
  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  bool isMapReady = false;
  LatLng? orderPosition;
  late StreamSubscription<Position> _positionStreamSubscription;
  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints(apiKey: Env.mapsApiKey);
    orderPosition = LatLng(
      widget.order.deliveryLat!,
      widget.order.deliveryLong!,
    );
    _getPolyLine();
    context.read<DeliveryCubit>().getDeliveryPosition();
  }

  @override
  void dispose() {
    _mapController.dispose();
    _positionStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<DeliveryCubit, DeliveryState>(
        listener: (context, state) {
          if (state is DeliveryGetPositionLoadedState) {
            orderPosition = state.position;
            _getPolyLine();
            if (mounted) {
              context.read<DeliveryCubit>().updateDeliveryLatLong(
                lat: state.position.latitude,
                long: state.position.longitude,
                orderId: widget.order.orderId,
              );
              _getDiffDistance(context);
            }
          }
        },
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  orderPosition!.latitude,
                  orderPosition!.longitude,
                ),
                zoom: 15,
              ),
              polylines: Set<Polyline>.of(polylines.values),
              markers: getMarkers,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                setState(() {
                  isMapReady = true;
                });
              },
            ),
            Positioned(
              top: 50.h,
              right: 16.w,
              left: 16.w,
              child: isMapReady
                  ? TrackOrderMapTopBar(
                      mapController: _mapController,
                      position: orderPosition!,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  void _getDiffDistance(BuildContext context) {
    double distance = context.read<DeliveryCubit>().getDiffDistance(
      widget.order.userLat,
      widget.order.userLong,
      orderPosition!.latitude,
      orderPosition!.longitude,
    );
    log(" distance: $distance");
    if (distance < 100) {
      log('order delivered');
    }
  }

  Set<Marker> get getMarkers {
    return {
      Marker(
        icon: AssetMapBitmap(AppImages.location, height: 30.h, width: 30.w),
        infoWindow: const InfoWindow(title: 'User Location'),
        markerId: const MarkerId('1'),
        position: LatLng(widget.order.userLat, widget.order.userLong),
      ),
      Marker(
        icon: AssetMapBitmap(AppImages.bike, height: 30.h, width: 30.w),
        infoWindow: const InfoWindow(title: 'My Location'),
        markerId: const MarkerId('2'),
        position: LatLng(orderPosition!.latitude, orderPosition!.longitude),
      ),
    };
  }

  void _addPolyLine() {
    PolylineId id = const PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: AppColors.primary,
      points: polylineCoordinates,
      width: 5,
    );
    polylines[id] = polyline;

    setState(() {});
  }

  Future<void> _getPolyLine() async {
    polylineCoordinates.clear();
    polylines.clear();
    final result = await polylinePoints.getRouteBetweenCoordinatesV2(
      request: RoutesApiRequest(
        origin: PointLatLng(widget.order.userLat, widget.order.userLong),
        destination: PointLatLng(
          orderPosition!.latitude,
          orderPosition!.longitude,
        ),
        travelMode: TravelMode.driving,
      ),
    );

    if (result.routes.isNotEmpty) {
      for (var point in result.routes[0].polylinePoints ?? []) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      _addPolyLine();
    }
  }
}
