part of 'get_order_position_bloc.dart';

sealed class GetOrderPositionState extends Equatable {
  const GetOrderPositionState();

  @override
  List<Object> get props => [];
}

final class GetOrderPositionInitial extends GetOrderPositionState {}

final class GetOrderPositionLoading extends GetOrderPositionState {}

final class GetOrderPositionLoaded extends GetOrderPositionState {
  final LatLng position;
  const GetOrderPositionLoaded({required this.position});
  @override
  List<Object> get props => [position];
}

final class GetOrderPositionFailure extends GetOrderPositionState {
  final String errMessage;
  const GetOrderPositionFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
