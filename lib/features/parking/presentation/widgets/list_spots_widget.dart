import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:park_manager/features/parking/data/models/truck_spot_model.dart';
import 'package:park_manager/features/parking/domain/entities/truck_spot.dart';
import 'package:park_manager/features/parking/presentation/bloc/parking_bloc.dart';

class ListSpotsWidget extends StatelessWidget {
  final List<TruckSpot> truckSpots;
  final ParkingBloc parkingBloc;
  final String title;
  final bool fromSearch;

  const ListSpotsWidget({
    super.key,
    required this.truckSpots,
    required this.parkingBloc,
    required this.title,
    this.fromSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            color: Colors.grey,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            margin: const EdgeInsets.only(
              bottom: 20,
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Vagas em uso: ${truckSpots.where((truckSpot) => truckSpot.exit.isEmpty).length.toString()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Vagas registradas: ${truckSpots.length}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: truckSpots.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final spot = truckSpots[index];
                return ListTile(
                  tileColor: index.isOdd ? Colors.black.withOpacity(0.01) : Colors.white,
                  isThreeLine: true,
                  title: Text(
                    "Vaga: ${spot.spot}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Placa: ${spot.plate}"),
                      Text("Entrada: ${spot.entry}"),
                      Visibility(
                        visible: spot.exit.isNotEmpty,
                        child: Text(
                          "Saída: ${spot.exit}",
                        ),
                      ),
                      Center(
                        child: Visibility(
                          visible: spot.exit.isEmpty,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.exit_to_app_outlined,
                              ),
                              label: const Text("Registrar saída"),
                              onPressed: (() {
                                final data = TruckSpotModel(
                                  id: spot.id,
                                  spot: spot.spot,
                                  plate: spot.plate,
                                  entry: spot.entry,
                                  exit: DateFormat('dd/MM/yyyy kk:mm').format(DateTime.now()),
                                );

                                parkingBloc.add(
                                  SetExitTruckSpotEvent(
                                    spot: data,
                                    fromSearch: fromSearch,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
