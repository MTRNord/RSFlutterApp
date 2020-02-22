import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Station extends Equatable {
  final String country;
  final String idStr;
  final int id;
  final String title;
  final double lat;
  final double lon;

  final bool active;

  Station({
    @required this.country,
    @required this.idStr,
    @required this.id,
    @required this.title,
    @required this.lat,
    @required this.lon,
    @required this.active,
  });

  @override
  List<Object> get props => [
        country,
        idStr,
        id,
        title,
        lat,
        lon,
        active,
      ];

  static Station fromJson(dynamic json) {
    return Station(
      country: json["country"] ?? "",
      idStr: json["idStr"] ?? "",
      id: json["id"] ?? null,
      title: json["title"] ?? "",
      lat: json["lat"] ?? null,
      lon: json["lon"] ?? null,
      active: json["active"] ?? false,
    );
  }
}
