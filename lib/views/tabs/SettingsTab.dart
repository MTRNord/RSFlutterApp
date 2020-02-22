import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsTab extends StatefulWidget {
  @override
  SettingsTabState createState() => SettingsTabState();
}

class SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SettingsList(sections: [
        SettingsSection(
          title: 'Bahnhofsdaten',
          tiles: [
            SettingsTile(
              title: 'Länderdaten aktualisieren',
              leading: Icon(Icons.language),
              onTap: () {},
            ),
          ],
        ),
        SettingsSection(
          title: 'Lizensierung',
          tiles: [],
        ),
        SettingsSection(
          title: 'Verlinkung',
          tiles: [],
        ),
      ]),
    );
  }
}
