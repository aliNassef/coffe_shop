part of 'user_cubit.dart';

@immutable
sealed class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class UserIntial extends UserState {
  @override
  List<Object?> get props => [];
}

final class GetuserLocationLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

final class GetuserLocationLoadedState extends UserState {
  final String address;

  GetuserLocationLoadedState({required this.address});
  @override
  List<Object?> get props => [address];
}

final class GetuserPositonLoadedState extends UserState {
  final Position position;

  GetuserPositonLoadedState({required this.position});
  @override
  List<Object?> get props => [position];
}

final class GetuserPositonFailed extends UserState {
  final String error;

  GetuserPositonFailed({required this.error});
  @override
  List<Object?> get props => [error];
}

final class GetuserPositonLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

final class GetuserLocationFailed extends UserState {
  final String error;

  GetuserLocationFailed({required this.error});
  @override
  List<Object?> get props => [error];
}

final class UpdateUserAddressState extends UserState {
  final String address;

  UpdateUserAddressState({required this.address});
  @override
  List<Object?> get props => [address];
}

final class GetUserLoading extends UserState {
  @override
  List<Object?> get props => [];
}

final class GetUserLoaded extends UserState {
  final UserModel? user;

  GetUserLoaded({this.user}ear );
  @override
  List<Object?> get props => [user];
}

final class GetUserFailed extends UserState {
  final String error;

  GetUserFailed({required this.error});
  @override
  List<Object?> get props => [error];
}
