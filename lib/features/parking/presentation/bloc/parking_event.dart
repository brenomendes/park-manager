part of 'parking_bloc.dart';

abstract class ParkingEvent extends Equatable {
  const ParkingEvent();

  @override
  List<Object> get props => [];
}

class ParkingEventInitial extends ParkingEvent {}

class FetchTruckSpotsEvent extends ParkingEvent {}

class SetEntryTruckSpotEvent extends ParkingEvent {
  final TruckSpot spot;
  const SetEntryTruckSpotEvent({required this.spot});

  @override
  List<Object> get props => [spot];
}

class SetExitTruckSpotEvent extends ParkingEvent {
  final TruckSpot spot;
  final bool fromSearch;
  const SetExitTruckSpotEvent({
    required this.spot,
    this.fromSearch = false,
  });

  @override
  List<Object> get props => [spot];
}

class ReloadTruckSpotsEvent extends ParkingEvent {}

class FetchTruckSpotsHistoricDayEvent extends ParkingEvent {}
