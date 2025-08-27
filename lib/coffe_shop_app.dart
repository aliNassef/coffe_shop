import 'package:coffe_shop/core/widgets/custom_no_internet_widget.dart';

import 'core/controller/cubit/internet_connection_cubit.dart';
import 'core/di/service_locator.dart';
import 'features/order/presentation/controller/user_cubit/user_cubit.dart';
import 'features/splash/presentation/view/splash_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/utils/app_routes.dart';

class CoffeShopApp extends StatelessWidget {
  const CoffeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injector<UserCubit>()..getUserAddress(),
        ),
        BlocProvider(
          create: (context) =>
              injector<InternetConnectionCubit>()..monitorInternetConnection(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
            builder: (context, state) {
              if (state is InternetConnectionDisConnected) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  locale: DevicePreview.locale(context),
                  builder: DevicePreview.appBuilder,
                  home: CustomNoInternetWidget(),
                );
              }
              return ScreenUtilInit(
                designSize: const Size(375, 812),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (context, child) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    locale: DevicePreview.locale(context),
                    builder: DevicePreview.appBuilder,
                    initialRoute: SplashView.routeName,
                    onGenerateRoute: onGenerateRoute,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
