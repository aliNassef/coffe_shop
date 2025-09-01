import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:coffe_shop/core/helpers/failure.dart';
import 'package:coffe_shop/features/delevery/data/repo/delievery_repo.dart';
import 'package:coffe_shop/features/delevery/presentation/controller/cubit/delivery_cubit.dart';
import 'package:coffe_shop/features/order/data/models/order_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delivery_cubit_test.mocks.dart';

@GenerateMocks([DelieveryRepo])
void main() {
  late DeliveryCubit deliveryCubit;
  late MockDelieveryRepo mockDelieveryRepo;

  setUp(() {
    mockDelieveryRepo = MockDelieveryRepo();
    deliveryCubit = DeliveryCubit(mockDelieveryRepo);
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
  final tFailure = Failure(errMessage: 'Error getting delievery orders');
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
  group('getDelieveryOrders', () {
    blocTest(
      'emits [DelieveryLoading , DelieveryLoaded] when getDelievery is called successfully',
      build: () {
        when(
          mockDelieveryRepo.getDeliveryOrders(),
        ).thenAnswer((_) => Stream.value(Right([tOrderModel])));
        return deliveryCubit;
      },
      act: (cubit) => cubit.getDeliveryOrrders(),
      expect: () => [
        DeliveryLoading(),
        DeliveryLoaded(orders: [tOrderModel]),
      ],
    );

    blocTest(
      'emits [DelieveryLoading , DelieveryError] when getDelievery is called failure',
      build: () {
        when(
          mockDelieveryRepo.getDeliveryOrders(),
        ).thenAnswer((_) => Stream.value(left(tFailure)));
        return deliveryCubit;
      },
      act: (cubit) => cubit.getDeliveryOrrders(),
      expect: () => [
        DeliveryLoading(),
        DeliveryFailure(errMessage: tFailure.errMessage),
      ],
    );
  });

  group('getDeliveryPosition  ', () {
    blocTest(
      'emits [DeliveryGetPositionLoadedState] when getDeliveryPosition is called successfully',
      build: () {
        when(
          mockDelieveryRepo.getDeliveryPosition(),
        ).thenAnswer((_) => Stream.value(Right(tPosition)));
        return deliveryCubit;
      },
      act: (cubit) => cubit.getDeliveryPosition(),
      expect: () => [
        DeliveryGetPositionLoadedState(
          position: LatLng(tPosition.latitude, tPosition.longitude),
        ),
      ],
    );

    blocTest(
      'emits [DeliveryFailure] when getDeliveryPosition is called successfully',
      build: () {
        when(
          mockDelieveryRepo.getDeliveryPosition(),
        ).thenAnswer((_) => Stream.value(left(tFailure)));
        return deliveryCubit;
      },
      act: (cubit) => cubit.getDeliveryPosition(),
      expect: () => [DeliveryFailure(errMessage: tFailure.errMessage)],
    );
  });
}
