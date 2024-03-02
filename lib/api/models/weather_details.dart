// To parse this JSON data, do
//
//     final weatherDetailsModel = weatherDetailsModelFromJson(jsonString);

import 'dart:convert';

WeatherDetailsModel weatherDetailsModelFromJson(String str) =>
    WeatherDetailsModel.fromJson(json.decode(str));

String weatherDetailsModelToJson(WeatherDetailsModel data) =>
    json.encode(data.toJson());

class WeatherDetailsModel {
  String? version;
  String? user;
  DateTime? dateGenerated;
  String? status;
  List<Datum>? data;

  WeatherDetailsModel({
    this.version,
    this.user,
    this.dateGenerated,
    this.status,
    this.data,
  });

  factory WeatherDetailsModel.fromJson(Map<String, dynamic> json) =>
      WeatherDetailsModel(
        version: json["version"],
        user: json["user"],
        dateGenerated: json["dateGenerated"] == null
            ? null
            : DateTime.parse(json["dateGenerated"]),
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "user": user,
        "dateGenerated": dateGenerated?.toIso8601String(),
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? parameter;
  List<Coordinate>? coordinates;

  Datum({
    this.parameter,
    this.coordinates,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        parameter: json["parameter"],
        coordinates: json["coordinates"] == null
            ? []
            : List<Coordinate>.from(
                json["coordinates"]!.map((x) => Coordinate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "parameter": parameter,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x.toJson())),
      };
}

class Coordinate {
  double? lat;
  double? lon;
  List<Date>? dates;

  Coordinate({
    this.lat,
    this.lon,
    this.dates,
  });

  factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        dates: json["dates"] == null
            ? []
            : List<Date>.from(json["dates"]!.map((x) => Date.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "dates": dates == null
            ? []
            : List<dynamic>.from(dates!.map((x) => x.toJson())),
      };
}

class Date {
  DateTime? date;
  double? value;

  Date({
    this.date,
    this.value,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        value: json["value"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "value": value,
      };
}
