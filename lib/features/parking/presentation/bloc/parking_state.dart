part of 'parking_bloc.dart';

abstract class ParkingState extends Equatable {
  const ParkingState();  

  @override
  List<Object> get props => [];
}
class ParkingInitial extends ParkingState {}
