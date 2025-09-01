import '../../../../core/helpers/location_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/helpers/failure.dart';
import '../model/deleivery_model.dart';

import '../../../order/data/models/order_model.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/helpers/firestore_helper.dart';
import 'delievery_repo.dart';

class DelieveryRepoImpl extends DelieveryRepo {
  final FirestoreHelper _firestoreHelper;
  final LocationHelper _locationHelper;
  DelieveryRepoImpl({
    required FirestoreHelper firestoreHelper,
    required LocationHelper locationHelper,
  }) : _firestoreHelper = firestoreHelper,
       _locationHelper = locationHelper;

  @override
  Future<Either<Failure, void>> actionOnOrder({
    required DeleiveryModel deleiveryModel,
    required String orderId,
  }) async {
    try {
      await _firestoreHelper.acceptOrder(
        deleveryModel: deleiveryModel,
        orderId: orderId,
      );
      return Right(null);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<OrderModel>>> getDeliveryOrders() async* {
    try {
      await for (final orders in _firestoreHelper.getOrdersStream()) {
        yield Right(orders);
      }
    } catch (e) {
      yield Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateDeliveryLatLong({
    required double lat,
    required double long,
    required String orderId,
  }) async {
    try {
      await _firestoreHelper.updateDeliveryLatLong(lat, long, orderId);
      return Right(null);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> changeOrderStatus(
    String orderId,
    String status,
  ) async {
    try {
      await _firestoreHelper.changeOrderStatus(
        orderId: orderId,
        status: status,
      );
      return Right(null);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, Position>> getDeliveryPosition() async* {
    try {
      await for (final position in _locationHelper.getPositionStream()) {
        yield Right(position);
      }
    } catch (e) {
      yield Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  double getDiffDistance({
    required double lat1,
    required double long1,
    required double lat2,
    required double long2,
  }) {
    return _locationHelper.getDiffDistance(lat1, long1, lat2, long2);
  }

  @override
  Future<Either<Failure, Set<Polyline>>> drawPolylineCoordinates({
    required LatLng start,
    required LatLng end,
  }) async {
    try {
      final polylines = await _locationHelper.getPolylineCoordinates(
        start: start,
        end: end,
      );
      return Right(polylines);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
