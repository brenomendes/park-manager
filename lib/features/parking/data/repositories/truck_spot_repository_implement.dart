import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:park_manager/core/error/failure.dart';
import 'package:park_manager/features/parking/data/datasources/parking_datasource.dart';
import 'package:park_manager/features/parking/domain/entities/truck_spot.dart';
import 'package:park_manager/features/parking/domain/repositories/truck_spot_repository.dart';

class TruckSpotRepositoryImplement implements TruckSpotRepository {
  final FirebaseDataSource _firebaseDataSource;

  TruckSpotRepositoryImplement(this._firebaseDataSource);

  @override
  Future<Either<Failure, List<TruckSpot>>> getTruckSpots() async {
    try {
      final truckSpots = await _firebaseDataSource.fetchSpots();
      List<TruckSpot> spots = [];

      if (truckSpots['response'] != null) {
        List<QueryDocumentSnapshot<Map<String, dynamic>>> response = truckSpots['response'];

        for (QueryDocumentSnapshot<Map<String, dynamic>> element in response) {
          spots.add(
            TruckSpot(
              id: element.id,
              spot: element.get('spot'),
              plate: element.get('plate'),
              entry: element.get('entry'),
              exit: element.get('exit'),
            ),
          );
        }
      }

      return Right(spots);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> setEntryTruckSpot(TruckSpot spotData) async {
    try {
      await _firebaseDataSource.setEntrySpot(spotData);
      return const Right(true);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> setExitTruckSpots(TruckSpot spot) async {
    try {
      await _firebaseDataSource.setExitSpot(spot);
      log('Documento atualizado com sucesso!');
      return const Right(true);
    } catch (e) {
      log('Erro ao atualizar o documento: $e');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<TruckSpot>>> getDayHistoricTruckSpots() async {
    try {
      final truckSpots = await _firebaseDataSource.dayHistoricTruckSpots();
      List<TruckSpot> spots = [];

      if (truckSpots['response'] != null) {
        List<QueryDocumentSnapshot<Map<String, dynamic>>> response = truckSpots['response'];

        for (QueryDocumentSnapshot<Map<String, dynamic>> element in response) {
          spots.add(
            TruckSpot(
              id: element.id,
              spot: element.get('spot'),
              plate: element.get('plate'),
              entry: element.get('entry'),
              exit: element.get('exit'),
            ),
          );
        }
      }

      return Right(spots);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
