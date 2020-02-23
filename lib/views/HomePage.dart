import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../blocs/MapBloc.dart';
import '../repos/RailwayStationsApiClient.dart';
import '../repos/repositories.dart';
import 'tabs/MapTab.dart';
import 'tabs/RankingsTab.dart';
import 'tabs/SettingsTab.dart';
import 'tabs/StationsTab.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RailwayStationsRepository railwayStationsRepository =
        RailwayStationsRepository(
      railwayStationsApiClient: RailwayStationsApiClient(
        httpClient: http.Client(),
      ),
    );

    return DefaultTabController(
      length: 4,
      initialIndex: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Theme.of(context).primaryColor,
          child: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorSize: TabBarIndicatorSize.tab,
            //indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Theme.of(context).accentColor,
            tabs: [
              Tab(
                icon: Icon(
                  CupertinoIcons.location,
                  size: 20,
                ),
                text: 'Map',
              ),
              Tab(
                icon: Icon(
                  CupertinoIcons.info,
                  size: 20,
                ),
                text: 'Rangliste',
              ),
              Tab(
                icon: Icon(
                  CupertinoIcons.train_style_one,
                  size: 20,
                ),
                text: 'Bahnhöfe',
              ),
              Tab(
                icon: Icon(
                  CupertinoIcons.profile_circled,
                  size: 20,
                ),
                text: 'Meine Daten',
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Scaffold(
              body: BlocProvider(
                create: (context) => MapBloc(
                  railwayStationsRepository: railwayStationsRepository,
                ),
                child: MapTab(
                  railwayStationsRepository: railwayStationsRepository,
                ),
              ),
            ),
            Scaffold(
              appBar: AppBar(
                title: Text("Rangliste"),
              ),
              body: RankingsTab(
                railwayStationsRepository: railwayStationsRepository,
              ),
            ),
            Scaffold(
              appBar: AppBar(
                title: Text("Bahnhöfe"),
              ),
              body: StationsTab(
                railwayStationsRepository: railwayStationsRepository,
              ),
            ),
            Scaffold(
              appBar: AppBar(
                title: Text("Meine Daten"),
              ),
              body: SettingsTab(),
            ),
          ],
        ),
        /* child: Container(
        child: Center(
            child: RaisedButton(
          child: Text('logout'),
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
          },
        )),
      ),*/
      ),
    );
  }
}
