import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../data.dart';

mixin DataStorage {
  final storage = GetStorage();

  final nasaLocalData = 'nasaLocalData';

  Future<void> saveDataStorage(List<NasaData> nasaLocalDataValue) async {
    var encondedData = jsonEncode(nasaLocalDataValue);
    await storage.write(nasaLocalData, encondedData);
  }

  List<NasaData>? readDataStorage() {
    List<NasaData> nasaData = [];
    final data = storage.read<dynamic>(nasaLocalData) ?? [];
    if (data.isNotEmpty) {
      final parsed = jsonDecode(data).cast<Map<String, dynamic>>();
      nasaData =
          parsed.map<NasaData>((json) => NasaData.fromJson(json)).toList();
    }

    return nasaData;
  }

  void removeDataStorage() {
    storage.remove(nasaLocalData);
  }
}
