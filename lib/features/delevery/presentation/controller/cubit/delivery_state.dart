part of 'delivery_cubit.dart';

sealed class DeliveryState extends Equatable {
  const DeliveryState();

  @override
  List<Object> get props => [];
}

final class DeliveryInitial extends DeliveryState {}

final class DeliveryLoading extends DeliveryState {}

final class DeliveryLoaded extends DeliveryState {
  final List<OrderModel> orders;

  const DeliveryLoaded({required this.orders});
  @override
  List<Object> get props => [orders];
}

final class DeliveryFailure extends DeliveryState {
  final String errMessage;

  const DeliveryFailure({required this.errMessage});
  @override
  List<Object> get props => [errMessage];
}

final class DeliveryUpdateOrderState extends DeliveryState {
  final String status;

  const DeliveryUpdateOrderState({required this.status});
  @override
  List<Object> get props => [status];
}

final class DeliveryGetPositionLoadedState extends DeliveryState {
  final LatLng position;

  const DeliveryGetPositionLoadedState({required this.position});
  @override
  List<Object> get props => [position];
}

final class DrawPolyLineState extends DeliveryState {
  final Set<Polyline> polylines;

  const DrawPolyLineState({required this.polylines});
  @override
  List<Object> get props => [polylines];
}
