import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/utils/app_colors.dart';

class TrackOrderMapTopBar extends StatelessWidget {
  const TrackOrderMapTopBar({
    super.key,
    required this.mapController,
    required this.userPosition,
  });
  final GoogleMapController mapController;
  final Position userPosition;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(8),
            child: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        Spacer(),
        InkWell(
          onTap: () {
            mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(userPosition.latitude, userPosition.longitude),
                  zoom: 14.4746,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(8),
            child: Icon(Icons.my_location_rounded),
          ),
        ),
      ],
    );
  }
}
