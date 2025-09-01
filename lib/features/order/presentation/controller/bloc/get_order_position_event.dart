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

final class DrawPolylineEvent extends GetOrderPositionEvent {
  final LatLng source;
  final LatLng destination;
  const DrawPolylineEvent({required this.source, required this.destination});
  @override
  List<Object> get props => [source, destination];
}
