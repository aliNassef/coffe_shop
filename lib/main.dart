import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'coffe_shop_app.dart';
import 'core/utils/app_initializer.dart';
import 'env/env.dart';

void main() async {
  await AppInitializer.init();
  if (kReleaseMode) {
    await SentryFlutter.init(
      (options) {
        options.dsn = Env.sentryDsn;
        options.tracesSampleRate = 0.01;
      },
      appRunner: () {
        runApp(
          SentryWidget(
            child: DevicePreview(
              enabled: !kReleaseMode,
              builder: (context) => const CoffeShopApp(),
            ),
          ),
        );
      },
    );
  } else {
    runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const CoffeShopApp(),
      ),
    );
  }
}
