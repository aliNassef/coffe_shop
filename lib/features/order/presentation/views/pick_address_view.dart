import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker_google/place_picker_google.dart';

import '../../../../env/env.dart';

class PickAddressView extends StatelessWidget {
  const PickAddressView({super.key});
  static const routeName = 'pick_address_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlacePicker(
        enableNearbyPlaces: false,
        apiKey: Env.mapsApiKey,
        onPlacePicked: (LocationResult result) {
          final address = result.formattedAddress;
          log("Place picked: $address");
          Navigator.pop(context, address);
        },
        initialLocation: const LatLng(29.378586, 47.990341),
        searchInputConfig: const SearchInputConfig(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          autofocus: false,
          textDirection: TextDirection.ltr,
        ),
        searchInputDecorationConfig: const SearchInputDecorationConfig(
          hintText: "Search for a building, street or ...",
        ),
      ),
    );
  }
}
