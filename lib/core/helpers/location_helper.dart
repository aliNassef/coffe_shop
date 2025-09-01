import 'dart:developer';

import 'package:coffe_shop/core/utils/app_colors.dart';
import 'package:coffe_shop/env/env.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationHelper {
  final PolylinePoints _polylinePoints = PolylinePoints(apiKey: Env.mapsApiKey);

  Future<Position> getUserCoardinates() async =>
      await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      );

  // Get current user location
  Future<String> getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      // Check permission
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'Location permissions are permanently denied, cannot request.',
        );
      }

      // Get current location
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      );
      log('Current position: $position');

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks.first;

      // تبني الاسم (ممكن تغي ر الشكل حسب احتياجك)
      String address =
          " ${place.locality}, ${place.administrativeArea}, ${place.country}";
      log('Address: $address');
      return address;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<Position> getPositionStream() async* {
    await for (final position in Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    )) {
      yield position;
    }
  }

  double getDiffDistance(double lat1, double long1, double lat2, double long2) {
    return Geolocator.distanceBetween(lat1, long1, lat2, long2);
  }

  Future<Set<Polyline>> getPolylineCoordinates({
    required LatLng? start,
    required LatLng? end,
  }) async {
    final List<LatLng> polylineCoordinates = [];

    final result = await _polylinePoints.getRouteBetweenCoordinatesV2(
      request: RoutesApiRequest(
        origin: PointLatLng(start!.latitude, start.longitude),
        destination: PointLatLng(end!.latitude, end.longitude),
        travelMode: TravelMode.driving,
      ),
    );

    if (result.routes.isNotEmpty) {
      for (var point in result.routes[0].polylinePoints ?? []) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    return buildPolylineSet(polylineCoordinates);
  }

  Set<Polyline> buildPolylineSet(
    List<LatLng> polylineCoordinates, {
    String polylineId = "route",

    int width = 5,
  }) {
    return {
      Polyline(
        polylineId: PolylineId(polylineId),
        color: AppColors.primary,
        width: width,
        points: polylineCoordinates,
      ),
    };
  }
}
