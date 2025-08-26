import 'package:coffe_shop/features/order/data/models/order_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/helpers/failure.dart';
import '../model/deleivery_model.dart';

abstract class DelieveryRepo {
  Stream<Either<Failure, List<OrderModel>>> getDeliveryOrders();
  Future<Either<Failure, void>> actionOnOrder({
    required DeleiveryModel deleiveryModel,
    required String orderId,
  });
}
