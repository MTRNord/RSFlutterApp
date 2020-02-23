import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Station extends Equatable {
  final String country;
  final String idStr;
  final int id;
  final String title;
  final double lat;
  final double lon;
  final String photographer;
  final String photographerUrl;
  final String photoUrl;
  final String license;
  final String licenseUrl;
  final int createdAt;
  final bool active;
  final String ds100;

  Station({
    @required this.country,
    @required this.idStr,
    @required this.id,
    @required this.title,
    @required this.lat,
    @required this.lon,
    @required this.photographer,
    @required this.photographerUrl,
    @required this.photoUrl,
    @required this.license,
    @required this.licenseUrl,
    @required this.createdAt,
    @required this.active,
    @required this.ds100,
  });

  @override
  List<Object> get props => [
        country,
        idStr,
        id,
        title,
        lat,
        lon,
        photographer,
        photographerUrl,
        photoUrl,
        license,
        licenseUrl,
        createdAt,
        active,
        ds100,
      ];

  static Station fromJson(dynamic json) {
    return Station(
      country: json["country"] ?? "",
      idStr: json["idStr"] ?? "",
      id: json["id"] ?? null,
      title: json["title"] ?? "",
      lat: json["lat"] ?? null,
      lon: json["lon"] ?? null,
      photographer: json["photographer"] ?? "",
      photographerUrl: json["photographerUrl"] ?? "",
      photoUrl: json["photoUrl"] ?? "",
      license: json["license"] ?? "",
      licenseUrl: json["licenseUrl"] ?? "",
      createdAt: json["createdAt"] ?? null,
      active: json["active"] ?? false,
      ds100: json["DS100"] ?? "",
    );
  }
}
