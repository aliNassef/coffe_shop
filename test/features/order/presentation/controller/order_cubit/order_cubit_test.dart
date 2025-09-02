import 'package:bloc_test/bloc_test.dart';
import 'package:coffe_shop/core/helpers/failure.dart';
import 'package:coffe_shop/features/order/data/models/order_model.dart';
import 'package:coffe_shop/features/order/data/repo/order_repo.dart';
import 'package:coffe_shop/features/order/presentation/controller/order_cubit/order_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../bloc/get_order_position_bloc_test.mocks.dart';

@GenerateMocks([OrderRepo])
void main() {
  late OrderCubit orderCubit;
  late MockOrderRepo mockOrderRepo;

  final tOrderModel = OrderModel(
    orderId: 'order123',
    userId: 'user123',
    userName: 'Test User',
    userPhone: '1234567890',
    userLat: 1.0,
    userLong: 1.0,
    status: 'pending',
    createdAt: DateTime(2025, 9, 2),
    deliveryId: 'delivery123',
    deliveryName: 'Test Delivery',
    deliveryPhone: '1234567890',
    deliveryLat: 1.0,
    deliveryLong: 1.0,
    coffees: const [],
  );

  setUp(() {
    mockOrderRepo = MockOrderRepo();
    orderCubit = OrderCubit(mockOrderRepo);
  });

  tearDown(() {
    orderCubit.close();
  });

  blocTest<OrderCubit, OrderState>(
    'emits [AddorderLoading, AddorderSuccess] when addOrder succeeds',
    build: () {
      when(
        mockOrderRepo.addOrder(tOrderModel),
      ).thenAnswer((_) async => const Right(null));
      return orderCubit;
    },
    act: (cubit) => cubit.addOrder(tOrderModel),
    expect: () => [const AddorderLoading(), const AddorderSuccess()],
  );

  blocTest<OrderCubit, OrderState>(
    'emits [AddorderLoading, AddorderFailed] when addOrder fails',
    build: () {
      when(
        mockOrderRepo.addOrder(tOrderModel),
      ).thenAnswer((_) async => Left(Failure(errMessage: 'Add failed')));
      return orderCubit;
    },
    act: (cubit) => cubit.addOrder(tOrderModel),
    expect: () => [AddorderLoading(), AddorderFailed(errMessage: 'Add failed')],
  );

  blocTest<OrderCubit, OrderState>(
    'emits [GetUserOrdersLoading, GetUserOrdersSuccess] when getUserOrders succeeds',
    build: () {
      when(
        mockOrderRepo.getUserOrders(),
      ).thenAnswer((_) async => Right([tOrderModel]));
      return orderCubit;
    },
    act: (cubit) => cubit.getUserOrders(),
    expect: () => [
      GetUserOrdersLoading(),
      GetUserOrdersSuccess(orders: [tOrderModel]),
    ],
  );

  blocTest<OrderCubit, OrderState>(
    'emits [GetUserOrdersLoading, GetUserOrdersFailed] when getUserOrders fails',
    build: () {
      when(
        mockOrderRepo.getUserOrders(),
      ).thenAnswer((_) async => Left(Failure(errMessage: 'Fetch failed')));
      return orderCubit;
    },
    act: (cubit) => cubit.getUserOrders(),
    expect: () => [
      GetUserOrdersLoading(),
      GetUserOrdersFailed(errMessage: 'Fetch failed'),
    ],
  );

  blocTest<OrderCubit, OrderState>(
    'emits [ChangeOrderCount] when changeOrderCount is called',
    build: () => orderCubit,
    act: (cubit) => cubit.changeOrderCount(5),
    expect: () => [ChangeOrderCount(count: 5)],
  );
}
