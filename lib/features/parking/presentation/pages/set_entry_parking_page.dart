import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:park_manager/features/parking/data/models/truck_spot_model.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:park_manager/features/parking/presentation/bloc/parking_bloc.dart';
import 'package:intl/intl.dart';
import 'package:park_manager/features/parking/presentation/widgets/loading_widget.dart';

class SetEntryParkingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy kk:mm').format(DateTime.now());
    final _formKey = GlobalKey<FormState>();
    final _spotController = TextEditingController();
    final _plateController = TextEditingController();
    final _entryController = TextEditingController(
      text: formattedDate,
    );
    ParkingBloc parkingBloc = BlocProvider.of<ParkingBloc>(context);

    final maskFormatter = MaskTextInputFormatter(
      mask: '##/##/#### ##:##', // Use '##/##/#### ##:##' para data e hora
      filter: {"#": RegExp(r'[0-9]')},
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar vaga'),
      ),
      body: BlocBuilder<ParkingBloc, ParkingState>(
        builder: (context, state) {
          if (state is ParkingLoadingState) {
            return const LoadingWidget();
          } else if (state is SendSpotSuccessState) {
            _entryController.clear();
            _plateController.clear();
            _spotController.clear();

            return AlertDialog(
              elevation: 5,
              backgroundColor: Colors.blue.withOpacity(0.2),
              title: const Center(
                child: Text("Vaga adicionada!"),
              ),
              content: Text("A vaga foi registrada corretamente, o que deseja fazer agora?"),
              actions: [
                ElevatedButton(
                  child: Text("Voltar"),
                  onPressed: () {
                    parkingBloc.add(ReloadTruckSpotsEvent());
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("Adicionar nova vaga"),
                  onPressed: () => parkingBloc.add(ParkingEventInitial()),
                )
              ],
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _spotController,
                    decoration: const InputDecoration(labelText: 'Vaga'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira uma vaga.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _plateController,
                    decoration: const InputDecoration(
                      labelText: 'Placa',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira uma placa.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _entryController,
                    decoration: const InputDecoration(
                      labelText: 'Data e hora da entrada',
                      hintText: "DD/MM/AAAA HH:MM",
                    ),
                    keyboardType: TextInputType.datetime,
                    inputFormatters: [maskFormatter],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira a data e hora da entrada.';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final spot = int.parse(_spotController.text);
                          final plate = _plateController.text;
                          final entry = _entryController.text;

                          final data = TruckSpotModel(
                            spot: spot,
                            plate: plate,
                            entry: entry,
                            exit: '',
                          );
                          parkingBloc.add(SetEntryTruckSpotEvent(spot: data));

                          log('Dados enviados: $data');
                        }
                      },
                      icon: const Icon(Icons.file_download_done_outlined),
                      label: const Text('Cadastrar vaga'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
