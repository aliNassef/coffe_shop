import 'user_model.dart';

class DeliveryUserModel extends UserModel {
  DeliveryUserModel({
    required super.email,
    required super.id,
    required super.name,
    required super.phoneNumber,
    required super.role,
    required this.vehicleNumber,
    required this.isAvailable,
  });
  final String vehicleNumber;
  final bool isAvailable;
  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'vehicleNumber': vehicleNumber,
      'isAvailable': isAvailable,
    };
  }
}
