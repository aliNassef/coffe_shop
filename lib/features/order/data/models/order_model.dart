import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../home/data/model/coffe_model.dart';

class OrderModel extends Equatable {
  final String orderId;
  final String userId;
  final String userName;
  final String userPhone;
  final double userLat;
  final double userLong;
  final String status;
  final DateTime createdAt;
  final String? deliveryId;
  final String? deliveryName;
  final String? deliveryPhone;
  final double? deliveryLat;
  final double? deliveryLong;
  final List<CoffeeModel> coffees;

  const OrderModel({
    required this.orderId,
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.userLat,
    required this.userLong,
    required this.status,
    required this.createdAt,
    this.deliveryId,
    this.deliveryName,
    this.deliveryPhone,
    this.deliveryLat,
    this.deliveryLong,
    required this.coffees,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json, String id) {
    return OrderModel(
      orderId: id,
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userPhone: json['userPhone'] ?? '',
      userLat: (json['userLat'] ?? 0).toDouble(),
      userLong: (json['userLong'] ?? 0).toDouble(),
      status: json['status'] ?? 'pending',
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      deliveryId: json['deliveryId'] ?? '',
      deliveryName: json['deliveryName'] ?? '',
      deliveryPhone: json['deliveryPhone'] ?? '',
      deliveryLat: (json['deliveryLat'] ?? 0).toDouble(),
      deliveryLong: (json['deliveryLong'] ?? 0).toDouble(),
      coffees: (json['coffees'] as List<dynamic>)
          .map((c) => CoffeeModel.fromJson(c))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'userPhone': userPhone,
      'userLat': userLat,
      'userLong': userLong,
      'status': status,
      'createdAt': createdAt,
      'deliveryId': deliveryId,
      'deliveryName': deliveryName,
      'deliveryPhone': deliveryPhone,
      'deliveryLat': deliveryLat,
      'deliveryLong': deliveryLong,
      'coffees': coffees.map((c) => c.toJson()).toList(),
    };
  }

  double calcTotalPrice() {
    double totalPrice = 0;
    for (var coffee in coffees) {
      totalPrice += coffee.price;
    }
    return totalPrice;
  }

  @override
  List<Object?> get props => [
    orderId,
    userId,
    userName,
    userPhone,
    userLat,
    userLong,
    status,
    createdAt,
    deliveryId,
    deliveryName,
    deliveryPhone,
    deliveryLat,
    deliveryLong,
    coffees,
  ];
}
