import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/repo/home_repo.dart';
import 'package:meta/meta.dart';

import '../../../data/model/coffe_model.dart';

part 'coffe_state.dart';

class CoffeCubit extends Cubit<CoffeState> {
  CoffeCubit(this._homeRepo) : super(CoffeInitial());
  final HomeRepo _homeRepo;
  void getCoffees() async {
    emit(CoffeLoading());
    final coffesOrFailure = await _homeRepo.getAllCoffees();
    coffesOrFailure.fold(
      (failure) {
        emit(CoffeError(failure.errMessage));
      },
      (coffees) {
        emit(CoffeSuccess(coffees));
      },
    );
  }

  void getCoffeeById(String coffeeId) async {
    emit(CoffeLoading());
    final coffeeOrFailure = await _homeRepo.getCoffeeById(coffeeId);
    coffeeOrFailure.fold(
      (failure) {
        emit(CoffeError(failure.errMessage));
      },
      (coffee) {
        emit(CoffeSuccess([coffee!]));
      },
    );
  }
}
