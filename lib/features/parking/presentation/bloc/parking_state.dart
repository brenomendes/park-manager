part of 'parking_bloc.dart';

abstract class ParkingState extends Equatable {
  const ParkingState();

  @override
  List<Object> get props => [];
}

class ParkingInitialState extends ParkingState {}

class ParkingLoadingState extends ParkingState {}

class ParkingSearchLoadingState extends ParkingState {}

class ParkingErrorState extends ParkingState {}

class ParkingLoadedState extends ParkingState {
  final List<TruckSpot> spots;
  const ParkingLoadedState({required this.spots});
}

class SendSpotSuccessState extends ParkingState {}

class SendSpotFailState extends ParkingState {}

class SetExitTruckSpotSuccessState extends ParkingState {}

class SetExitTruckSpotFailState extends ParkingState {}

class ParkingHistoricDaySuccessState extends ParkingState {
  final List<TruckSpot> spots;
  const ParkingHistoricDaySuccessState({required this.spots});
}

class ParkingHistoricDayFailState extends ParkingState {}
