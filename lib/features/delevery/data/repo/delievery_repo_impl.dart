import '../../../../core/helpers/failure.dart';
import '../model/deleivery_model.dart';

import '../../../order/data/models/order_model.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/helpers/firestore_helper.dart';
import 'delievery_repo.dart';

class DelieveryRepoImpl extends DelieveryRepo {
  final FirestoreHelper _firestoreHelper;
  DelieveryRepoImpl({required FirestoreHelper firestoreHelper})
    : _firestoreHelper = firestoreHelper;

  @override
  Future<Either<Failure, void>> actionOnOrder({
    required DeleiveryModel deleiveryModel,
    required String orderId,
  }) async {
    try {
      await _firestoreHelper.acceptOrder(
        deleveryModel: deleiveryModel,
        orderId: orderId,
      );
      return Right(null);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<OrderModel>>> getDeliveryOrders() async* {
    try {
      await for (final orders in _firestoreHelper.getOrdersStream()) {
        yield Right(orders);
      }
    } catch (e) {
      yield Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateDeliveryLatLong({
    required double lat,
    required double long,
    required String orderId,
  }) async {
    try {
      await _firestoreHelper.updateDeliveryLatLong(lat, long, orderId);
      return Right(null);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> changeOrderStatus(
    String orderId,
    String status,
  ) async {
    try {
      await _firestoreHelper.changeOrderStatus(
        orderId: orderId,
        status: status,
      );
      return Right(null);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
