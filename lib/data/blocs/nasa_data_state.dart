import '../data.dart';

abstract class NasaDataState {
  final List<NasaData> nasaData;

  NasaDataState({required this.nasaData});
}

class NasaDataInicialState extends NasaDataState {
  NasaDataInicialState() : super(nasaData: []);
}

class NasaDataLoadingState extends NasaDataState {
  NasaDataLoadingState() : super(nasaData: []);
}

class NasaDataLoadedState extends NasaDataState {
  NasaDataLoadedState({required List<NasaData> nasaData})
      : super(nasaData: nasaData);
}

class NasaDataErrorState extends NasaDataState {
  final Exception exception;
  NasaDataErrorState({required this.exception}) : super(nasaData: []);
}
