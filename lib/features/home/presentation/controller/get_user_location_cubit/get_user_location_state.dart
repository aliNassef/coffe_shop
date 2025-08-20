part of 'get_user_location_cubit.dart';

@immutable
sealed class GetUserLocationState {}

final class GetUserLocationInitial extends GetUserLocationState {}

final class GetUserLocationLoading extends GetUserLocationState {}

final class GetUserLocationLoaded extends GetUserLocationState {
  final String position;

  GetUserLocationLoaded({required this.position});
}

final class GetUserLocationFailure extends GetUserLocationState {
  final String errMessage;

  GetUserLocationFailure({required this.errMessage});
}
