import 'package:coffe_shop/core/helpers/firestore_helper.dart';
import 'package:coffe_shop/features/order/data/models/order_model.dart';

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
}
