import 'package:flutter/cupertino.dart';

import '../models/models.dart';
import 'RailwayStationsApiClient.dart';

class RailwayStationsRepository {
  final RailwayStationsApiClient railwayStationsApiClient;

  RailwayStationsRepository({@required this.railwayStationsApiClient})
      : assert(railwayStationsApiClient != null);

  Future<List<Country>> getCountries() {
    return railwayStationsApiClient.getCountries();
  }

  Future<List<Station>> getStations() {
    return railwayStationsApiClient.getStations();
  }

  Future<List<List<String>>> getScores() {
    return railwayStationsApiClient.getScores();
  }
}
