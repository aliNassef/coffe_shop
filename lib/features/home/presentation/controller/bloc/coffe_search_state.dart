part of 'coffe_search_bloc.dart';

@immutable
sealed class CoffeSearchState extends Equatable {
  const CoffeSearchState();

  @override
  List<Object> get props => [];
}

final class CoffeSearchInitial extends CoffeSearchState {}

final class CoffeSearchLoading extends CoffeSearchState {}

final class CoffeSearchSuccess extends CoffeSearchState {
  final List<CoffeeModel> coffees;

  const CoffeSearchSuccess(this.coffees);
  @override
  List<Object> get props => [coffees];
}

final class CoffeSearchError extends CoffeSearchState {
  final String errorMessage;

  const CoffeSearchError(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
