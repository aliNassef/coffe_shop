part of 'get_user_location_cubit.dart';

@immutable
sealed class GetUserLocationState extends Equatable {
  const GetUserLocationState();

  @override
  List<Object> get props => [];
}

final class GetUserLocationInitial extends GetUserLocationState {}

final class GetUserLocationLoading extends GetUserLocationState {}

final class GetUserLocationLoaded extends GetUserLocationState {
  final String position;

  const GetUserLocationLoaded({required this.position});
  @override
  List<Object> get props => [position];
}

final class GetUserLocationFailure extends GetUserLocationState {
  final String errMessage;

  const GetUserLocationFailure({required this.errMessage});
  @override
  List<Object> get props => [errMessage];
}
