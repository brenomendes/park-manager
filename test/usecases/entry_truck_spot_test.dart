import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:park_manager/core/error/failure.dart';
import 'package:park_manager/features/parking/domain/entities/truck_spot.dart';
import 'package:park_manager/features/parking/domain/repositories/truck_spot_repository.dart';
import 'package:park_manager/features/parking/domain/usecases/entry_truck_spot.dart';

class TruckSpotRepositoryMock extends Mock implements TruckSpotRepository {}

void main() {
  group('SetEntryTruckSpotUseCase', () {
    late EntryTruckSpotUseCase useCase;
    late TruckSpotRepository repository;

    setUp(() {
      repository = TruckSpotRepositoryMock();
      useCase = EntryTruckSpotUseCase(repository: repository);
    });

    // Teste de sucesso na entrada
    test('Deve retornar Right(true) quando a entrada é bem-sucedida', () async {
      const truckSpot = TruckSpot(
        id: '1',
        spot: 1,
        plate: 'ABC-1234',
        entry: '29/11/2023 10:15',
        exit: '',
      );

      when(() => repository.setEntryTruckSpot(truckSpot)).thenAnswer((_) async => Right(true));

      final result = await useCase(truckSpot);

      expect(result, Right(true));
    });

    // Teste de falha na entrada
    test('Deve retornar Left(ServerFailure()) quando a entrada falha', () async {
      const truckSpot = TruckSpot(
        id: '1',
        spot: 1,
        plate: 'ABC-1234',
        entry: '29/11/2023 10:15',
        exit: '',
      );

      when(() => repository.setEntryTruckSpot(truckSpot)).thenAnswer((_) async => Left(ServerFailure()));

      final result = await useCase(truckSpot);

      expect(result, Left(ServerFailure()));
    });
  });
}
