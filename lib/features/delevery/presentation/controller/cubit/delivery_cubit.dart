import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../data/repo/delievery_repo.dart';
import '../../../../order/data/models/order_model.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/deleivery_model.dart';

part 'delivery_state.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  DeliveryCubit(this._delieveryRepo) : super(DeliveryInitial());
  final DelieveryRepo _delieveryRepo;
  StreamSubscription? _streamSubscriptionOrders;
  StreamSubscription? _streamSubscriptionPosition;

  void actionOnOrder({
    required DeleiveryModel deleiveryModel,
    required String orderId,
  }) async {
    await _delieveryRepo.actionOnOrder(
      deleiveryModel: deleiveryModel,
      orderId: orderId,
    );
  }

  void getDeliveryOrrders() {
    emit(DeliveryLoading());
    _streamSubscriptionOrders?.cancel();
    _streamSubscriptionOrders = _delieveryRepo.getDeliveryOrders().listen((
      ordersOrFailure,
    ) {
      ordersOrFailure.fold(
        (failure) => emit(DeliveryFailure(errMessage: failure.errMessage)),
        (orders) => emit(DeliveryLoaded(orders: orders)),
      );
    });
  }

  void getDeliveryPosition() {
    _streamSubscriptionPosition?.cancel();
    _streamSubscriptionPosition = _delieveryRepo.getDeliveryPosition().listen((
      positionOrFailure,
    ) {
      positionOrFailure.fold(
        (failure) => emit(DeliveryFailure(errMessage: failure.errMessage)),
        (position) => emit(
          DeliveryGetPositionLoadedState(
            position: LatLng(position.latitude, position.longitude),
          ),
        ),
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

  void changeOrderStatus(String orderId, String status) async {
    await _delieveryRepo.changeOrderStatus(orderId, status);
  }

  double getDiffDistance(double lat1, double long1, double lat2, double long2) {
    return _delieveryRepo.getDiffDistance(
      lat1: lat1,
      long1: long1,
      lat2: lat2,
      long2: long2,
    );
  }

  void drawPolyLine({required LatLng start, required LatLng end}) async {
    final polylinesOrFailure = await _delieveryRepo.drawPolylineCoordinates(
      start: start,
      end: end,
    );
    polylinesOrFailure.fold(
      (failure) => emit(DeliveryFailure(errMessage: failure.errMessage)),
      (polylines) => emit(DrawPolyLineState(polylines: polylines)),
    );
  }

  @override
  Future<void> close() {
    _streamSubscriptionOrders?.cancel();
    _streamSubscriptionPosition?.cancel();
    return super.close();
  }
}
