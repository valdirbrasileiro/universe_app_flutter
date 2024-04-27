import 'package:intl/intl.dart';

class NasaData {
  final String date;
  final String explanation;
  final String hdurl;
  final String mediaType;
  final String serviceVersion;
  final String title;
  final String url;

  NasaData({
    required this.date,
    required this.explanation,
    required this.hdurl,
    required this.mediaType,
    required this.serviceVersion,
    required this.title,
    required this.url,
  });

  factory NasaData.fromJson(Map<String, dynamic> json) {
    return NasaData(
      date: json['date'] ?? '',
      explanation: json['explanation'] ?? '',
      hdurl: json['hdurl'] ?? '',
      mediaType: json['media_type'] ?? '',
      serviceVersion: json['service_version'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'explanation': explanation,
      'hdurl': hdurl,
      'mediaType': mediaType,
      'serviceVersion': serviceVersion,
      'title': title,
      'url': url,
    };
  }

  factory NasaData.fromDynamicListItem(dynamic item) {
    return NasaData(
      date: item['date'],
      explanation: item['explanation'],
      hdurl: item['hdurl'] ?? '',
      mediaType: item['media_type'],
      serviceVersion: item['service_version'],
      title: item['title'],
      url: item['url'],
    );
  }

  factory NasaData.fromDynamicListDynamicItem(NasaData item) {
    return NasaData(
        date: item.date,
        explanation: item.explanation,
        hdurl: item.hdurl,
        mediaType: item.mediaType,
        serviceVersion: item.serviceVersion,
        title: item.title,
        url: item.url);
  }

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static List<NasaData> fromDynamicList(List<dynamic> dynamicList) {
    return dynamicList
        .map((dynamicItem) => dynamicItem is Map<String, dynamic>
            ? NasaData.fromDynamicListItem(dynamicItem)
            : NasaData.fromDynamicListDynamicItem(dynamicItem))
        .toList();
  }
}
