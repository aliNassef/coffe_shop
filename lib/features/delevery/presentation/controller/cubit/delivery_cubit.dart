import 'package:bloc/bloc.dart';
import 'package:coffe_shop/features/delevery/data/repo/delievery_repo.dart';
import 'package:coffe_shop/features/order/data/models/order_model.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/deleivery_model.dart';

part 'delivery_state.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  DeliveryCubit(this._delieveryRepo) : super(DeliveryInitial());
  final DelieveryRepo _delieveryRepo;

  void actionOnOrder({
    required DeleiveryModel deleiveryModel,
    required String orderId,
  }) async {
    emit(DeliveryLoading());
    final result = await _delieveryRepo.actionOnOrder(
      deleiveryModel: deleiveryModel,
      orderId: orderId,
    );
    result.fold(
      (failure) => emit(DeliveryFailure(errMessage: failure.errMessage)),
      (r) {},
    );
  }

  void getDeliveryOrrders() async {
    await for (final ordersOrFailure in _delieveryRepo.getDeliveryOrders()) {
      ordersOrFailure.fold(
        (failure) => emit(DeliveryFailure(errMessage: failure.errMessage)),
        (orders) => emit(DeliveryLoaded(orders: orders)),
      );
    }
  }
}
