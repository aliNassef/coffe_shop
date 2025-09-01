import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationHelper {
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
}
