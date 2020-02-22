import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../models/models.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final List<Station> stations;

  const MapLoaded({@required this.stations}) : assert(stations != null);

  @override
  List<Object> get props => [stations];
}

class MapRender extends MapState {}

class MapError extends MapState {}
