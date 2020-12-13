import 'package:flutter/material.dart';
import 'package:tetris/gamer/gamer.dart';
import 'package:tetris/panel/page_portrait.dart';

import 'gamer/keyboard.dart';
import 'material/material.dart';

void main() {
  runApp(MyApp());
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class MyApp extends StatelessWidget {
  MyApp() {
    (() async => materialIGot = await doLoadMaterial())();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tetris',
      navigatorObservers: [routeObserver],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Game(child: KeyboardController(child: _HomePage())),
      ),
    );
  }
}

const SCREEN_BORDER_WIDTH = 3.0;

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //only Android/iOS support land mode
    bool land = MediaQuery.of(context).orientation == Orientation.landscape;
    return land ? PageLand() : PagePortrait();
  }
}
