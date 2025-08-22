import 'package:coffe_shop/core/helpers/failure.dart';
import 'package:coffe_shop/core/helpers/firestore_helper.dart';
import 'package:coffe_shop/core/helpers/location_helper.dart';
import 'package:coffe_shop/features/home/data/model/coffe_model.dart';
import 'package:coffe_shop/features/home/data/repo/home_repo_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repo_impl_test.mocks.dart';

@GenerateMocks([FirestoreHelper, LocationHelper])
void main() {
  late HomeRepoImpl homeRepoImpl;
  late MockFirestoreHelper mockFirestoreHelper;
  late MockLocationHelper mockLocationHelper;

  setUp(() {
    mockFirestoreHelper = MockFirestoreHelper();
    mockLocationHelper = MockLocationHelper();
    homeRepoImpl = HomeRepoImpl(
      firestoreHelper: mockFirestoreHelper,
      locationHelper: mockLocationHelper,
    );
  });

  // Test data
  final tCoffeeModel = CoffeeModel(
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
  );
  final tCoffeeList = [tCoffeeModel];
  const tId = '1';
  const tQuery = 'Latte';
  const tLocation = 'New York, USA';
  final tException = Exception('Something went wrong');

  group('getAllCoffees', () {
    test(
      'should return a list of CoffeeModel when the call to firestore is successful',
      () async {
        // Arrange
        when(
          mockFirestoreHelper.getAllCoffees(),
        ).thenAnswer((_) async => tCoffeeList);

        // Act
        final result = await homeRepoImpl.getAllCoffees();

        // Assert
        expect(result, Right(tCoffeeList));
        verify(mockFirestoreHelper.getAllCoffees());
        verifyNoMoreInteractions(mockFirestoreHelper);
      },
    );

    test(
      'should return a Failure when the call to firestore is unsuccessful',
      () async {
        // Arrange
        when(mockFirestoreHelper.getAllCoffees()).thenThrow(tException);

        // Act
        final result = await homeRepoImpl.getAllCoffees();

        // Assert
        expect(result, Left(Failure(errMessage: tException.toString())));
        verify(mockFirestoreHelper.getAllCoffees());
        verifyNoMoreInteractions(mockFirestoreHelper);
      },
    );
  });

  group('getCoffeeById', () {
    test(
      'should return a CoffeeModel when the call to firestore is successful',
      () async {
        // Arrange
        when(
          mockFirestoreHelper.getCoffeeById(any),
        ).thenAnswer((_) async => tCoffeeModel);

        // Act
        final result = await homeRepoImpl.getCoffeeById(tId);

        // Assert
        expect(result, Right(tCoffeeModel));
        verify(mockFirestoreHelper.getCoffeeById(tId));
        verifyNoMoreInteractions(mockFirestoreHelper);
      },
    );

    test(
      'should return a Failure when the call to firestore is unsuccessful',
      () async {
        // Arrange
        when(mockFirestoreHelper.getCoffeeById(any)).thenThrow(tException);

        // Act
        final result = await homeRepoImpl.getCoffeeById(tId);

        // Assert
        expect(result, Left(Failure(errMessage: tException.toString())));
        verify(mockFirestoreHelper.getCoffeeById(tId));
        verifyNoMoreInteractions(mockFirestoreHelper);
      },
    );
  });

  group('searchOnCoffees', () {
    test(
      'should return a list of CoffeeModel when the call to firestore is successful',
      () async {
        // Arrange
        when(
          mockFirestoreHelper.searchCoffees(any),
        ).thenAnswer((_) async => tCoffeeList);

        // Act
        final result = await homeRepoImpl.searchOnCoffees(tQuery);

        // Assert
        expect(result, Right(tCoffeeList));
        verify(mockFirestoreHelper.searchCoffees(tQuery));
        verifyNoMoreInteractions(mockFirestoreHelper);
      },
    );

    test(
      'should return a Failure when the call to firestore is unsuccessful',
      () async {
        // Arrange
        when(mockFirestoreHelper.searchCoffees(any)).thenThrow(tException);

        // Act
        final result = await homeRepoImpl.searchOnCoffees(tQuery);

        // Assert
        expect(result, Left(Failure(errMessage: tException.toString())));
        verify(mockFirestoreHelper.searchCoffees(tQuery));
        verifyNoMoreInteractions(mockFirestoreHelper);
      },
    );
  });

  group('getUserLocation', () {
    test(
      'should return a location string when the call to location helper is successful',
      () async {
        // Arrange
        when(
          mockLocationHelper.getCurrentLocation(),
        ).thenAnswer((_) async => tLocation);

        // Act
        final result = await homeRepoImpl.getUserLocation();

        // Assert
        expect(result, const Right(tLocation));
        verify(mockLocationHelper.getCurrentLocation());
        verifyNoMoreInteractions(mockLocationHelper);
      },
    );

    test(
      'should return a Failure when the call to location helper is unsuccessful',
      () async {
        // Arrange
        when(mockLocationHelper.getCurrentLocation()).thenThrow(tException);

        // Act
        final result = await homeRepoImpl.getUserLocation();

        // Assert
        expect(result, Left(Failure(errMessage: tException.toString())));
        verify(mockLocationHelper.getCurrentLocation());
        verifyNoMoreInteractions(mockLocationHelper);
      },
    );
  });
}
