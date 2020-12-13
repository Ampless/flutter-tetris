import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ui.Image materialIGot;

Future<ui.Image> doLoadMaterial() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bytes = await rootBundle.load("assets/material.png");
  final codec = await ui.instantiateImageCodec(bytes.buffer.asUint8List());
  return (await codec.getNextFrame()).image;
}
