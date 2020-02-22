import 'package:flutter/cupertino.dart';

import '../models/models.dart';
import 'RailwayStationsApiClient.dart';

class RailwayStationsRepository {
  final RailwayStationsApiClient railwayStationsApiClient;

  RailwayStationsRepository({@required this.railwayStationsApiClient})
      : assert(railwayStationsApiClient != null);

  Future<List<Country>> getCountries() async {
    return await railwayStationsApiClient.getCountries();
  }

  Future<List<Station>> getStations() async {
    return await railwayStationsApiClient.getStations();
  }
}
