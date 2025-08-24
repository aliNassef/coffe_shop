import 'package:coffe_shop/core/helpers/failure.dart';
import 'package:coffe_shop/features/home/data/model/coffe_model.dart';
import 'package:coffe_shop/features/home/data/repo/home_repo.dart';
import 'package:coffe_shop/features/home/presentation/controller/bloc/coffe_search_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import 'coffe_search_bloc_test.mocks.dart';

@GenerateMocks([HomeRepo])
void main() {
  late HomeRepo homeRepo;
  late CoffeSearchBloc bloc;
  String query = 'Mocca';
  String errMessage = 'no coffe found';
  setUp(() {
    homeRepo = MockHomeRepo();
    bloc = CoffeSearchBloc(homeRepo);
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
  blocTest<CoffeSearchBloc, CoffeSearchState>(
    'emits [CoffeSearchLoading , CoffeSearchSuccess] when CoffeSearchQueryChanged is added.',

    build: () {
      when(
        homeRepo.searchOnCoffees(query),
      ).thenAnswer((_) async => right(tCoffeList));

      return bloc;
    },
    wait: Duration(milliseconds: 500),
    act: (bloc) => bloc.add(CoffeSearchQueryChanged(query)),
    expect: () => <CoffeSearchState>[
      CoffeSearchLoading(),
      CoffeSearchSuccess(tCoffeList),
    ],
  );

  blocTest<CoffeSearchBloc, CoffeSearchState>(
    'emits [CoffeSearchLoading , CoffeSearchError] when search is failed.',

    build: () {
      when(
        homeRepo.searchOnCoffees(query),
      ).thenAnswer((_) async => left(Failure(errMessage: errMessage)));

      return bloc;
    },
    wait: Duration(milliseconds: 500),
    act: (bloc) => bloc.add(CoffeSearchQueryChanged(query)),
    expect: () => <CoffeSearchState>[
      CoffeSearchLoading(),
      CoffeSearchError(errMessage),
    ],
  );
}
