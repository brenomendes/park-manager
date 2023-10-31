import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:park_manager/features/parking/data/datasources/parking_datasource.dart';
import 'package:park_manager/features/parking/data/repositories/truck_spot_repository_implement.dart';
import 'package:park_manager/features/parking/presentation/bloc/parking_bloc.dart';
import 'package:park_manager/features/parking/presentation/pages/home_parking_page.dart';
import 'package:park_manager/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final truckSpotRepository = TruckSpotRepositoryImplement(FirebaseDataSource());

    return BlocProvider<ParkingBloc>(
      create: (BuildContext context) => ParkingBloc(truckSpotRepository),
      child: MaterialApp(
        title: 'Estacionamento do João',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
          ),
          useMaterial3: true,
        ),
        home: const HomeParking(),
      ),
    );
  }
}
