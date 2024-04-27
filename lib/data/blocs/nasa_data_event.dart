import '../data.dart';

abstract class NasaDataEvent {}

class GetNasaEvent extends NasaDataEvent {}

class RecoveryNasaEvent extends NasaDataEvent {}

class GetNasaFilteredEvent extends NasaDataEvent {
  final List<NasaData> nasaData;
  final DateTime? startData;
  final DateTime? endData;
  final String? title;

  GetNasaFilteredEvent(
      {required this.nasaData, this.startData, this.endData, this.title});
}
