part of 'order_cubit.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class GetUserOrdersLoading extends OrderState {
  const GetUserOrdersLoading();

  @override
  List<Object> get props => [];
}

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

final class OrderInitial extends OrderState {
  const OrderInitial();
  @override
  List<Object> get props => [];
}

final class AddorderLoading extends OrderState {
  const AddorderLoading();

  @override
  List<Object> get props => [];
}

final class AddorderFailed extends OrderState {
  final String errMessage;
  const AddorderFailed({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

final class AddorderSuccess extends OrderState {
  const AddorderSuccess();

  @override
  List<Object> get props => [];
}

final class ChangeOrderCount extends OrderState {
  final int count;
  const ChangeOrderCount({required this.count});

  @override
  List<Object> get props => [count];
}

final class GetOrderPositonLoading extends OrderState {
  const GetOrderPositonLoading();
  @override
  List<Object> get props => [];
}

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
