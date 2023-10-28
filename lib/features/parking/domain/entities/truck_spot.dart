import 'package:equatable/equatable.dart';

class TruckSpot extends Equatable {
  final int spot;
  final String plate;
  final DateTime entry;
  final DateTime? exit;

  TruckSpot({
    required this.spot,
    required this.plate,
    required this.entry,
    this.exit,
  });

  @override
  List<Object> get props => [
        spot,
        plate,
        entry,
        exit!,
      ];
}
