part of 'coffe_cubit.dart';

@immutable
sealed class CoffeState {}

final class CoffeInitial extends CoffeState {}

final class CoffeLoading extends CoffeState {}

final class CoffeSuccess extends CoffeState {
  final List<CoffeeModel> coffees;

  CoffeSuccess(this.coffees);
}

final class CoffeError extends CoffeState {
  final String errMessage;

  CoffeError(this.errMessage);
}
