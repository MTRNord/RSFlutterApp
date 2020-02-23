import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../repos/repositories.dart';

class RankingsTab extends StatelessWidget {
  final RailwayStationsRepository railwayStationsRepository;

  RankingsTab({@required this.railwayStationsRepository})
      : assert(railwayStationsRepository != null);

  Future<List<List<String>>> getScores() {
    return this.railwayStationsRepository.getScores();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getScores(),
      builder:
          (BuildContext context, AsyncSnapshot<List<List<String>>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasError) {
              // TODO handle error
              debugPrint(snapshot.error.toString());
            }
            if (snapshot.hasData) {
              List<List<String>> scores = snapshot.data;
              scores.removeAt(0);
              scores.sort(
                (a, b) => (int.parse(b.first)).compareTo(int.parse(a.first)),
              );

              return ListView.separated(
                itemCount: scores.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return ListTile(
                      leading: SvgPicture.asset(
                        "assets/crown_gold.svg",
                        semanticsLabel: 'Golden Crown',
                        width: 50,
                        height: 50,
                      ),
                      title: Text(scores[index][1]),
                    );
                  } else if (index == 1) {
                    return ListTile(
                      leading: SvgPicture.asset(
                        "assets/crown_silver.svg",
                        semanticsLabel: 'Silver Crown',
                        width: 50,
                        height: 50,
                      ),
                      title: Text(scores[index][1]),
                    );
                  } else if (index == 2) {
                    return ListTile(
                      leading: SvgPicture.asset(
                        "assets/crown_bronze.svg",
                        semanticsLabel: 'Bronze Crown',
                        width: 50,
                        height: 50,
                      ),
                      title: Text(scores[index][1]),
                    );
                  } else {
                    return ListTile(
                      leading: SizedBox(
                        width: 50,
                        height: 50,
                        child: Center(
                          child: Text(
                            "${(index + 1)}.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      title: Text(scores[index][1]),
                    );
                  }
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
