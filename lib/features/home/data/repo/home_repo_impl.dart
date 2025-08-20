import '../../../../core/helpers/failure.dart';

import '../model/coffe_model.dart';

import 'package:dartz/dartz.dart';
import '../../../../core/helpers/firestore_helper.dart';
import '../../../../core/helpers/location_helper.dart';
import 'home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final FirestoreHelper _firestoreHelper;
  final LocationHelper _locationHelper;

  HomeRepoImpl({
    required FirestoreHelper firestoreHelper,
    required LocationHelper locationHelper,
  }) : _locationHelper = locationHelper,
       _firestoreHelper = firestoreHelper;

  @override
  Future<Either<Failure, List<CoffeeModel>>> getAllCoffees() async {
    try {
      final coffes = await _firestoreHelper.getAllCoffees();
      return Right(coffes);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CoffeeModel?>> getCoffeeById(String id) async {
    try {
      final coffee = await _firestoreHelper.getCoffeeById(id);
      return Right(coffee);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CoffeeModel>>> searchOnCoffees(
    String query,
  ) async {
    try {
      final coffees = await _firestoreHelper.searchCoffees(query);
      return Right(coffees);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getUserLocation() async {
    try {
      final position = await _locationHelper.getCurrentLocation();
      return Right(position);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
