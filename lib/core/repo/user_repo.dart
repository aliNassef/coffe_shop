import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../../features/auth/data/models/user_model.dart';
import '../helpers/failure.dart';

abstract class UserRepo {
  Future<Either<Failure, String>> getUserAddress();
  Future<Either<Failure, Position>> getUserCoardinates();
  String getuserId();
  Future<Either<Failure, UserModel>> getUser(String id);
}
