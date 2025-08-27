import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_failure_widget.dart';
import '../../../../env/env.dart';
import '../controller/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/track_order_map_top_bar.dart';

class TrackOrderMapView extends StatefulWidget {
  const TrackOrderMapView({super.key});
  static const routeName = 'track-order-map';

  @override
  State<TrackOrderMapView> createState() => _TrackOrderMapViewState();
}

class _TrackOrderMapViewState extends State<TrackOrderMapView> {
  late GoogleMapController mapController;
  bool isMapReady = false;
  Set<Marker> markers = <Marker>{};
  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  Position? userPosition;
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUserCoardinate();
    polylinePoints = PolylinePoints(apiKey: Env.mapsApiKey);
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserCubit, UserState>(
        buildWhen: (previous, current) =>
            current is GetuserPositonLoadedState ||
            current is GetuserPositonFailed ||
            current is GetuserPositonLoadingState,
        listenWhen: (previous, current) =>
            current is GetuserPositonLoadedState ||
            current is GetuserPositonFailed ||
            current is GetuserPositonLoadingState,
        listener: (context, state) {
          if (state is GetuserPositonLoadedState) {
            userPosition = state.position;
          }
        },
        builder: (context, state) {
          if (state is GetuserPositonLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          if (state is GetuserPositonFailed) {
            return CustomFailureWidget(errMessage: state.error);
          }

          if (state is GetuserPositonLoadedState) {
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      userPosition!.latitude,
                      userPosition!.longitude,
                    ),
                    zoom: 14.4746,
                  ),
                  polylines: Set<Polyline>.of(polylines.values),
                  markers: {
                    Marker(
                      icon: AssetMapBitmap(
                        AppImages.location,
                        height: 30.h,
                        width: 30.w,
                      ),
                      infoWindow: const InfoWindow(title: 'My Location'),
                      markerId: const MarkerId('1'),
                      position: LatLng(
                        userPosition!.latitude,
                        userPosition!.longitude,
                      ),
                    ),
                    Marker(
                      icon: AssetMapBitmap(
                        AppImages.bike,
                        height: 30.h,
                        width: 30.w,
                      ),
                      infoWindow: const InfoWindow(title: 'delivery Location'),
                      markerId: const MarkerId('2'),
                      position: const LatLng(
                        35.42796133580664,
                        -120.085749655962,
                      ),
                    ),
                  },
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
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
                          mapController: mapController,
                          userPosition: userPosition!,
                        )
                      : SizedBox.shrink(),
                ),
              ],
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  void _addPolyLine() {
    PolylineId id = const PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 5,
    );
    polylines[id] = polyline;

    setState(() {});
  }

  Future<void> _getPolyLine() async {
    final result = await polylinePoints.getRouteBetweenCoordinatesV2(
      request: RoutesApiRequest(
        origin: PointLatLng(37.42796133580664, -122.085749655962),
        destination: PointLatLng(35.42796133580664, -121.085749655962),
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
