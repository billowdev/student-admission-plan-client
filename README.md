# access the internet
## add permission

<uses-permission android:name="android.permission.INTERNET" />

## path of AndroidManifest.xml
<your_flutter_project>/android/app/src/main/AndroidManifest.xml

## change icon
flutter pub run flutter_launcher_icons:main


# build
flutter build apk --release
or
flutter build apk --release --build-name=1.0.0 --build-number=1



### apk path
<your_project>/build/app/outputs/flutter-apk-app-release.apk

# project

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# http
<pre>
dependencies:
  http: ^0.13.3

</pre>
- import 'package:http/http.dart' as http;

