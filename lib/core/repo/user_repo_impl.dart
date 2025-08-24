import 'package:coffe_shop/core/helpers/failure.dart';
import 'package:coffe_shop/core/repo/user_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../helpers/location_helper.dart';

class UserRepoImpl extends UserRepo {
  final LocationHelper _locationHelper;

  UserRepoImpl({required LocationHelper locationHelper})
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

  @override
  Future<Either<Failure, Position>> getUserCoardinates() async {
    try {
      final position = await _locationHelper.getUserCoardinates();
      return Right(position);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
