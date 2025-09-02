import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/models/order_model.dart';
import '../controller/bloc/get_order_position_bloc.dart';
import '../controller/user_cubit/user_cubit.dart';
import '../widgets/track_order_map_top_bar.dart';

class TrackOrderMapView extends StatefulWidget {
  const TrackOrderMapView({super.key, required this.order});
  static const routeName = 'track-order-map';
  final OrderModel order;
  @override
  State<TrackOrderMapView> createState() => _TrackOrderMapViewState();
}

class _TrackOrderMapViewState extends State<TrackOrderMapView> {
  late GoogleMapController _mapController;
  bool isMapReady = false;
  LatLng? userPosition;
  LatLng? orderPosition;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUserCoardinate();
    context.read<GetOrderPositionBloc>().add(
      GetOrderPosition(orderId: widget.order.orderId),
    );
    userPosition = LatLng(widget.order.userLat, widget.order.userLong);
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
      body: BlocConsumer<GetOrderPositionBloc, GetOrderPositionState>(
        buildWhen: (previous, current) => current is DrawPolylineState,
        listener: (context, state) {
          if (state is GetOrderPositionLoaded) {
            orderPosition = state.position;
            _getPolyLine();
          }
        },
        builder: (context, state) {
          if (state is DrawPolylineState) {
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      userPosition!.latitude,
                      userPosition!.longitude,
                    ),
                    zoom: 16,
                  ),
                  polylines: state.polylines,
                  markers: getMarkers,
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                    setState(() {
                      isMapReady = true;
                    });
                  },
                  mapType: MapType.normal,
                ),
                Positioned(
                  top: 50.h,
                  right: 16.w,
                  left: 16.w,
                  child: isMapReady
                      ? TrackOrderMapTopBar(
                          mapController: _mapController,
                          position: LatLng(
                            userPosition!.latitude,
                            userPosition!.longitude,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        },
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

  Future<void> _getPolyLine() async {
    context.read<GetOrderPositionBloc>().add(
      DrawPolylineEvent(
        source: LatLng(userPosition!.latitude, userPosition!.longitude),
        destination: LatLng(orderPosition!.latitude, orderPosition!.longitude),
      ),
    );
  }
}
