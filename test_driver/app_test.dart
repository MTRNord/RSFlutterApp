// Imports the Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Bahnhofsfotos App', () {
    FlutterDriver driver;
    //final String backButtonToolTip = "Back"; // Set to your preferred language

    // Connect to the Flutter driver before running any tests
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed
    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    /*var waitFor = (String key) async {
      print("[Integration Test] Wait for $key");
      await driver.waitFor(find.byValueKey(key));
    };

    var tap = (String key) async {
      print("[Integration Test] Tap on $key");
      await driver.waitFor(find.byValueKey(key));
      await driver.tap(find.byValueKey(key));
    };

    var tapOnText = (String text) async {
      print("[Integration Test] Tap on $text");
      await driver.waitFor(find.text(text));
      await driver.tap(find.text(text));
    };

    var enterText = (String text) async {
      print("[Integration Test] Enter text: $text");
      await driver.enterText(text);
    };
    var goBack = () async {
      await driver.waitFor(find.byTooltip(backButtonToolTip));
      await driver.tap(find.byTooltip(backButtonToolTip));
    };*/
  });
}
