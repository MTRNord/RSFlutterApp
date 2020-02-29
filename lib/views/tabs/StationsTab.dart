import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rs_flutter_app/components/SearchBar.dart';

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
  final filterTextController = TextEditingController();
  List<Station> stations;
  String filterText;

  List<Station> filter() {
    var stationsL = stations;
    if (filterText != null && filterText != "") {
      stationsL = stations
          .where(
            (station) => (filterText != null &&
                filterText != "" &&
                station.title
                    .toLowerCase()
                    .startsWith(filterText.toLowerCase())),
          )
          .toList(growable: false);
    }
    return stationsL;
  }

  void handleFilter() {
    setState(() {
      filterText = filterTextController.text;
    });
  }

  @override
  initState() {
    super.initState();
    filterTextController.addListener(handleFilter);
  }

  @override
  void dispose() {
    filterTextController.removeListener(handleFilter);
    super.dispose();
  }

  Future<List<Station>> getStations(String filterText) async {
    if (stations == null) {
      List<Station> stationsL =
          await widget.railwayStationsRepository.getStations();
      stationsL.sort(
        (a, b) => (a.title).compareTo(b.title),
      );
      stations = stationsL;
    }
    return stations;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Bahnhöfe"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: SearchBar(
              filterTextController: filterTextController,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Station>>(
        future: getStations(filterText),
        builder: (BuildContext context, AsyncSnapshot<List<Station>> snapshot) {
          if (snapshot.hasError) {
            // TODO handle error
            debugPrint(snapshot.error.toString());
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var filtered = filter();

          if (filtered == null || filtered.isEmpty) {
            return Container();
          }

          if (stations.isEmpty) {
            return Container();
          }

          return ListView.separated(
            itemCount: filtered.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                trailing:
                    filtered[index].photoUrl != "" ? Icon(Icons.image) : null,
                title: Text(filtered[index].title),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => DetailsPage(
                        station: filtered[index],
                        railwayStationsRepository:
                            widget.railwayStationsRepository,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
