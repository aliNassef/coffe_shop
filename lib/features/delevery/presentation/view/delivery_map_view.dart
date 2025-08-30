import 'dart:async';
import 'dart:developer';

import 'package:coffe_shop/features/order/data/models/order_model.dart';
import 'package:coffe_shop/features/order/presentation/controller/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_failure_widget.dart';
import '../../../../env/env.dart';
import '../../../order/presentation/controller/bloc/get_order_position_bloc.dart';
import '../../../order/presentation/widgets/track_order_map_top_bar.dart';

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
  late Timer _timer;
  Position? userPosition;
  LatLng? orderPosition;
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUserCoardinate();
    context.read<GetOrderPositionBloc>().add(
      GetOrderPosition(orderId: widget.order.orderId),
    );
    polylinePoints = PolylinePoints(apiKey: Env.mapsApiKey);

    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      context.read<GetOrderPositionBloc>().add(
        GetOrderPosition(orderId: widget.order.orderId),
      );
    });
  }

  @override
  void dispose() {
    _mapController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<GetOrderPositionBloc, GetOrderPositionState>(
        listener: (context, state) {
          if (state is GetOrderPositionLoaded) {
            orderPosition = state.position;
            if (userPosition != null) _getPolyLine();
          }
        },
        child: BlocConsumer<UserCubit, UserState>(
          builder: (context, state) {
            if (state is GetuserPositonFailed) {
              return CustomFailureWidget(errMessage: state.error);
            }
            if (userPosition == null) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }
            return Stack(
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
            );
          },
          listenWhen: (previous, current) =>
              current is GetuserPositonLoadedState,
          listener: (context, state) {
            if (state is GetuserPositonLoadedState) {
              userPosition = state.position;
              log(' order position: $orderPosition');
              log(' order position: $userPosition');
              if (orderPosition != null) _getPolyLine();
            }
          },
        ),
      ),
    );
  }

  Set<Marker> get getMarkers {
    return {
      Marker(
        icon: AssetMapBitmap(AppImages.location, height: 30.h, width: 30.w),
        infoWindow: const InfoWindow(title: 'My Location'),
        markerId: const MarkerId('1'),
        position: LatLng(userPosition!.latitude, userPosition!.longitude),
      ),
      Marker(
        icon: AssetMapBitmap(AppImages.bike, height: 30.h, width: 30.w),
        infoWindow: const InfoWindow(title: 'delivery Location'),
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
        origin: PointLatLng(userPosition!.latitude, userPosition!.longitude),
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
