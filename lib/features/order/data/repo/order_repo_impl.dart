import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/helpers/firestore_helper.dart';
import '../../../../core/helpers/location_helper.dart';
import '../models/order_model.dart';

import '../../../../core/helpers/failure.dart';

import 'package:dartz/dartz.dart';

import 'order_repo.dart';

class OrderRepoImpl extends OrderRepo {
  final FirestoreHelper _firestoreHelper;

  final LocationHelper _locationHelper;

  OrderRepoImpl({
    required FirestoreHelper firestoreHelper,
    required LocationHelper locationHelper,
  }) : _firestoreHelper = firestoreHelper,
       _locationHelper = locationHelper;

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

  @override
  Future<Either<Failure, Set<Polyline>>> drawPolylineCoordinates({
    required LatLng start,
    required LatLng end,
  }) async {
    try {
      final polylines = await _locationHelper.getPolylineCoordinates(
        start: start,
        end: end,
      );
      return Right(polylines);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  double getDiffDistance({required LatLng start, required LatLng end}) {
    final distance = _locationHelper.getDiffDistance(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
    return distance;
  }

  @override
  Future<Either<Failure, void>> updateOrderStatus({
    required String orderId,
    required String status,
  }) async {
    try {
      await _firestoreHelper.changeOrderStatus(
        orderId: orderId,
        status: status,
      );
      return const Right(null);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
