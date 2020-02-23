import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../repos/repositories.dart';
import '../DetailsPage.dart';

class StationsTab extends StatelessWidget {
  final RailwayStationsRepository railwayStationsRepository;

  StationsTab({@required this.railwayStationsRepository})
      : assert(railwayStationsRepository != null);

  Future<List<Station>> getStations() {
    return this.railwayStationsRepository.getStations();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getStations(),
      builder: (BuildContext context, AsyncSnapshot<List<Station>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasError) {
              // TODO handle error
              debugPrint(snapshot.error.toString());
            }
            if (snapshot.hasData) {
              List<Station> stations = snapshot.data;
              stations.sort(
                (a, b) => (a.title).compareTo(b.title),
              );

              return ListView.separated(
                itemCount: stations.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    trailing: stations[index].photoUrl != ""
                        ? Icon(Icons.image)
                        : null,
                    title: Text(stations[index].title),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => DetailsPage(
                            station: stations[index],
                            railwayStationsRepository:
                                railwayStationsRepository,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
            // TODO handle missing date
            return Container();
          default:
            return Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
