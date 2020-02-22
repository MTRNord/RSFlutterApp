import 'package:equatable/equatable.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();
}

class FetchStations extends MapEvent {
  const FetchStations();

  @override
  List<Object> get props => [];
}

class RenderMap extends MapEvent {
  @override
  List<Object> get props => [];
}
