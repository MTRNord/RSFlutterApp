import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/models.dart';
import '../repos/repositories.dart';

class DetailsPage extends StatelessWidget {
  final Station station;
  final RailwayStationsRepository railwayStationsRepository;

  const DetailsPage(
      {Key key,
      @required this.station,
      @required this.railwayStationsRepository})
      : assert(railwayStationsRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bahnhofs-Details"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.directions),
            onPressed: () {
              MapsLauncher.launchCoordinates(station.lat, station.lon);
            },
          ),
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () async {
              Country country = (await railwayStationsRepository.getCountries())
                  .firstWhere((element) => element.code == station.country);
              launch(country.timetableUrlTemplate
                  .replaceAll("{id}", station.idStr)
                  .replaceAll("{title}", station.title)
                  .replaceAll("{DS100}", station.ds100));
            },
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            station.title,
            style: Theme.of(context)
                .primaryTextTheme
                .headline3
                .copyWith(color: Colors.black),
          ),
          Image.network(station.photoUrl),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Text("Urheber: "),
                RichText(
                  text: TextSpan(
                    text: station.photographer,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launch(station.photographerUrl);
                      },
                  ),
                ),
                Text(", "),
                RichText(
                  text: TextSpan(
                    text: station.license,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launch(station.licenseUrl);
                      },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
