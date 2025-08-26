import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/order_model.dart';
import '../../../data/repo/order_repo.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.__orderRepo) : super(OrderInitial());
  final OrderRepo __orderRepo;

  Future<void> addOrder(OrderModel order) async {
    emit(AddorderLoading());
    final addOrderOrFailure = await __orderRepo.addOrder(order);
    addOrderOrFailure.fold(
      (failure) => emit(AddorderFailed(errMessage: failure.errMessage)),
      (success) => emit(AddorderSuccess()),
    );
  }

  void getUserOrders() async {
    emit(GetUserOrdersLoading());
    final getUserOrdersOrFailure = await __orderRepo.getUserOrders();
    getUserOrdersOrFailure.fold(
      (failure) => emit(GetUserOrdersFailed(errMessage: failure.errMessage)),
      (success) => emit(GetUserOrdersSuccess(orders: success)),
    );
  }
}
