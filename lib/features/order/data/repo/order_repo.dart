import 'package:dartz/dartz.dart';

import '../../../../core/helpers/failure.dart';

abstract class OrderRepo {
  Future<Either<Failure, String>> getUserAddress();
}