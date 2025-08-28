import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/helpers/failure.dart';
import '../models/order_model.dart';

abstract class OrderRepo {
  Future<Either<Failure, void>> addOrder(OrderModel order);
  Future<Either<Failure, List<OrderModel>>> getUserOrders();
  Future<Either<Failure, LatLng>> getDeliveryPosition({
    required String orderId,
  });
}
