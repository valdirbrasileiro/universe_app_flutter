import 'dart:convert';
import 'package:flutter/material.dart';

import '../../commons/commons.dart';
import '../data.dart';

abstract class INasaRepository {
  Future<List<NasaData>> getNasaData();
}

class NasaReposotory with DataStorage implements INasaRepository {
  final IHttpClient client;

  NasaReposotory({required this.client});
  @override
  Future<List<NasaData>> getNasaData() async {
    final dataStorage = readDataStorage();
    try {
      final response = await client.get(
          url: 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=20');

      if (response.statusCode == 200) {
        final List<NasaData> nasaData = parseNasaDataList(response.body);
        removeDataStorage();
        await saveDataStorage(nasaData);
        return nasaData;
      } else if (response.statusCode == 404) {
        if (dataStorage != null && dataStorage.isNotEmpty) {
          return dataStorage;
        }
        throw NotFoundException('Requisição inválida');
      } else {
        if (dataStorage != null && dataStorage.isNotEmpty) {
          return dataStorage;
        }
        throw Exception('Não foi possível carregar imagens da NASA');
      }
    } catch (e) {
      if (dataStorage != null && dataStorage.isNotEmpty) {
        return dataStorage;
      }
      debugPrint(e.toString());
      throw Exception('Não foi possível carregar imagens da NASA');
    }
  }

  Future<List<NasaData>> getNasaDataFiltered(List<NasaData> nasaData,
      {DateTime? startDate, DateTime? endDate, String? title}) async {
    List<NasaData> filteredList = [];

    if (startDate != null && endDate != null) {
      filteredList.addAll(nasaData.where((data) {
        DateTime dataDate = DateTime.parse(data.date);
        return dataDate.isAfter(startDate) && dataDate.isBefore(endDate);
      }).toList());
    } else {
      if (startDate != null) {
        filteredList.addAll(nasaData
            .where((data) => DateTime.parse(data.date).isAfter(startDate))
            .toList());
      }
      if (endDate != null) {
        filteredList.addAll(nasaData
            .where((data) => DateTime.parse(data.date).isBefore(endDate))
            .toList());
      }
    }

    if (title != null && title.isNotEmpty) {
      filteredList.addAll(nasaData
          .where(
              (data) => data.title.toLowerCase().contains(title.toLowerCase()))
          .toList());
    }

    return filteredList;
  }

  List<NasaData> parseNasaDataList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    final filteredData =
        parsed.where((json) => json['media_type'] == 'image').toList();
    return filteredData
        .map<NasaData>((json) => NasaData.fromJson(json))
        .toList();
  }
}
