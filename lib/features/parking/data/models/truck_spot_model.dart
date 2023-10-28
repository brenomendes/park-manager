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
      exit: json['exit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'spot': spot,
      'plate': plate,
      'entry': entry,
      'exit': exit,
    };
  }

  @override
  List<Object> get props => [
        spot,
        plate,
        entry,
        exit!,
      ];
}
