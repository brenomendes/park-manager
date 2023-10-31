import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:park_manager/core/error/failure.dart';
import 'package:park_manager/features/parking/domain/entities/truck_spot.dart';
import 'package:park_manager/features/parking/domain/repositories/truck_spot_repository.dart';
import 'package:park_manager/features/parking/domain/usecases/day_distoric_truck_spots.dart';

class TruckSpotRepositoryMock extends Mock implements TruckSpotRepository {}

void main() {
  group('GetDayHistoricTruckSpotsUseCase', () {
    late TruckSpotRepository repository;
    late DayHistoricTruckSpotsUseCase useCase;

    setUp(() {
      repository = TruckSpotRepositoryMock();
      useCase = DayHistoricTruckSpotsUseCase(repository: repository);
    });

    test('Deve retornar uma lista de caminhões históricos do repositório', () async {
      // Preparar o mock da fonte de dados para retornar os registros históricos do dia.
      final truckSpotList = [
        const TruckSpot(
          id: "1",
          spot: 1,
          plate: "ABC123",
          entry: "29/11/2023 10:15",
          exit: "29/11/2023 10:50",
        ),
        const TruckSpot(
          id: "2",
          spot: 1,
          plate: "XYZ789",
          entry: "29/11/2023 10:15",
          exit: "29/11/2023 22:15",
        ),
      ];

      when(() => repository.getDayHistoricTruckSpots()).thenAnswer(
        (_) => Future.value(
          Right(truckSpotList),
        ),
      );

      // Chamar o caso de uso.
      final result = await useCase();

      expect(
        result,
        isA<Right<Failure, List<TruckSpot>>>(),
      );
      expect(
        result.getOrElse(() => []),
        equals(truckSpotList),
      );
    });

    test('Deve retornar uma falha do servidor quando houver um erro na fonte de dados', () async {
      when(() => repository.getDayHistoricTruckSpots()).thenAnswer(
        (_) => Future.value(
          Left(ServerFailure()),
        ),
      );

      final result = await useCase();

      expect(result, isA<Left<Failure, List<TruckSpot>>>());
      expect(result, Left(ServerFailure()));
    });
  });
}
