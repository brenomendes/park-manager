import 'package:equatable/equatable.dart';

class TruckSpot extends Equatable {
  final String? id;
  final int spot;
  final String plate;
  final String entry;
  final String exit;

  const TruckSpot({
    this.id,
    required this.spot,
    required this.plate,
    required this.entry,
    required this.exit,
  });

  @override
  List<Object> get props => [
        id!,
        spot,
        plate,
        entry,
        exit,
      ];
}
