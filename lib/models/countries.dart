import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Country extends Equatable {
  final String code;
  final String name;
  final String email;
  final String twitterTags;
  final String timetableUrlTemplate;
  final String overrideLicense;
  final bool active;
  final List<ProviderApp> providerApps;

  const Country({
    @required this.code,
    @required this.name,
    @required this.email,
    @required this.twitterTags,
    this.timetableUrlTemplate,
    this.overrideLicense,
    @required this.active,
    @required this.providerApps,
  });

  @override
  List<Object> get props => [
        code,
        name,
        email,
        twitterTags,
        timetableUrlTemplate,
        overrideLicense,
        active,
        providerApps,
      ];

  static Country fromJson(dynamic json) {
    List<ProviderApp> providerApps = List();
    (json["providerApps"] as List).forEach((element) {
      providerApps.add(ProviderApp.fromJson(element));
    });
    return Country(
      code: json["code"],
      name: json["name"],
      email: json["email"],
      twitterTags: json["twitterTags"],
      timetableUrlTemplate: json["timetableUrlTemplate"],
      overrideLicense: json["overrideLicense"],
      active: json["active"],
      providerApps: providerApps,
    );
  }
}

class ProviderApp extends Equatable {
  final String type;
  final String name;
  final String url;

  ProviderApp({
    @required this.type,
    @required this.name,
    @required this.url,
  });

  @override
  List<Object> get props => [
        type,
        name,
        url,
      ];

  static ProviderApp fromJson(dynamic json) {
    return ProviderApp(
      type: json["type"],
      name: json["name"],
      url: json["url"],
    );
  }
}
