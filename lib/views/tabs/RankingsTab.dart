import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rs_flutter_app/components/SearchBar.dart';

import '../../repos/repositories.dart';

class RankingsTab extends StatefulWidget {
  final RailwayStationsRepository railwayStationsRepository;

  RankingsTab({@required this.railwayStationsRepository})
      : assert(railwayStationsRepository != null);

  @override
  RankingsTabState createState() => RankingsTabState();
}

class RankingsTabState extends State<RankingsTab>
    with AutomaticKeepAliveClientMixin<RankingsTab> {
  final filterTextController = TextEditingController();
  List<List<String>> scores;
  String filterText;

  List<List<String>> filter() {
    var scoresL = scores;
    if (filterText != null && filterText != "") {
      scoresL = scores
          .where(
            (score) => (filterText != null &&
                filterText != "" &&
                score[1].toLowerCase().contains(filterText.toLowerCase())),
          )
          .toList(growable: false);
    }
    return scoresL;
  }

  Future<List<List<String>>> getScores() async {
    if (scores == null) {
      List<List<String>> scoresL =
          await widget.railwayStationsRepository.getScores();

      scoresL.removeAt(0);
      scoresL.sort(
        (a, b) => (int.parse(b.first)).compareTo(int.parse(a.first)),
      );
      scores = scoresL;
    }
    return scores;
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

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Rangliste"),
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
      body: FutureBuilder(
        future: getScores(),
        builder:
            (BuildContext context, AsyncSnapshot<List<List<String>>> snapshot) {
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

          if (scores.isEmpty) {
            return Container();
          }

          return ListView.separated(
            itemCount: filtered.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              if (scores
                      .indexWhere((score) => score[1] == filtered[index][1]) ==
                  0) {
                return ListTile(
                  leading: SvgPicture.asset(
                    "assets/crown_gold.svg",
                    semanticsLabel: 'Golden Crown',
                    width: 50,
                    height: 50,
                  ),
                  title: Text(filtered[index][1]),
                );
              } else if (scores
                      .indexWhere((score) => score[1] == filtered[index][1]) ==
                  1) {
                return ListTile(
                  leading: SvgPicture.asset(
                    "assets/crown_silver.svg",
                    semanticsLabel: 'Silver Crown',
                    width: 50,
                    height: 50,
                  ),
                  title: Text(filtered[index][1]),
                );
              } else if (scores
                      .indexWhere((score) => score[1] == filtered[index][1]) ==
                  2) {
                return ListTile(
                  leading: SvgPicture.asset(
                    "assets/crown_bronze.svg",
                    semanticsLabel: 'Bronze Crown',
                    width: 50,
                    height: 50,
                  ),
                  title: Text(filtered[index][1]),
                );
              } else {
                return ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: Text(
                        "${(scores.indexWhere((score) => score[1] == filtered[index][1]) + 1)}.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  title: Text(filtered[index][1]),
                );
              }
            },
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
