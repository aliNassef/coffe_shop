import 'package:coffe_shop/core/helpers/failure.dart';
import 'package:coffe_shop/core/helpers/firestore_helper.dart';
import 'package:coffe_shop/core/helpers/location_helper.dart';
import 'package:coffe_shop/features/order/data/models/order_model.dart';
import 'package:coffe_shop/features/order/data/repo/order_repo_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../delevery/data/repo/delievery_repo_impl_test.mocks.dart';

@GenerateMocks([LocationHelper, FirestoreHelper])
void main() {
  late LocationHelper locationHelper;
  late FirestoreHelper firestoreHelper;
  late OrderRepoImpl orderRepoImpl;
  setUp(() {
    locationHelper = MockLocationHelper();
    firestoreHelper = MockFirestoreHelper();
    orderRepoImpl = OrderRepoImpl(
      locationHelper: locationHelper,
      firestoreHelper: firestoreHelper,
    );
  });

  final tOrderModel = OrderModel(
    orderId: 'order123',
    userId: 'user123',
    coffees: [],
    status: 'pending',
    createdAt: DateTime.now(),
    userName: 'Test User',
    userLat: 1.0,
    userLong: 1.0,
    userPhone: '1234567890',
    deliveryId: 'delivery123',
    deliveryLat: 1.0,
    deliveryLong: 1.0,
    deliveryName: 'Test Delivery',
    deliveryPhone: '1234567890',
  );
  final tFailure = Failure(errMessage: 'Exception: Error adding order');

  group('add order', () {
    test(
      'add order should call firestore helper with correct arguments and return success',
      () async {
        when(
          firestoreHelper.addOrder(tOrderModel),
        ).thenAnswer((_) async => right(null));

        final result = await orderRepoImpl.addOrder(tOrderModel);
        expect(result, right(null));
        verify(firestoreHelper.addOrder(tOrderModel)).called(1);
      },
    );
    test(
      'add order should call firestore helper with correct arguments and return failure',
      () async {
        when(
          firestoreHelper.addOrder(tOrderModel),
        ).thenAnswer((_) async => throw Exception('Error adding order'));

        final result = await orderRepoImpl.addOrder(tOrderModel);
        expect(result, left(tFailure));
        verify(firestoreHelper.addOrder(tOrderModel)).called(1);
      },
    );
  });

  group('getUserOrders', () {
    test(
      'getUserOrders should call firestore helper and return success',
      () async {
        when(
          firestoreHelper.getAllOrders(),
        ).thenAnswer((_) async => [tOrderModel]);
        final result = await orderRepoImpl.getUserOrders();
        expect(result.getOrElse(() => []), [tOrderModel]);
        verify(firestoreHelper.getAllOrders()).called(1);
      },
    );
    test(
      'getUserOrders should call firestore helper and return failure',
      () async {
        final tException = Exception('Error getting orders');
        when(firestoreHelper.getAllOrders()).thenThrow(tException);
        final result = await orderRepoImpl.getUserOrders();
        expect(result, left(Failure(errMessage: tException.toString())));
        verify(firestoreHelper.getAllOrders()).called(1);
      },
    );
  });

  group('getDeliveryPosition', () {
    const tOrderId = 'order123';
    final tLatLng = LatLng(tOrderModel.deliveryLat!, tOrderModel.deliveryLong!);
    final tException = Exception('Error getting order');

    test(
      'should return LatLng when firestore helper returns an order successfully',
      () async {
        // Arrange
        when(firestoreHelper.getOrderById(tOrderId))
            .thenAnswer((_) async => tOrderModel);
        // Act
        final result =
            await orderRepoImpl.getDeliveryPosition(orderId: tOrderId);
        // Assert
        expect(result, right(tLatLng));
        verify(firestoreHelper.getOrderById(tOrderId)).called(1);
      },
    );

    test(
      'should return Failure when firestore helper throws an exception',
      () async {
        // Arrange
        when(firestoreHelper.getOrderById(tOrderId)).thenThrow(tException);
        // Act
        final result =
            await orderRepoImpl.getDeliveryPosition(orderId: tOrderId);
        // Assert
        expect(result, left(Failure(errMessage: tException.toString())));
        verify(firestoreHelper.getOrderById(tOrderId)).called(1);
      },
    );

    test(
      'should return Failure when firestore helper returns null',
      () async {
        // Arrange
        when(firestoreHelper.getOrderById(tOrderId))
            .thenAnswer((_) async => null);
        // Act
        final result =
            await orderRepoImpl.getDeliveryPosition(orderId: tOrderId);
        // Assert
        expect(result.isLeft(), isTrue);
        verify(firestoreHelper.getOrderById(tOrderId)).called(1);
      },
    );
  });

  group('drawPolylineCoordinates', () {
    const tStart = LatLng(1.0, 1.0);
    const tEnd = LatLng(2.0, 2.0);
    final tPolylines = {const Polyline(polylineId: PolylineId('route'))};
    final tException = Exception('Error drawing polyline');

    test(
      'should return a set of polylines when location helper is successful',
      () async {
        // Arrange
        when(locationHelper.getPolylineCoordinates(start: tStart, end: tEnd))
            .thenAnswer((_) async => tPolylines);
        // Act
        final result =
            await orderRepoImpl.drawPolylineCoordinates(start: tStart, end: tEnd);
        // Assert
        expect(result, right(tPolylines));
        verify(locationHelper.getPolylineCoordinates(start: tStart, end: tEnd))
            .called(1);
      },
    );

    test(
      'should return Failure when location helper throws an exception',
      () async {
        // Arrange
        when(locationHelper.getPolylineCoordinates(start: tStart, end: tEnd))
            .thenThrow(tException);
        // Act
        final result =
            await orderRepoImpl.drawPolylineCoordinates(start: tStart, end: tEnd);
        // Assert
        expect(result, left(Failure(errMessage: tException.toString())));
        verify(locationHelper.getPolylineCoordinates(start: tStart, end: tEnd))
            .called(1);
      },
    );
  });
}
