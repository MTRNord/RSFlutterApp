// TODO fix placeholder
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'tabs/MapTab.dart';
import 'tabs/SettingsTab.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Theme.of(context).primaryColor,
          child: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Theme.of(context).accentColor,
            tabs: [
              Tab(
                icon: Icon(CupertinoIcons.location),
                text: 'Map',
              ),
              Tab(
                icon: Icon(CupertinoIcons.info),
                text: 'Rangliste',
              ),
              Tab(
                icon: Icon(CupertinoIcons.settings),
                text: 'Einstellungen',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Scaffold(
              body: MapTab(),
            ),
            Scaffold(
              body: Container(),
            ),
            Scaffold(
              appBar: AppBar(
                title: Text("Einstellungen"),
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
