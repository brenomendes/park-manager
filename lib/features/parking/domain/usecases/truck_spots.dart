import 'package:dartz/dartz.dart';
import 'package:park_manager/core/error/failure.dart';
import 'package:park_manager/features/parking/domain/entities/truck_spot.dart' as entity;
import 'package:park_manager/features/parking/domain/repositories/truck_spot_repository.dart';

class TruckSpotsUseCase {
  final TruckSpotRepository repository;

  TruckSpotsUseCase({required this.repository});
  Future<Either<Failure, List<entity.TruckSpot>>> call() async {
    return await repository.getTruckSpots();
  }
}
