part of 'coffe_search_bloc.dart';

@immutable
sealed class CoffeSearchEvent {}

final class CoffeSearchQueryChanged extends CoffeSearchEvent {
  final String query;

  CoffeSearchQueryChanged(this.query);
}
