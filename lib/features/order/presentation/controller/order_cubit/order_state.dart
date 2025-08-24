part of 'order_cubit.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
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
