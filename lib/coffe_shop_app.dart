import 'dart:async';
import 'core/widgets/custom_no_internet_widget.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'core/di/service_locator.dart';
import 'features/order/presentation/controller/user_cubit/user_cubit.dart';
import 'features/splash/presentation/view/splash_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/utils/app_routes.dart';

class CoffeShopApp extends StatefulWidget {
  const CoffeShopApp({super.key});

  @override
  State<CoffeShopApp> createState() => _CoffeShopAppState();
}

class _CoffeShopAppState extends State<CoffeShopApp> {
  late StreamSubscription _subscription;
  bool isConnected = true;

  @override
  void initState() {
    super.initState();

    _subscription = InternetConnection().onStatusChange.listen((status) {
      setState(() {
        isConnected = status == InternetStatus.connected;
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<UserCubit>()..getUserAddress(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          onGenerateRoute: onGenerateRoute,
          initialRoute: isConnected
              ? SplashView.routeName
              : CustomNoInternetWidget.routeName,
          debugShowCheckedModeBanner: false,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
        ),
      ),
    );
  }
}
