![Flutter CI](https://github.com/MTRNord/RSFlutterApp/workflows/Flutter%20CI/badge.svg)

# Bahnhofsfotos

Bahnhofsfoto-App for Android and iOS using Flutter (focused on iOS)

## Where to get the App from (Android)

1. Open https://github.com/MTRNord/RSFlutterApp/actions?query=is%3Asuccess
2. Click the very first task
3. Download the app-debug.apk artifact
4. Unpack that zip file
5. Install the contained apk file

## How to build iOS

### Requirements

* XCode
* Apple PC
* Flutter

### Steps

Please follow the official Flutter guide over at https://flutter.dev/docs/deployment/ios

## How to build Android

### Requirements

* Android SDK
* Flutter

### Steps

#### Debug Build

Simply run `flutter build apk --debug` to get an apk or run `flutter build appbundle --debug` to get a debug appbundle

#### Release Build

1. Make sure you either have the right signing keys or generate a new one and change android/app/build.gradle accordingly.
2. Simply run `flutter build apk` to get an apk or run `flutter build appbundle` to get an appbundle
