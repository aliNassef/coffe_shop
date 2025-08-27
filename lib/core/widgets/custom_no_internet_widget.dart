import 'package:flutter/material.dart';

class CustomNoInternetWidget extends StatelessWidget {
  const CustomNoInternetWidget({super.key});
  static const routeName = 'custom_no_internet_widget';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 100, color: Colors.grey),
            const SizedBox(height: 20),
            const Text('No Internet Connection'),
            const SizedBox(height: 10),
            const Text(
              'Please check your internet connection and try again.',

              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
