import 'package:bloc/bloc.dart';
import 'package:coffe_shop/features/order/data/repo/order_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'get_order_position_event.dart';
part 'get_order_position_state.dart';

class GetOrderPositionBloc
    extends Bloc<GetOrderPositionEvent, GetOrderPositionState> {
  final OrderRepo _orderRepo;
  GetOrderPositionBloc(this._orderRepo) : super(GetOrderPositionInitial()) {
    on<GetOrderPosition>((event, emit) async {
      emit(GetOrderPositionLoading());

      final result = await _orderRepo.getDeliveryPosition(
        orderId: event.orderId,
      );
      result.fold(
        (failure) =>
            emit(GetOrderPositionFailure(errMessage: failure.errMessage)),
        (position) => emit(GetOrderPositionLoaded(position: position)),
      );
    });
    on<DrawPolylineEvent>((event, emit) async {
      final polylinesOrFailure = await _orderRepo.drawPolylineCoordinates(
        start: event.source,
        end: event.destination,
      );
      polylinesOrFailure.fold(
        (failure) =>
            emit(GetOrderPositionFailure(errMessage: failure.errMessage)),
        (polylines) => emit(DrawPolylineState(polylines: polylines)),
      );
    });
  }
}
