import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/helpers/firestore_helper.dart';
import '../models/order_model.dart';

import '../../../../core/helpers/failure.dart';

import 'package:dartz/dartz.dart';

import 'order_repo.dart';

class OrderRepoImpl extends OrderRepo {
  final FirestoreHelper _firestoreHelper;

  OrderRepoImpl({required FirestoreHelper firestoreHelper})
    : _firestoreHelper = firestoreHelper;

  @override
  Future<Either<Failure, void>> addOrder(OrderModel order) async {
    try {
      await _firestoreHelper.addOrder(order);
      return const Right(null);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getUserOrders() async {
    try {
      final orders = await _firestoreHelper.getAllOrders();
      return Right(orders);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LatLng>> getDeliveryPosition({
    required String orderId,
  }) async {
    try {
      final order = await _firestoreHelper.getOrderById(orderId);
      return Right(LatLng(order!.deliveryLat!, order.deliveryLong!));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
