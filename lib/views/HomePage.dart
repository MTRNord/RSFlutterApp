// TODO fix placeholder
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'tabs/MapTab.dart';
import 'tabs/SettingsTab.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.location),
            title: Text('Map'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.info),
            title: Text('Rangliste'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            title: Text('Einstellungen'),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: MapTab(),
              );
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: Container(),
              );
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text("Einstellungen"),
                ),
                child: SettingsTab(),
              );
            });
        }
        return CupertinoPageScaffold(
          child: Container(),
        );
      },
      /* child: Container(
        child: Center(
            child: RaisedButton(
          child: Text('logout'),
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
          },
        )),
      ),*/
    );
  }
}
