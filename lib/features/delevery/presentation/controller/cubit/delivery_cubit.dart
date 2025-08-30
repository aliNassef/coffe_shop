import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../data/repo/delievery_repo.dart';
import '../../../../order/data/models/order_model.dart';
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
    await _delieveryRepo.actionOnOrder(
      deleiveryModel: deleiveryModel,
      orderId: orderId,
    );
  }

  StreamSubscription? _streamSubscription;
  void getDeliveryOrrders() async {
    emit(DeliveryLoading());
    _streamSubscription = _delieveryRepo.getDeliveryOrders().listen((
      ordersOrFailure,
    ) {
      ordersOrFailure.fold(
        (failure) => emit(DeliveryFailure(errMessage: failure.errMessage)),
        (orders) => emit(DeliveryLoaded(orders: orders)),
      );
    });
  }

  void updateDeliveryLatLong({
    required double lat,
    required double long,
    required String orderId,
  }) async {
    await _delieveryRepo.updateDeliveryLatLong(
      lat: lat,
      long: long,
      orderId: orderId,
    );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
