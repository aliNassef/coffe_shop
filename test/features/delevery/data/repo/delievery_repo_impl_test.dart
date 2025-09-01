import 'package:coffe_shop/core/helpers/failure.dart';
import 'package:coffe_shop/core/helpers/firestore_helper.dart';
import 'package:coffe_shop/core/helpers/location_helper.dart';
import 'package:coffe_shop/features/delevery/data/model/deleivery_model.dart';
import 'package:coffe_shop/features/delevery/data/repo/delievery_repo_impl.dart';
import 'package:coffe_shop/features/order/data/models/order_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delievery_repo_impl_test.mocks.dart';

@GenerateMocks([FirestoreHelper, LocationHelper])
void main() {
  late DelieveryRepoImpl delieveryRepoImpl;
  late MockFirestoreHelper mockFirestoreHelper;
  late MockLocationHelper mockLocationHelper;

  setUp(() {
    mockFirestoreHelper = MockFirestoreHelper();
    mockLocationHelper = MockLocationHelper();
    delieveryRepoImpl = DelieveryRepoImpl(
      firestoreHelper: mockFirestoreHelper,
      locationHelper: mockLocationHelper,
    );
  });

  // Test data
  const tOrderId = 'order123';
  final tDeleiveryModel = DeleiveryModel(
    deliveryId: 'delivery123',
    deliveryLat: 1.0,
    deliveryLong: 1.0,
    deliveryName: 'Test Delivery',
    deliveryPhone: '1234567890',
    status: 'pending',
  );
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
  final tOrderList = [tOrderModel];
  final tPosition = Position(
    latitude: 1.0,
    longitude: 1.0,
    timestamp: DateTime.now(),
    accuracy: 1.0,
    altitude: 1.0,
    altitudeAccuracy: 1.0,
    heading: 1.0,
    headingAccuracy: 1.0,
    speed: 1.0,
    speedAccuracy: 1.0,
  );
  const tLat1 = 1.0;
  const tLong1 = 1.0;
  const tLat2 = 2.0;
  const tLong2 = 2.0;
  const tDistance = 157249.38; // Example distance
  const tStart = LatLng(tLat1, tLong1);
  const tEnd = LatLng(tLat2, tLong2);
  final tPolylines = {const Polyline(polylineId: PolylineId('1'))};
  final tException = Exception('Something went wrong');
  final tFailure = Failure(errMessage: tException.toString());

  group('actionOnOrder', () {
    test(
      'should return Right(null) when firestore helper call is successful',
      () async {
        // Arrange
        when(
          mockFirestoreHelper.acceptOrder(
            deleveryModel: anyNamed('deleveryModel'),
            orderId: anyNamed('orderId'),
          ),
        ).thenAnswer((_) async => Future.value());

        // Act
        final result = await delieveryRepoImpl.actionOnOrder(
          deleiveryModel: tDeleiveryModel,
          orderId: tOrderId,
        );

        // Assert
        expect(result, const Right(null));
        verify(
          mockFirestoreHelper.acceptOrder(
            deleveryModel: tDeleiveryModel,
            orderId: tOrderId,
          ),
        );
        verifyNoMoreInteractions(mockFirestoreHelper);
      },
    );

    test(
      'should return Left(Failure) when firestore helper call fails',
      () async {
        // Arrange
        when(
          mockFirestoreHelper.acceptOrder(
            deleveryModel: anyNamed('deleveryModel'),
            orderId: anyNamed('orderId'),
          ),
        ).thenThrow(tException);

        // Act
        final result = await delieveryRepoImpl.actionOnOrder(
          deleiveryModel: tDeleiveryModel,
          orderId: tOrderId,
        );

        // Assert
        expect(result, Left(tFailure));
      },
    );
  });

  group('getDeliveryOrders', () {
    test('should yield Right<List<OrderModel>> when stream is successful', () {
      // Arrange
      when(
        mockFirestoreHelper.getOrdersStream(),
      ).thenAnswer((_) => Stream.value(tOrderList));

      // Act
      final result = delieveryRepoImpl.getDeliveryOrders();

      // Assert
      expect(result, emitsInOrder([Right(tOrderList)]));
    });

    test('should yield Left<Failure> when stream throws an error', () {
      // Arrange
      when(
        mockFirestoreHelper.getOrdersStream(),
      ).thenAnswer((_) => Stream.error(tException));

      // Act
      final result = delieveryRepoImpl.getDeliveryOrders();

      // Assert
      expect(result, emitsInOrder([Left(tFailure)]));
    });
  });

  group('updateDeliveryLatLong', () {
    test(
      'should return Right(null) when firestore helper call is successful',
      () async {
        // Arrange
        when(
          mockFirestoreHelper.updateDeliveryLatLong(any, any, any),
        ).thenAnswer((_) async => Future.value());

        // Act
        final result = await delieveryRepoImpl.updateDeliveryLatLong(
          lat: tLat1,
          long: tLong1,
          orderId: tOrderId,
        );

        // Assert
        expect(result, const Right(null));
        verify(
          mockFirestoreHelper.updateDeliveryLatLong(tLat1, tLong1, tOrderId),
        );
      },
    );

    test(
      'should return Left(Failure) when firestore helper call fails',
      () async {
        // Arrange
        when(
          mockFirestoreHelper.updateDeliveryLatLong(any, any, any),
        ).thenThrow(tException);

        // Act
        final result = await delieveryRepoImpl.updateDeliveryLatLong(
          lat: tLat1,
          long: tLong1,
          orderId: tOrderId,
        );

        // Assert
        expect(result, Left(tFailure));
      },
    );
  });

  group('changeOrderStatus', () {
    const tStatus = 'delivered';
    test(
      'should return Right(null) when firestore helper call is successful',
      () async {
        // Arrange
        when(
          mockFirestoreHelper.changeOrderStatus(
            orderId: anyNamed('orderId'),
            status: anyNamed('status'),
          ),
        ).thenAnswer((_) async => Future.value());

        // Act
        final result = await delieveryRepoImpl.changeOrderStatus(
          tOrderId,
          tStatus,
        );

        // Assert
        expect(result, const Right(null));
        verify(
          mockFirestoreHelper.changeOrderStatus(
            orderId: tOrderId,
            status: tStatus,
          ),
        );
      },
    );

    test(
      'should return Left(Failure) when firestore helper call fails',
      () async {
        // Arrange
        when(
          mockFirestoreHelper.changeOrderStatus(
            orderId: anyNamed('orderId'),
            status: anyNamed('status'),
          ),
        ).thenThrow(tException);

        // Act
        final result = await delieveryRepoImpl.changeOrderStatus(
          tOrderId,
          tStatus,
        );

        // Assert
        expect(result, Left(tFailure));
      },
    );
  });

  group('getDeliveryPosition', () {
    test('should yield Right<Position> when location stream is successful', () {
      // Arrange
      when(
        mockLocationHelper.getPositionStream(),
      ).thenAnswer((_) => Stream.value(tPosition));

      // Act
      final result = delieveryRepoImpl.getDeliveryPosition();

      // Assert
      expect(result, emitsInOrder([Right(tPosition)]));
    });

    test('should yield Left<Failure> when location stream throws an error', () {
      // Arrange
      when(
        mockLocationHelper.getPositionStream(),
      ).thenAnswer((_) => Stream.error(tException));

      // Act
      final result = delieveryRepoImpl.getDeliveryPosition();

      // Assert
      expect(result, emitsInOrder([Left(tFailure)]));
    });
  });

  group('getDiffDistance', () {
    test('should return the distance calculated by LocationHelper', () {
      // Arrange
      when(
        mockLocationHelper.getDiffDistance(any, any, any, any),
      ).thenReturn(tDistance);

      // Act
      final result = delieveryRepoImpl.getDiffDistance(
        lat1: tLat1,
        long1: tLong1,
        lat2: tLat2,
        long2: tLong2,
      );

      // Assert
      expect(result, tDistance);
      verify(mockLocationHelper.getDiffDistance(tLat1, tLong1, tLat2, tLong2));
    });
  });

  group('drawPolylineCoordinates', () {
    test(
      'should return Right<Set<Polyline>> when location helper is successful',
      () async {
        // Arrange
        when(
          mockLocationHelper.getPolylineCoordinates(
            start: anyNamed('start'),
            end: anyNamed('end'),
          ),
        ).thenAnswer((_) async => tPolylines);

        // Act
        final result = await delieveryRepoImpl.drawPolylineCoordinates(
          start: tStart,
          end: tEnd,
        );

        // Assert
        expect(result, Right(tPolylines));
        verify(
          mockLocationHelper.getPolylineCoordinates(start: tStart, end: tEnd),
        );
      },
    );

    test('should return Left<Failure> when location helper fails', () async {
      // Arrange
      when(
        mockLocationHelper.getPolylineCoordinates(
          start: anyNamed('start'),
          end: anyNamed('end'),
        ),
      ).thenThrow(tException);

      // Act
      final result = await delieveryRepoImpl.drawPolylineCoordinates(
        start: tStart,
        end: tEnd,
      );

      // Assert
      expect(result, Left(tFailure));
    });
  });
}
