import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:park_manager/core/error/failure.dart';
import 'package:park_manager/features/parking/data/models/truck_spot_model.dart';
import 'package:park_manager/features/parking/domain/entities/truck_spot.dart';

abstract class TruckSpotRepository {
  Future<List<TruckSpot>> getTruckSpots();
  Future<List<TruckSpot>> getDayHistoricTruckSpots();
  Future<TruckSpot> setEntryTruckSpots(TruckSpot truckSpot);
  Future<TruckSpot> setExitTruckSpots(int spot, DateTime exitTime);
}

//Instantiate Firestore
final db = FirebaseFirestore.instance;

void parkingSession({spot, plate, entry, exit}) async {
  TruckSpotModel truckSpot = TruckSpotModel(
    spot: spot,
    plate: plate,
    entry: entry,
    exit: exit,
  );

//Add document to Firestore with an auto-generated Id
  await db.collection('spots').add(truckSpot.toJson());
}
