import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';
import 'package:rs_flutter_app/events/MapEvent.dart';

import '../../blocs/MapBloc.dart';
import '../../models/models.dart';
import '../../states/MapState.dart';

class MapTab extends StatefulWidget {
  @override
  MapTabState createState() => MapTabState();
}

class MapTabState extends State<MapTab> {
  MapTabState();

  List<Station> stations;
  final _initialCenter = LatLng(51.133481, 10.018343);
  final _initialZoom = 6.0;

  List<Marker> _makeStationMarkers(List<Station> stations) {
    List<Marker> stationMarkers = List();
    stations.forEach((element) {
      stationMarkers.add(Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(element.lat, element.lon),
        builder: (BuildContext context) => Icon(Icons.pin_drop),
      ));
    });
    return stationMarkers;
  }

  @override
  Widget build(BuildContext context) {
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
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
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
              builder: (context, markers) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    color: CupertinoTheme.of(context).primaryColor,
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
}
