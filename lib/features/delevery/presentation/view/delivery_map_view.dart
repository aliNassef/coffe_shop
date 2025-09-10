import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../order/data/models/order_model.dart';
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
  bool isMapReady = false;
  LatLng? orderPosition;
  @override
  void initState() {
    super.initState();
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
        child: BlocSelector<DeliveryCubit, DeliveryState, Set<Polyline>>(
          selector: (state) {
            if (state is DrawPolyLineState) {
              return state.polylines;
            }
            return {};
          },
          builder: (context, state) {
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
                  polylines: state,
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
      Navigator.pop(context);
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

  Future<void> _getPolyLine() async {
    context.read<DeliveryCubit>().drawPolyLine(
      start: orderPosition!,
      end: LatLng(widget.order.userLat, widget.order.userLong),
    );
  }
}
