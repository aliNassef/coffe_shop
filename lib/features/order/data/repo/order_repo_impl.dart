import '../../../../core/helpers/failure.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/helpers/location_helper.dart';
import 'order_repo.dart';

class OrderRepoImpl extends OrderRepo {
  final LocationHelper _locationHelper;

  OrderRepoImpl({required LocationHelper locationHelper})
    : _locationHelper = locationHelper;
  @override
  Future<Either<Failure, String>> getUserAddress() async {
    try {
      final address = await _locationHelper.getCurrentLocation();
      return Right(address);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
