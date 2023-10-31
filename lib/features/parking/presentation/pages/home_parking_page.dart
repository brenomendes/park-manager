import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:park_manager/features/parking/presentation/bloc/parking_bloc.dart';
import 'package:park_manager/features/parking/presentation/pages/set_entry_parking_page.dart';
import 'package:park_manager/features/parking/presentation/pages/truck_spots_historic_day.dart';
import 'package:park_manager/features/parking/presentation/widgets/list_spots_widget.dart';
import 'package:park_manager/features/parking/presentation/widgets/loading_widget.dart';

class HomeParking extends StatefulWidget {
  const HomeParking({super.key});

  @override
  State<HomeParking> createState() => _HomeParkingState();
}

class _HomeParkingState extends State<HomeParking> {
  late ParkingBloc parkingBloc;
  @override
  void initState() {
    parkingBloc = BlocProvider.of<ParkingBloc>(context);
    parkingBloc.add(FetchTruckSpotsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estacionamento do João'),
        actions: [
          IconButton(
            onPressed: () => parkingBloc.add(ReloadTruckSpotsEvent()),
            color: Colors.white,
            icon: const Icon(
              Icons.replay_sharp,
            ),
          )
        ],
      ),
      body: BlocListener<ParkingBloc, ParkingState>(
        listener: (context, state) {
          if (state is SetExitTruckSpotSuccessState) {
            parkingBloc.add(ReloadTruckSpotsEvent());
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SetEntryParkingPage(),
                      ),
                    ),
                    icon: const Icon(
                      Icons.upgrade,
                      size: 40,
                    ),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 25,
                      ),
                      child: Text(
                        "Registrar entrada",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TruckSpotsHistoricDay(),
                      ),
                    ),
                    icon: const Icon(
                      Icons.insert_chart,
                      size: 30,
                    ),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: Text(
                        "Fechar dia",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<ParkingBloc, ParkingState>(
              buildWhen: (_, state) {
                return (state is ParkingLoadingState || state is ParkingLoadedState || state is ParkingErrorState);
              },
              builder: (context, state) {
                if (state is ParkingLoadingState) {
                  return const LoadingWidget();
                } else if (state is ParkingLoadedState) {
                  return ListSpotsWidget(
                    truckSpots: state.spots,
                    parkingBloc: parkingBloc,
                    title: "Últimas vagas cadastradas: ",
                  );
                } else {
                  return Column(
                    children: [
                      const Text("Ocorreu um erro, tente novamente!"),
                      ElevatedButton(
                        child: const Text("Recarregar"),
                        onPressed: () {
                          parkingBloc.add(ReloadTruckSpotsEvent());
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
