import 'package:coffe_shop/core/helpers/fireauth_helper.dart';
import 'package:coffe_shop/core/helpers/firestore_helper.dart';
import 'package:coffe_shop/features/auth/data/models/user_model.dart';

import '../helpers/failure.dart';
import 'user_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../helpers/location_helper.dart';

class UserRepoImpl extends UserRepo {
  final LocationHelper _locationHelper;
  final FireauthHelper _fireauthHelper;
  final FirestoreHelper _firestoreHelper;
  UserRepoImpl({
    required LocationHelper locationHelper,
    required FireauthHelper fireauthHelper,
    required FirestoreHelper firestoreHelper,
  }) : _fireauthHelper = fireauthHelper,
       _locationHelper = locationHelper,
       _firestoreHelper = firestoreHelper;

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

  @override
  String getuserId() {
    final userId = _fireauthHelper.getCurrentUserId();
    return userId ?? '';
  }

  @override
  Future<Either<Failure, UserModel>> getUser(String id) async {
    try {
      final user = await _firestoreHelper.getUserById(id);
      return Right(user!);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
