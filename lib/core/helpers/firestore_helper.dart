import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/home/data/model/coffe_model.dart';

import '../../features/order/data/models/order_model.dart';

class FirestoreHelper {
  Future<void> addOrder(OrderModel order) async {
    final ordersRef = FirebaseFirestore.instance.collection('orders');

    await ordersRef.doc(order.orderId).set(order.toJson());
  }

  Future<OrderModel?> getOrderById(String orderId) async {
    final doc = await FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .get();

    if (doc.exists) {
      return OrderModel.fromJson(doc.data()!, doc.id);
    }
    return null;
  }

  Future<List<OrderModel>> getAllOrders() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .get();

    return querySnapshot.docs
        .map((doc) => OrderModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<CoffeeModel?> getCoffeeById(String coffeeId) async {
    final doc = await FirebaseFirestore.instance
        .collection('coffees')
        .doc(coffeeId)
        .get();

    if (doc.exists) {
      return CoffeeModel.fromJson(doc.data()!);
    }
    return null;
  }

  Future<List<CoffeeModel>> getAllCoffees() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('coffees')
        .get();

    return querySnapshot.docs
        .map((doc) => CoffeeModel.fromJson(doc.data()))
        .toList();
  }

  Future<List<CoffeeModel>> searchCoffees(String query) async {
    final coffeesRef = FirebaseFirestore.instance.collection('coffees');

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
  }
}
