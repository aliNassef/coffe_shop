part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserIntial extends UserState {}

final class GetuserLocationLoadingState extends UserState {}

final class GetuserLocationLoadedState extends UserState {
  final String address;

  GetuserLocationLoadedState({required this.address});
}

final class GetuserPositonLoadedState extends UserState {
  final Position position;

  GetuserPositonLoadedState({required this.position});
}

final class GetuserPositonFailed extends UserState {
  final String error;

  GetuserPositonFailed({required this.error});
}

final class GetuserPositonLoadingState extends UserState {}

final class GetuserLocationFailed extends UserState {
  final String error;

  GetuserLocationFailed({required this.error});
}

final class UpdateUserAddressState extends UserState {
  final String address;

  UpdateUserAddressState({required this.address});
}
