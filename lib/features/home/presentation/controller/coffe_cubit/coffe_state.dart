part of 'coffe_cubit.dart';

@immutable
sealed class CoffeState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CoffeInitial extends CoffeState {}

final class CoffeLoading extends CoffeState {}

final class CoffeSuccess extends CoffeState {
  final List<CoffeeModel> coffees;

  CoffeSuccess(this.coffees);
  @override
  List<Object?> get props => [coffees];
}

final class CoffeError extends CoffeState {
  final String errMessage;

  CoffeError(this.errMessage);
  @override
  List<Object?> get props => [errMessage];
}
