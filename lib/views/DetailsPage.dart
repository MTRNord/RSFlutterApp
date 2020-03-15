import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
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

  Future<List<Asset>> _pickImages() async {
    List<Asset> resultList;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        materialOptions: MaterialOptions(
          actionBarTitle: "Albums",
          allViewTitle: "All images",
          actionBarColor: "#c71c4d",
          actionBarTitleColor: "#ffffff",
          lightStatusBar: false,
          statusBarColor: '#c71c4d',
          startInAllView: false,
          selectCircleStrokeColor: "#000000",
          selectionLimitReachedText: "You can only upload one image at a time.",
          autoCloseOnSelectionLimit: true,
        ),
      );
    } on NoImagesSelectedException catch (e) {
      debugPrint("User selected nothing");
    } on Exception catch (e) {
      debugPrint(e.toString());
    }

    debugPrint(resultList.toString());

    return resultList;
  }

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
              await launch(country.timetableUrlTemplate
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
          station.photoUrl != null
              ? Image.network(station.photoUrl)
              : Container(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: IconButton(
                iconSize: 50,
                icon: Icon(
                  Icons.camera_alt,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  _pickImages();
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              children: <Widget>[
                Text(station.license != "" ? "Urheber: " : ""),
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
                Text(station.license != "" ? ", " : ""),
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
