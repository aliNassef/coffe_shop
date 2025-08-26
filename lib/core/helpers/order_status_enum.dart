enum OrderStatus { pending, accepted, rejected, delivered, onTheWay }

extension OrderStatusExtension on OrderStatus {
  String get name => toString().split('.').last;
}

String getOrderStatusName(OrderStatus status) {
  switch (status) {
    case OrderStatus.pending:
      return 'Pending';
    case OrderStatus.accepted:
      return 'Accepted';
    case OrderStatus.rejected:
      return 'Rejected';
    case OrderStatus.delivered:
      return 'Delivered';
    case OrderStatus.onTheWay:
      return 'On The Way';
  }
}
