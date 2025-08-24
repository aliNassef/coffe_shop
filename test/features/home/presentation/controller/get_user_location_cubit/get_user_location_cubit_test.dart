import 'package:bloc_test/bloc_test.dart';
import 'package:coffe_shop/core/helpers/failure.dart';
import 'package:coffe_shop/features/home/data/repo/home_repo.dart';
import 'package:coffe_shop/features/home/presentation/controller/get_user_location_cubit/get_user_location_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_user_location_cubit_test.mocks.dart';

@GenerateMocks([HomeRepo])
void main() {
  late HomeRepo homeRepo;
  late GetUserLocationCubit cubit;
  setUp(() {
    homeRepo = MockHomeRepo();
    cubit = GetUserLocationCubit(homeRepo);
  });
  String address = 'Egypt, Cairo';
  String errmessage = 'no location found';
  blocTest(
    'emits [GetUserLocationLoading , GetUserLocationLoaded] when getUserLocation is called',
    build: () {
      return cubit;
    },
    setUp: () {
      when(homeRepo.getUserLocation()).thenAnswer((_) async => right(address));
    },
    act: (cubit) => cubit.getUserLocation(),
    expect: () => [
      GetUserLocationLoading(),
      GetUserLocationLoaded(position: address),
    ],
    verify: (bloc) {
      verify(homeRepo.getUserLocation()).called(1);
    },
  );
  blocTest(
    'emits [GetUserLocationLoading , GetUserLocationFailure] when getUserLocation is failed',
    build: () {
      return cubit;
    },
    setUp: () {
      when(
        homeRepo.getUserLocation(),
      ).thenAnswer((_) async => left(Failure(errMessage: errmessage)));
    },
    act: (cubit) => cubit.getUserLocation(),
    expect: () => [
      GetUserLocationLoading(),
      GetUserLocationFailure(errMessage: errmessage),
    ],
    verify: (bloc) {
      verify(homeRepo.getUserLocation()).called(1);
    },
  );
}
