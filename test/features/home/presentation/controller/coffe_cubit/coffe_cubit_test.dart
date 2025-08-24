import 'package:bloc_test/bloc_test.dart';
import 'package:coffe_shop/core/helpers/failure.dart';
import 'package:coffe_shop/features/home/data/model/coffe_model.dart';
import 'package:coffe_shop/features/home/data/repo/home_repo.dart';
import 'package:coffe_shop/features/home/presentation/controller/coffe_cubit/coffe_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../bloc/coffe_search_bloc_test.mocks.dart';

@GenerateMocks([HomeRepo])
void main() {
  late HomeRepo homeRepo;
  late CoffeCubit coffeCubit;
  setUp(() {
    homeRepo = MockHomeRepo();
    coffeCubit = CoffeCubit(homeRepo);
  });
  var tCoffeList = [
    CoffeeModel(
      coffeeId: "latte_1",
      numOfReviews: 3,
      name: "Latte",
      price: 45.0,
      size: "Medium",
      count: 2,
      img: "https://...",
      rate: 4.5,
      desc: "Freshly brewed latte",
      type: "Latte",
    ),
  ];
  String errMessage = 'no coffe found';
  blocTest(
    'emits [CoffeLoading , CoffeSuccess] when getCoffees is called',
    build: () {
      return coffeCubit;
    },
    setUp: () {
      when(homeRepo.getAllCoffees()).thenAnswer((_) async => right(tCoffeList));
    },
    act: (bloc) => bloc.getCoffees(),
    expect: () => <CoffeState>[CoffeLoading(), CoffeSuccess(tCoffeList)],
  );
  blocTest(
    'emits [CoffeLoading , CoffeError] when getCoffees is failed',
    build: () {
      return coffeCubit;
    },
    setUp: () {
      when(
        homeRepo.getAllCoffees(),
      ).thenAnswer((_) async => left(Failure(errMessage: errMessage)));
    },
    act: (bloc) => bloc.getCoffees(),
    expect: () => <CoffeState>[CoffeLoading(), CoffeError(errMessage)],
  );
}
