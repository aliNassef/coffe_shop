class DeleiveryModel {
  final String deliveryId;
  final String deliveryName;
  final String deliveryPhone;
  final double deliveryLat;
  final double deliveryLong;
  final String status;

  DeleiveryModel({
    required this.deliveryId,
    required this.deliveryName,
    required this.deliveryPhone,
    required this.deliveryLat,
    required this.deliveryLong,
    required this.status,
  });
  factory DeleiveryModel.fromJson(Map<String, dynamic> json) {
    return DeleiveryModel(
      deliveryId: json['deliveryId'],
      deliveryName: json['deliveryName'],
      deliveryPhone: json['deliveryPhone'],
      deliveryLat: json['deliveryLat'],
      deliveryLong: json['deliveryLong'],
      status: json['status'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'deliveryId': deliveryId,
      'deliveryName': deliveryName,
      'deliveryPhone': deliveryPhone,
      'deliveryLat': deliveryLat,
      'deliveryLong': deliveryLong,
      'status': status,
    };
  }
}
