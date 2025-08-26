import 'package:coffe_shop/core/helpers/failure.dart';
import 'package:coffe_shop/features/delevery/data/model/deleivery_model.dart';

import 'package:coffe_shop/features/order/data/models/order_model.dart';

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
}
