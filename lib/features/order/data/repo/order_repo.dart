import 'package:dartz/dartz.dart';

import '../../../../core/helpers/failure.dart';
import '../models/order_model.dart';

abstract class OrderRepo {
  Future<Either<Failure, void>> addOrder(OrderModel order);
}
