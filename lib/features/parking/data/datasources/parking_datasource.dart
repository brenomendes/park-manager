import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:park_manager/features/parking/data/models/truck_spot_model.dart';
import 'package:park_manager/features/parking/domain/entities/truck_spot.dart';

class FirebaseDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> fetchSpots() async {
    try {
      final collection = _firestore.collection('spots');
      final querySnapshot = await collection
          .orderBy(
            'entry',
            descending: true,
          )
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs;

        return {'response': data};
      } else {
        return {};
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setEntrySpot(TruckSpot spotData) async {
    try {
      Map<String, dynamic> spot = TruckSpotModel.toJson(spotData);
      await _firestore.collection('spots').add(spot);

      log('Spot added to Firestore successfully!');
    } catch (e) {
      log('Error adding spot to Firestore: $e');
    }
  }

  Future<void> setExitSpot(TruckSpot spotData) async {
    try {
      _firestore
          .collection('spots')
          .doc(
            spotData.id,
          )
          .update({
        'exit': spotData.exit,
      });

      log('Spot added to Firestore successfully!');
    } catch (e) {
      log('Error adding spot to Firestore: $e');
    }
  }

  Future<Map<String, dynamic>> dayHistoricTruckSpots() async {
    try {
      final now = DateTime.now();

      final beginDate = '${now.day}/${now.month}/${now.year} 00:00';

      final collection = _firestore.collection('spots');
      final querySnapshot = await collection
          .where(
            'entry',
            isGreaterThanOrEqualTo: beginDate,
          )
          .orderBy(
            'entry',
            descending: true,
          )
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs;

        return {'response': data};
      } else {
        return {};
      }
    } catch (e) {
      rethrow;
    }
  }
}
