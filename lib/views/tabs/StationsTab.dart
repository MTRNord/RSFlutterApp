import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../repos/repositories.dart';
import '../DetailsPage.dart';

class StationsTab extends StatefulWidget {
  final RailwayStationsRepository railwayStationsRepository;

  StationsTab({@required this.railwayStationsRepository})
      : assert(railwayStationsRepository != null);

  @override
  StationsTabState createState() => StationsTabState();
}

class StationsTabState extends State<StationsTab>
    with AutomaticKeepAliveClientMixin<StationsTab> {
  List<Station> stations;

  Future<List<Station>> getStations() async {
    if (stations == null) {
      stations = await widget.railwayStationsRepository.getStations();
    }
    return stations;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
                                widget.railwayStationsRepository,
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

  @override
  bool get wantKeepAlive => true;
}
