import 'package:dartz/dartz.dart';
import 'package:park_manager/core/error/failure.dart';
import 'package:park_manager/features/parking/domain/entities/truck_spot.dart' as entity;
import 'package:park_manager/features/parking/domain/repositories/truck_spot_repository.dart';

class DayHistoricTruckSpotsUseCase {
  final TruckSpotRepository repository;

  DayHistoricTruckSpotsUseCase({required this.repository});
  Future<Either<Failure, List<entity.TruckSpot>>> call() async {
    return await repository.getDayHistoricTruckSpots();
  }
}
