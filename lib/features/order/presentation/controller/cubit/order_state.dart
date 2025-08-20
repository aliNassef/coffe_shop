part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class GetuserLocationLoading extends OrderState {}

final class GetuserLocationLoaded extends OrderState {
  final String address;

  GetuserLocationLoaded({required this.address});
}

final class GetuserLocationFailed extends OrderState {
  final String error;

  GetuserLocationFailed({required this.error});
}

final class UpdateUserAddressState extends OrderState {
  final String address;

  UpdateUserAddressState({required this.address});
}
