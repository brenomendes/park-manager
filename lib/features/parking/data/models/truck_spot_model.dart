import 'package:park_manager/features/parking/domain/entities/truck_spot.dart';

class TruckSpotModel extends TruckSpot {
  final int spot;
  final String plate;
  final DateTime entry;
  final DateTime? exit;

  TruckSpotModel({
    required this.spot,
    required this.plate,
    required this.entry,
    this.exit,
  }) : super(
          entry: entry,
          plate: plate,
          spot: spot,
          exit: exit,
        );

  factory TruckSpotModel.fromJson(Map<String, dynamic> json) {
    return TruckSpotModel(
      spot: json['spot'],
      plate: json['plate'],
      entry: json['entry'],
      exit: json['json'],
    );
  }
}
