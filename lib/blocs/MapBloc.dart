import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../events/MapEvent.dart';
import '../models/models.dart';
import '../repos/repositories.dart';
import '../states/MapState.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final RailwayStationsRepository railwayStationsRepository;

  MapBloc({@required this.railwayStationsRepository})
      : assert(railwayStationsRepository != null);

  @override
  MapState get initialState => MapLoading();

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is FetchStations) {
      yield MapLoading();
      try {
        final List<Station> stations =
            await railwayStationsRepository.getStations();
        yield MapLoaded(stations: stations);
      } catch (_) {
        yield MapError();
      }
    } else if (event is RenderMap) {
      yield MapRender();
    }
  }
}
