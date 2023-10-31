import 'package:dartz/dartz.dart';
import 'package:park_manager/core/error/failure.dart';
import 'package:park_manager/features/parking/domain/entities/truck_spot.dart' as entity;
import 'package:park_manager/features/parking/domain/repositories/truck_spot_repository.dart';

class EntryTruckSpotUseCase {
  final TruckSpotRepository repository;

  EntryTruckSpotUseCase({required this.repository});
  Future<Either<Failure, bool>> call(entity.TruckSpot spot) async {
    return await repository.setEntryTruckSpot(spot);
  }
}
