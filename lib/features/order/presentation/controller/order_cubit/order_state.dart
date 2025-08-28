part of 'order_cubit.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class GetUserOrdersLoading extends OrderState {}

final class GetUserOrdersFailed extends OrderState {
  final String errMessage;
  const GetUserOrdersFailed({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

final class GetUserOrdersSuccess extends OrderState {
  final List<OrderModel> orders;
  const GetUserOrdersSuccess({required this.orders});

  @override
  List<Object> get props => [orders];
}

final class OrderInitial extends OrderState {}

final class AddorderLoading extends OrderState {}

final class AddorderFailed extends OrderState {
  final String errMessage;
  const AddorderFailed({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

final class AddorderSuccess extends OrderState {}

final class GetOrderPositonLoading extends OrderState {}

final class GetOrderPositonLoaded extends OrderState {
  final LatLng position;
  const GetOrderPositonLoaded({required this.position});

  @override
  List<Object> get props => [position];
}

final class GetOrderPositonFailure extends OrderState {
  final String errMessage;
  const GetOrderPositonFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
