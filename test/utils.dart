import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class Utils {
  static printWidgets(WidgetTester tester) {
    debugPrint(tester.allWidgets.toList().join("\n").toString());
  }

  static bool isWidgetInWidgets(WidgetTester tester, Type widget) {
    debugPrint(tester.allWidgets
        .toList()
        .map((e) => e.runtimeType)
        .join("\n")
        .toString());
    return tester.allWidgets
        .toList()
        .map((e) => e.runtimeType)
        .contains(widget);
  }

  static Widget getWidgetWrapper(Widget child, TestObserver routeObserver) {
    return MaterialApp(
      title: "Fluffychat",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: <NavigatorObserver>[routeObserver],
      home: child,
    );
  }

  static double getOpacity(WidgetTester tester, String textValue) {
    final FadeTransition opacityWidget = tester.widget<FadeTransition>(find
        .ancestor(
          of: find.text(textValue),
          matching: find.byType(FadeTransition),
        )
        .first);
    return opacityWidget.opacity.value;
  }

  static Future<Null> tapItem(WidgetTester tester, Key key) async {
    /// Tap the button which should open the PopupMenu.
    /// By calling tester.pumpAndSettle(), we ensure that all animations
    /// have completed before we continue further.
    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();
  }
}

typedef OnObservation = void Function(
    Route<dynamic> route, Route<dynamic> previousRoute);

/// Example Usage:
///
/// ```
/// bool isPushed = false;
//  bool isPopped = false;
//
//  final TestObserver observer = TestObserver()
//    ..onPushed = (Route<dynamic> route, Route<dynamic> previousRoute) {
//      // Pushes the initial route.
//      expect(route is PageRoute && route.settings.name == '/', isTrue);
//      expect(previousRoute, isNull);
//      isPushed = true;
//    }
//    ..onPopped = (Route<dynamic> route, Route<dynamic> previousRoute) {
//      isPopped = true;
//    };
/// ```
///
class TestObserver extends NavigatorObserver {
  OnObservation onPushed;
  OnObservation onPopped;
  OnObservation onRemoved;
  OnObservation onReplaced;

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (onPushed != null) {
      onPushed(route, previousRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (onPopped != null) {
      onPopped(route, previousRoute);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (onRemoved != null) onRemoved(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic> oldRoute, Route<dynamic> newRoute}) {
    if (onReplaced != null) onReplaced(newRoute, oldRoute);
  }
}

class RouteMatcher extends Matcher {
  final String expected;
  bool contains = false;

  RouteMatcher(this.expected, {this.contains});

  @override
  Description describe(Description description) {
    return null;
  }

  @override
  bool matches(covariant String item, Map matchState) {
    if (contains) {
      return item.toString().contains(expected);
    }
    return item == expected;
  }
}
