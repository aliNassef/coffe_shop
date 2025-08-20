part of 'coffe_search_bloc.dart';

@immutable
sealed class CoffeSearchState {}

final class CoffeSearchInitial extends CoffeSearchState {}
final class CoffeSearchLoading extends CoffeSearchState {}
final class CoffeSearchSuccess extends CoffeSearchState {
  final List<CoffeeModel> coffees;

  CoffeSearchSuccess(this.coffees);
}
final class CoffeSearchError extends CoffeSearchState {
  final String errorMessage;

  CoffeSearchError(this.errorMessage);
}
