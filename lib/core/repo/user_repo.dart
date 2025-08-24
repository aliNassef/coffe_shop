import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../helpers/failure.dart';

abstract class UserRepo {
  Future<Either<Failure, String>> getUserAddress();
  Future<Either<Failure, Position>> getUserCoardinates();
}
