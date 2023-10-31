import 'package:park_manager/features/parking/domain/entities/truck_spot.dart';

class TruckSpotModel extends TruckSpot {
  final String? id;
  final int spot;
  final String plate;
  final String entry;
  final String exit;

  TruckSpotModel({
    this.id,
    required this.spot,
    required this.plate,
    required this.entry,
    required this.exit,
  }) : super(
          id: id,
          entry: entry,
          plate: plate,
          spot: spot,
          exit: exit,
        );

  static Map<String, dynamic> toJson(TruckSpot truckSpot) {
    return {
      'spot': truckSpot.spot,
      'plate': truckSpot.plate,
      'entry': truckSpot.entry,
      'exit': truckSpot.exit,
    };
  }

  @override
  List<Object> get props => [
        spot,
        plate,
        entry,
        exit,
      ];
}
