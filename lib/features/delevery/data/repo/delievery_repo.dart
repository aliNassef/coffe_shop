import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../order/data/models/order_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/helpers/failure.dart';
import '../model/deleivery_model.dart';

abstract class DelieveryRepo {
  Stream<Either<Failure, List<OrderModel>>> getDeliveryOrders();
  Stream<Either<Failure, Position>> getDeliveryPosition();
  Future<Either<Failure, Set<Polyline>>> drawPolylineCoordinates({
    required LatLng start,
    required LatLng end,
  });
  Future<Either<Failure, void>> changeOrderStatus(
    String orderId,
    String status,
  );
  Future<Either<Failure, void>> updateDeliveryLatLong({
    required double lat,
    required double long,
    required String orderId,
  });
  Future<Either<Failure, void>> actionOnOrder({
    required DeleiveryModel deleiveryModel,
    required String orderId,
  });
  double getDiffDistance({
    required double lat1,
    required double long1,
    required double lat2,
    required double long2,
  });
}
