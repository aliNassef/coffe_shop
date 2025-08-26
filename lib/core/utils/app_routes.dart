import '../../features/delevery/presentation/view/delievery_view.dart';
import '../../features/order/presentation/views/track_order_map_view.dart';
import '../../features/splash/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';

import '../../features/home/data/model/coffe_model.dart';
import '../../features/home/presentation/view/coffe_details_view.dart';
import '../../features/home/presentation/view/home_view.dart';
import '../../features/order/presentation/views/order_view.dart';
import '../../features/order/presentation/views/pick_address_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case HomeView.routeName:
      return PageRouteBuilder(
        pageBuilder: (_, _, _) => const HomeView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      );
    case CoffeDetailsView.routeName:
      final coffe = settings.arguments as CoffeeModel;
      return PageRouteBuilder(
        pageBuilder: (_, _, _) => CoffeDetailsView(coffe: coffe),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      );
    case OrderView.routeName:
      final coffe = settings.arguments as CoffeeModel;
      return PageRouteBuilder(
        pageBuilder: (_, _, _) => OrderView(coffe: coffe),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      );
    case PickAddressView.routeName:
      return PageRouteBuilder(
        pageBuilder: (_, _, _) => const PickAddressView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      );
    case TrackOrderMapView.routeName:
      return PageRouteBuilder(
        pageBuilder: (_, _, _) => const TrackOrderMapView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      );
    case DelieveryView.routeName:
      return PageRouteBuilder(
        pageBuilder: (_, _, _) => const DelieveryView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      );
    default:
      return MaterialPageRoute(builder: (_) => Container());
  }
}
