import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';

import '../../blocs/MapBloc.dart';
import '../../events/MapEvent.dart';
import '../../models/models.dart';
import '../../repos/repositories.dart';
import '../../states/MapState.dart';
import '../DetailsPage.dart';

class MapTab extends StatefulWidget {
  final RailwayStationsRepository railwayStationsRepository;

  MapTab({@required this.railwayStationsRepository})
      : assert(railwayStationsRepository != null);

  @override
  MapTabState createState() => MapTabState();
}

class MapTabState extends State<MapTab>
    with AutomaticKeepAliveClientMixin<MapTab> {
  MapTabState();

  List<Station> stations;
  final _initialCenter = LatLng(51.133481, 10.018343);
  final _initialZoom = 6.0;

  List<Marker> _makeStationMarkers(List<Station> stations) {
    List<Marker> stationMarkers = List();
    stations.forEach((element) {
      if (element.active) {
        stationMarkers.add(Marker(
          anchorPos: AnchorPos.align(AnchorAlign.center),
          height: 30,
          width: 30,
          point: LatLng(element.lat, element.lon),
          builder: (BuildContext context) => Icon(Icons.pin_drop),
        ));
      }
      // Todo calculate an extra layer for deactivated stations
    });
    return stationMarkers;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // Fetch map data on opening
    if (stations == null) {
      BlocProvider.of<MapBloc>(context).add(FetchStations());
    }

    return BlocBuilder<MapBloc, MapState>(builder: (context, state) {
      if (state is MapLoading) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is MapRender) {
        return FlutterMap(
          options: MapOptions(
            center: _initialCenter,
            zoom: _initialZoom,
            plugins: [
              MarkerClusterPlugin(),
            ],
          ),
          layers: [
            // Mapbox
            TileLayerOptions(
              //tileSize: 1024,
              zoomOffset: -1,
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/mapbox/{id}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1IjoibXRybm9yZCIsImEiOiJjaXIyZTRhNDcwMDhwaTJtZzBseTNkancxIn0.09m6ZCFvkKL6Ppss7XAnfA',
                'id': 'streets-v11',
              },
            ),
            // Openstreetmap
            /*TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.de/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),*/
            // Transport Map
            /*TileLayerOptions(
              urlTemplate: "http://tile.memomaps.de/tilegen/{z}/{x}/{y}.png",
              subdomains: [],
            ),*/
            // Railway overlay
            /*TileLayerOptions(
              urlTemplate:
                  "https://{s}.tiles.openrailwaymap.org/standard/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              opacity: 0.2,
            ),*/
            MarkerClusterLayerOptions(
              maxClusterRadius: 120,
              size: Size(50, 50),
              fitBoundsOptions: FitBoundsOptions(
                padding: EdgeInsets.all(50),
              ),
              markers: _makeStationMarkers(stations),
              polygonOptions: PolygonOptions(
                borderColor: Colors.blueAccent,
                color: Colors.black12,
                borderStrokeWidth: 3,
              ),
              onMarkerTap: (Marker marker) {
                Station station = stations.firstWhere((element) =>
                    element.lat == marker.point.latitude &&
                    element.lon == marker.point.longitude);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => DetailsPage(
                      station: station,
                      railwayStationsRepository:
                          widget.railwayStationsRepository,
                    ),
                  ),
                );
              },
              builder: (context, markers) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Text(
                        markers.length.toString(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      }
      if (state is MapLoaded) {
        return FutureBuilder(
          future: _cacheData(state.stations),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Center(child: CircularProgressIndicator());
          },
        );
      }
      // Todo show reload button on error
      if (state is MapError) {
        return Text(
          'Something went wrong!',
          style: TextStyle(color: Colors.red),
        );
      }
      return Text(
        'Something went wrong2!',
        style: TextStyle(color: Colors.red),
      );
    });
  }

  _cacheData(List<Station> stations) async {
    setState(() {
      this.stations = stations;
      BlocProvider.of<MapBloc>(context).add(RenderMap());
    });
  }

  @override
  bool get wantKeepAlive => true;
}
