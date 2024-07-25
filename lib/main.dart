import 'package:flutter/material.dart';
import 'package:bluetooth_detector/settings_view/settings_view.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget screen = const SettingsView();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: screen),
      theme: ThemeData(),
    );
  }
}
