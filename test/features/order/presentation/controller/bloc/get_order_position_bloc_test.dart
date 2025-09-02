import 'package:coffe_shop/core/helpers/failure.dart';
import 'package:coffe_shop/features/order/data/repo/order_repo.dart';
import 'package:coffe_shop/features/order/presentation/controller/bloc/get_order_position_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';

import 'get_order_position_bloc_test.mocks.dart';

// Mock classes
@GenerateMocks([OrderRepo])
void main() {
  late MockOrderRepo mockOrderRepo;
  late GetOrderPositionBloc bloc;

  setUp(() {
    mockOrderRepo = MockOrderRepo();
    bloc = GetOrderPositionBloc(mockOrderRepo);
  });

  group('GetOrderPositionBloc', () {
    const orderId = 'order123';
    final position = LatLng(10.0, 20.0);
    final failure = Failure(errMessage: 'Error occurred');
    final polylines = <Polyline>{Polyline(polylineId: PolylineId('1'))};

    blocTest<GetOrderPositionBloc, GetOrderPositionState>(
      'emits [Loading, Loaded] when getDeliveryPosition succeeds',
      build: () {
        when(
          mockOrderRepo.getDeliveryPosition(orderId: orderId),
        ).thenAnswer((_) async => Right(position));
        return bloc;
      },
      act: (bloc) => bloc.add(GetOrderPosition(orderId: orderId)),
      expect: () => [
        GetOrderPositionLoading(),
        GetOrderPositionLoaded(position: position),
      ],
    );

    blocTest<GetOrderPositionBloc, GetOrderPositionState>(
      'emits [Loading, Failure] when getDeliveryPosition fails',
      build: () {
        when(
          mockOrderRepo.getDeliveryPosition(orderId: orderId),
        ).thenAnswer((_) async => Left(failure));
        return bloc;
      },
      act: (bloc) => bloc.add(GetOrderPosition(orderId: orderId)),
      expect: () => [
        GetOrderPositionLoading(),
        GetOrderPositionFailure(errMessage: failure.errMessage),
      ],
    );

    blocTest<GetOrderPositionBloc, GetOrderPositionState>(
      'emits [DrawPolylineState] when drawPolylineCoordinates succeeds',
      build: () {
        when(
          mockOrderRepo.drawPolylineCoordinates(start: position, end: position),
        ).thenAnswer((_) async => Right(polylines));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(DrawPolylineEvent(source: position, destination: position)),
      expect: () => [DrawPolylineState(polylines: polylines)],
    );

    blocTest<GetOrderPositionBloc, GetOrderPositionState>(
      'emits [Failure] when drawPolylineCoordinates fails',
      build: () {
        when(
          mockOrderRepo.drawPolylineCoordinates(start: position, end: position),
        ).thenAnswer((_) async => Left(failure));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(DrawPolylineEvent(source: position, destination: position)),
      expect: () => [GetOrderPositionFailure(errMessage: failure.errMessage)],
    );
  });
}
