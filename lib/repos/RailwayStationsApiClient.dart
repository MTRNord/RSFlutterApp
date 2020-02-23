import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:grizzly_io/grizzly_io.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../models/models.dart';

class RailwayStationsApiClient {
  static const baseUrl = 'https://api.railway-stations.org';
  final http.Client httpClient;

  RailwayStationsApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<Country>> getCountries() async {
    final countriesUrl = '$baseUrl/countries';
    final countriesResponse = await this.httpClient.get(countriesUrl);
    if (countriesResponse.statusCode != 200) {
      throw Exception('error getting countries');
    }

    List<Country> countries = List();
    final countriesJson = jsonDecode(countriesResponse.body);
    (countriesJson as List).forEach((element) {
      countries.add(Country.fromJson(element));
    });
    return countries;
  }

  Future<List<Station>> getStations() async {
    final stationsUrl = '$baseUrl/stations';
    final stationsResponse = await this.httpClient.get(stationsUrl);
    if (stationsResponse.statusCode != 200) {
      throw Exception('error getting stations');
    }

    List<Station> stations = List();
    final stationsJson = jsonDecode(stationsResponse.body);
    (stationsJson as List).forEach((element) {
      stations.add(Station.fromJson(element));
    });
    return stations;
  }

  Future<List<List<String>>> getScores() async {
    final scoresUrl = '$baseUrl/photographers.txt';
    final scoresResponse = await this.httpClient.get(scoresUrl);
    if (scoresResponse.statusCode != 200) {
      throw Exception('error getting stations');
    }

    List<List<String>> scores = parseTsv(scoresResponse.body);
    return scores;
  }
}
