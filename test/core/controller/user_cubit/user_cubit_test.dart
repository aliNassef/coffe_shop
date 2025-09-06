import 'package:bloc_test/bloc_test.dart';
import 'package:coffe_shop/core/helpers/failure.dart';
import 'package:coffe_shop/core/repo/user_repo.dart';
import 'package:coffe_shop/core/controller/user_cubit/user_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_cubit_test.mocks.dart';

@GenerateMocks([UserRepo])
void main() {
  late MockUserRepo mockUserRepo;
  late UserCubit userCubit;

  const tAddress = "Cairo, Egypt";
  final tFailure = Failure(errMessage: "Something went wrong");
  final tPosition = Position(
    latitude: 30.0444,
    longitude: 31.2357,
    timestamp: DateTime.now(),
    accuracy: 1,
    altitude: 1,
    heading: 1,
    speed: 1,
    speedAccuracy: 1,
    altitudeAccuracy: 1,
    headingAccuracy: 1,
  );

  setUp(() {
    mockUserRepo = MockUserRepo();
    userCubit = UserCubit(mockUserRepo);
  });

  tearDown(() {
    userCubit.close();
  });

  blocTest<UserCubit, UserState>(
    'emits [UpdateUserAddressState] when updateUserAddress is called',
    build: () => userCubit,
    act: (cubit) => cubit.updateUserAddress(tAddress),
    expect: () => [UpdateUserAddressState(address: tAddress)],
  );

  blocTest<UserCubit, UserState>(
    'emits [GetuserLocationLoadingState, GetuserLocationLoadedState] when getUserAddress succeeds',
    build: () {
      when(
        mockUserRepo.getUserAddress(),
      ).thenAnswer((_) async => const Right(tAddress));
      return userCubit;
    },
    act: (cubit) => cubit.getUserAddress(),
    expect: () => [
      GetuserLocationLoadingState(),
      GetuserLocationLoadedState(address: tAddress),
    ],
  );

  blocTest<UserCubit, UserState>(
    'emits [GetuserLocationLoadingState, GetuserLocationFailed] when getUserAddress fails',
    build: () {
      when(
        mockUserRepo.getUserAddress(),
      ).thenAnswer((_) async => Left(tFailure));
      return userCubit;
    },
    act: (cubit) => cubit.getUserAddress(),
    expect: () => [
      GetuserLocationLoadingState(),
      GetuserLocationFailed(error: tFailure.errMessage),
    ],
  );

  blocTest<UserCubit, UserState>(
    'emits [GetuserPositonLoadingState, GetuserPositonLoadedState] when getUserCoardinate succeeds',
    build: () {
      when(
        mockUserRepo.getUserCoardinates(),
      ).thenAnswer((_) async => Right(tPosition));
      return userCubit;
    },
    act: (cubit) => cubit.getUserCoardinate(),
    expect: () => [
      GetuserPositonLoadingState(),
      GetuserPositonLoadedState(position: tPosition),
    ],
  );

  blocTest<UserCubit, UserState>(
    'emits [GetuserPositonLoadingState, GetuserPositonFailed] when getUserCoardinate fails',
    build: () {
      when(
        mockUserRepo.getUserCoardinates(),
      ).thenAnswer((_) async => Left(tFailure));
      return userCubit;
    },
    act: (cubit) => cubit.getUserCoardinate(),
    expect: () => [
      GetuserPositonLoadingState(),
      GetuserPositonFailed(error: tFailure.errMessage),
    ],
  );
}
