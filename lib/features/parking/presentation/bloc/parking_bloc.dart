import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:park_manager/core/error/failure.dart';
import 'package:park_manager/features/parking/domain/entities/truck_spot.dart';
import 'package:park_manager/features/parking/domain/repositories/truck_spot_repository.dart';
import 'package:park_manager/features/parking/domain/usecases/day_distoric_truck_spots.dart';
import 'package:park_manager/features/parking/domain/usecases/entry_truck_spot.dart';
import 'package:park_manager/features/parking/domain/usecases/exit_truck_spot.dart';
import 'package:park_manager/features/parking/domain/usecases/truck_spots.dart';

part 'parking_event.dart';
part 'parking_state.dart';

class ParkingBloc extends Bloc<ParkingEvent, ParkingState> {
  final TruckSpotRepository truckSpotRepository;

  ParkingBloc(
    this.truckSpotRepository,
  ) : super(ParkingInitialState()) {
    on<ParkingEventInitial>((event, emit) async {
      emit(ParkingInitialState());
    });
    on<FetchTruckSpotsEvent>((event, emit) async {
      await _fetchTruckSpots(event, emit);
    });
    on<SetEntryTruckSpotEvent>((event, emit) async {
      await _setEntryTruckSpot(event, emit);
    });
    on<SetExitTruckSpotEvent>((event, emit) async {
      await _setExitTruckSpot(event, emit);
    });
    on<ReloadTruckSpotsEvent>((event, emit) async {
      await _fetchTruckSpots(event, emit);
    });
    on<FetchTruckSpotsHistoricDayEvent>((event, emit) async {
      await _fetchTruckSpotsHistoricDay(event, emit);
    });
  }

  Future<void> _fetchTruckSpots(event, emit) async {
    TruckSpotsUseCase useCase = TruckSpotsUseCase(
      repository: truckSpotRepository,
    );
    emit(ParkingLoadingState());

    final result = await useCase.call();

    result.fold(
      (Failure? failure) async {
        emit(ParkingErrorState());
      },
      (List<TruckSpot> truckSpots) async {
        emit(ParkingLoadedState(spots: truckSpots));
      },
    );
  }

  Future<void> _setEntryTruckSpot(SetEntryTruckSpotEvent event, emit) async {
    emit(ParkingLoadingState());
    EntryTruckSpotUseCase useCase = EntryTruckSpotUseCase(
      repository: truckSpotRepository,
    );

    final request = await useCase.call(event.spot);

    request.fold(
      (Failure failure) async {
        emit(SendSpotFailState());
      },
      (bool success) async {
        if (success) {
          emit(SendSpotSuccessState());
        } else {
          emit(SendSpotFailState());
        }
      },
    );
  }

  Future<void> _setExitTruckSpot(SetExitTruckSpotEvent event, emit) async {
    (event.fromSearch) ? emit(ParkingSearchLoadingState()) : emit(ParkingLoadingState());
    ExitTruckSpotUseCase useCase = ExitTruckSpotUseCase(
      repository: truckSpotRepository,
    );

    final result = await useCase.call(event.spot);

    result.fold(
      (Failure failure) async {
        emit(SetExitTruckSpotFailState());
      },
      (bool truckSpots) async {
        emit(SetExitTruckSpotSuccessState());
      },
    );
  }

  Future<void> _fetchTruckSpotsHistoricDay(event, emit) async {
    DayHistoricTruckSpotsUseCase useCase = DayHistoricTruckSpotsUseCase(
      repository: truckSpotRepository,
    );
    emit(ParkingSearchLoadingState());

    final result = await useCase.call();

    result.fold(
      (Failure? failure) async {
        emit(ParkingHistoricDayFailState());
      },
      (List<TruckSpot> truckSpots) async {
        emit(ParkingHistoricDaySuccessState(spots: truckSpots));
      },
    );
  }
}
