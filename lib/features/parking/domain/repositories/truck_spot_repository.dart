import 'package:dartz/dartz.dart';
import 'package:park_manager/core/error/failure.dart';
import 'package:park_manager/features/parking/domain/entities/truck_spot.dart';

abstract class TruckSpotRepository {
  Future<Either<Failure, List<TruckSpot>>> getTruckSpots();
  Future<Either<Failure, List<TruckSpot>>> getDayHistoricTruckSpots();
  Future<Either<Failure, TruckSpot>> setEntryTruckSpots(TruckSpot truckSpot);
  Future<Either<Failure, TruckSpot>> setExitTruckSpots(int spot, DateTime exitTime);
}
