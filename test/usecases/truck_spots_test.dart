import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:park_manager/core/error/failure.dart';
import 'package:park_manager/features/parking/domain/entities/truck_spot.dart';
import 'package:park_manager/features/parking/domain/repositories/truck_spot_repository.dart';
import 'package:park_manager/features/parking/domain/usecases/truck_spots.dart';

class TruckSpotRepositoryMock extends Mock implements TruckSpotRepository {}

void main() {
  group('TruckSpotsUseCase', () {
    late TruckSpotsUseCase useCase;
    late TruckSpotRepository repository;

    setUp(() {
      repository = TruckSpotRepositoryMock();
      useCase = TruckSpotsUseCase(repository: repository);
    });

    test('Deve retornar uma lista de TruckSpot do repositório', () async {
      final truckSpotList = [
        const TruckSpot(
          id: '1',
          spot: 1,
          plate: 'ABC-1234',
          entry: '2023-10-01 12:00',
          exit: '2023-10-01 15:00',
        ),
        const TruckSpot(
          id: '2',
          spot: 2,
          plate: 'XYZ-5678',
          entry: '2023-10-01 13:00',
          exit: '2023-10-01 16:00',
        ),
      ];

      when(() => repository.getTruckSpots()).thenAnswer(
        (_) => Future.value(
          Right(truckSpotList),
        ),
      );
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

    test('Deve lidar com uma falha de servidor', () async {
      when(() => repository.getTruckSpots()).thenAnswer(
        (_) => Future.value(
          Left(ServerFailure()),
        ),
      );

      final result = await useCase();

      expect(result, isA<Left<Failure, List<TruckSpot>>>());
      expect(result, Left(ServerFailure()));
    });

    test('Deve funcionar de forma assíncrona', () async {
      when(() => repository.getTruckSpots()).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 1));
        return const Right([]);
      });

      final start = DateTime.now();
      await useCase();
      final end = DateTime.now();
      final duration = end.difference(start);

      expect(duration.inSeconds, equals(1));
    });
  });
}
