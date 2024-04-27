import 'dart:async';
import 'package:flutter/material.dart';

import '../../commons/commons.dart';
import '../data.dart';

class NasaDataBloc {
  final _repository = NasaReposotory(client: HttpClient());
  final StreamController<NasaDataEvent> _inputNasaController =
      StreamController<NasaDataEvent>();
  final StreamController<NasaDataState> _outputNasaController =
      StreamController<NasaDataState>();
  final ValueNotifier<List<NasaData>> nasaDataComplete =
      ValueNotifier<List<NasaData>>([]);

  Sink<NasaDataEvent> get inputNasa => _inputNasaController.sink;
  Stream<NasaDataState> get outputNasa => _outputNasaController.stream;

  NasaDataBloc() {
    _inputNasaController.stream.listen(_mapEventToState);
  }

  Future<void> _mapEventToState(NasaDataEvent event) async {
    List<NasaData> nasaData = [];
    _outputNasaController.add(NasaDataLoadingState());

    if (event is GetNasaEvent) {
      nasaData = await _repository.getNasaData();
    } else if (event is GetNasaFilteredEvent) {
      nasaDataComplete.value = event.nasaData;
      nasaData = await _repository.getNasaDataFiltered(event.nasaData,
          startDate: event.startData,
          endDate: event.endData,
          title: event.title);
    } else if (event is RecoveryNasaEvent) {
      nasaData = nasaDataComplete.value;
      nasaDataComplete.value = [];
    }

    _outputNasaController.add(NasaDataLoadedState(nasaData: nasaData));
  }
}
