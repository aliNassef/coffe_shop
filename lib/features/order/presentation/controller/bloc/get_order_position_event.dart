part of 'get_order_position_bloc.dart';

sealed class GetOrderPositionEvent extends Equatable {
  const GetOrderPositionEvent();

  @override
  List<Object> get props => [];
}

final class GetOrderPosition extends GetOrderPositionEvent {
  final String orderId;
  const GetOrderPosition({required this.orderId});
  @override
  List<Object> get props => [orderId];

}
