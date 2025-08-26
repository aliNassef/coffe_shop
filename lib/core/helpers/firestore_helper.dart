import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_shop/features/delevery/data/model/deleivery_model.dart';
import '../../features/home/data/model/coffe_model.dart';

import '../../features/order/data/models/order_model.dart';

class FirestoreHelper {
  final FirebaseFirestore _firestore;

  FirestoreHelper({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addOrder(OrderModel order) async {
    try {
      final ordersRef = _firestore.collection('orders');

      await ordersRef.doc(order.orderId).set(order.toJson());
    } catch (e) {
      throw Exception('Error adding order: $e');
    }
  }

  Future<OrderModel?> getOrderById(String orderId) async {
    try {
      final doc = await _firestore.collection('orders').doc(orderId).get();

      if (doc.exists) {
        return OrderModel.fromJson(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Error fetching order: $e');
    }
  }

  Future<List<OrderModel>> getAllOrders() async {
    try {
      final querySnapshot = await _firestore.collection('orders').get();

      return querySnapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Error fetching orders: $e');
    }
  }

  Future<CoffeeModel?> getCoffeeById(String coffeeId) async {
    final doc = await _firestore.collection('coffees').doc(coffeeId).get();

    if (doc.exists) {
      return CoffeeModel.fromJson(doc.data()!);
    }
    return null;
  }

  Future<List<CoffeeModel>> getAllCoffees() async {
    try {
      final querySnapshot = await _firestore.collection('coffees').get();

      return querySnapshot.docs
          .map((doc) => CoffeeModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error fetching coffees: $e');
    }
  }

  Future<List<CoffeeModel>> searchCoffees(String query) async {
    try {
      final coffeesRef = _firestore.collection('coffees');

      final snapshot = await coffeesRef
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      final typeSnapshot = await coffeesRef
          .where('type', isGreaterThanOrEqualTo: query)
          .where('type', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      final allDocs = [...snapshot.docs, ...typeSnapshot.docs];

      final uniqueDocs = {for (var doc in allDocs) doc.id: doc}.values.toList();

      return uniqueDocs.map((doc) => CoffeeModel.fromJson(doc.data())).toList();
    } catch (e) {
      throw Exception('Error searching coffees: $e');
    }
  }

  Stream<List<OrderModel>> getOrdersStream() {
    try {
      return _firestore.collection('orders').snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => OrderModel.fromJson(doc.data(), doc.id))
            .toList();
      });
    } catch (e) {
      throw Exception('Error fetching orders: $e');
    }
  }

  Future<void> acceptOrder({
    required DeleiveryModel deleveryModel,
    required String orderId,
  }) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'deliveryId': deleveryModel.deliveryId,
        'deliveryName': deleveryModel.deliveryName,
        'deliveryPhone': deleveryModel.deliveryPhone,
        'status': deleveryModel.status,
      });
    } catch (e) {
      throw Exception('Error accepting order: $e');
    }
  }
}
