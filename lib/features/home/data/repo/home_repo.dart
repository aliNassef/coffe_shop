import 'package:dartz/dartz.dart';

import '../../../../core/helpers/failure.dart';
import '../model/coffe_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<CoffeeModel>>> getAllCoffees();
  Future<Either<Failure, List<CoffeeModel>>> searchOnCoffees(String query);
  Future<Either<Failure, CoffeeModel?>> getCoffeeById(String id);
  Future<Either<Failure, String>> getUserLocation();
}
