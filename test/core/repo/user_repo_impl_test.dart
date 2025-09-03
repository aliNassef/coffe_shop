import 'package:coffe_shop/core/helpers/cache_helper.dart';
import 'package:coffe_shop/core/helpers/failure.dart';
import 'package:coffe_shop/core/helpers/fireauth_helper.dart';
import 'package:coffe_shop/core/helpers/firestore_helper.dart';
import 'package:coffe_shop/core/helpers/location_helper.dart';
import 'package:coffe_shop/core/repo/user_repo.dart';
import 'package:coffe_shop/core/repo/user_repo_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../features/home/data/repo/home_repo_impl_test.mocks.dart';

@GenerateMocks([LocationHelper])
void main() {
  late LocationHelper locationHelper;
  late UserRepo userRepo;

  setUp(() {
    locationHelper = MockLocationHelper();
    userRepo = UserRepoImpl(
      locationHelper: locationHelper,
      fireauthHelper: FireauthHelper(),
      firestoreHelper: FirestoreHelper(),
      cacheHelper: CacheHelper(),
    );
  });

  group('getUserAddress', () {
    test('should return address when called successfully', () async {
      // Arrange
      when(
        locationHelper.getCurrentLocation(),
      ).thenAnswer((_) async => 'Egypt, Cairo');
      // Act
      final result = await userRepo.getUserAddress();
      // Assert
      expect(result, const Right<Failure, String>('Egypt, Cairo'));
      verify(locationHelper.getCurrentLocation()).called(1);
    });

    test('should return failure when an exception occurs', () async {
      when(locationHelper.getCurrentLocation()).thenThrow(Exception('error'));
      final result = await userRepo.getUserAddress();
      expect(result, Left(Failure(errMessage: 'Exception: error')));
      verify(locationHelper.getCurrentLocation()).called(1);
    });
  });

  group('getUserCoardinates', () {
    final tPosition = Position(
      latitude: 30.0,
      longitude: 31.0,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      altitudeAccuracy: 0.0,
      heading: 0.0,
      headingAccuracy: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
    );
    test('should return Position when called successfully', () async {
      // Arrange
      when(
        locationHelper.getUserCoardinates(),
      ).thenAnswer((_) async => tPosition);
      // Act
      final result = await userRepo.getUserCoardinates();
      // Assert
      expect(result, Right<Failure, Position>(tPosition));
      verify(locationHelper.getUserCoardinates()).called(1);
    });

    test('should return failure when an exception occurs', () async {
      when(locationHelper.getUserCoardinates()).thenThrow(Exception('error'));
      final result = await userRepo.getUserCoardinates();
      expect(
        result,
        Left<Failure, Position>(Failure(errMessage: 'Exception: error')),
      );
      verify(locationHelper.getUserCoardinates()).called(1);
    });
  });
}
