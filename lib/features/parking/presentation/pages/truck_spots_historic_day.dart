import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:park_manager/features/parking/presentation/bloc/parking_bloc.dart';
import 'package:park_manager/features/parking/presentation/widgets/list_spots_widget.dart';
import 'package:park_manager/features/parking/presentation/widgets/loading_widget.dart';

class TruckSpotsHistoricDay extends StatefulWidget {
  const TruckSpotsHistoricDay({super.key});

  @override
  State<TruckSpotsHistoricDay> createState() => _TruckSpotsHistoricDayState();
}

class _TruckSpotsHistoricDayState extends State<TruckSpotsHistoricDay> {
  late ParkingBloc parkingBloc;

  @override
  void initState() {
    parkingBloc = BlocProvider.of<ParkingBloc>(context);
    parkingBloc.add(FetchTruckSpotsHistoricDayEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ParkingBloc parkingBloc = BlocProvider.of<ParkingBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Histórico do dia",
        ),
      ),
      body: BlocListener<ParkingBloc, ParkingState>(
        listener: (context, state) {
          if (state is SetExitTruckSpotSuccessState) {
            parkingBloc.add(FetchTruckSpotsHistoricDayEvent());
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocBuilder<ParkingBloc, ParkingState>(
              buildWhen: (_, state) {
                return (state is ParkingSearchLoadingState ||
                    state is ParkingHistoricDayFailState ||
                    state is ParkingHistoricDaySuccessState);
              },
              builder: (context, state) {
                if (state is ParkingSearchLoadingState) {
                  return const LoadingWidget();
                } else if (state is ParkingHistoricDaySuccessState) {
                  return ListSpotsWidget(
                    truckSpots: state.spots,
                    parkingBloc: parkingBloc,
                    fromSearch: true,
                    title: "Vagas cadastradas no dia de hoje",
                  );
                } else {
                  return const Center(
                    child: Text("Ocorreu um erro!"),
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
