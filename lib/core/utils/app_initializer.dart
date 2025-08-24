import 'package:flutter/material.dart';

import '../di/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';

import '../../firebase_options.dart';

class AppInitializer {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // SentryWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    setupServiceLocator();
    await ScreenUtil.ensureScreenSize();
  }
}
