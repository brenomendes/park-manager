import 'package:dartz/dartz.dart';
import 'package:park_manager/core/error/failure.dart';
import 'package:park_manager/features/parking/domain/entities/truck_spot.dart';

abstract class TruckSpotRepository {
  Future<Either<Failure, List<TruckSpot>>> getTruckSpots();
  Future<Either<Failure, bool>> setEntryTruckSpot(TruckSpot truckSpot);
  Future<Either<Failure, bool>> setExitTruckSpots(TruckSpot truckSpot);
  Future<Either<Failure, List<TruckSpot>>> getDayHistoricTruckSpots();
}
