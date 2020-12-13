import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'material.dart';

const _DIGITAL_ROW_SIZE = Size(14, 24);

class Number extends StatelessWidget {
  final int length;

  ///the number to show
  ///could be null
  final int number;

  final bool padWithZero;

  Number(
      {Key key,
      this.length = 5,
      @required this.number,
      this.padWithZero = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String digitalStr = number?.toString() ?? "";
    if (digitalStr.length > length) {
      digitalStr = digitalStr.substring(digitalStr.length - length);
    }
    digitalStr = digitalStr.padLeft(length, padWithZero ? "0" : " ");
    List<Widget> children = [];
    for (int i = 0; i < length; i++) {
      children.add(Digital(int.tryParse(digitalStr[i])));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

/// a single digital
class Digital extends StatelessWidget {
  ///number 0 - 9
  ///or null indicate it is invalid
  final int digital;

  final Size size;

  Digital(this.digital, {Key key, this.size = const Size(10, 17)})
      : assert(digital == null || (digital <= 9 && digital >= 0)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Material(
      size: size,
      srcOffset: _getDigitalOffset(),
      srcSize: _DIGITAL_ROW_SIZE,
    );
  }

  Offset _getDigitalOffset() {
    int offset = digital ?? 10;
    final dx = 75.0 + 14 * offset;
    return Offset(dx, 25);
  }
}

class _Material extends StatelessWidget {
  //the size off widget
  final Size size;

  final Size srcSize;

  final Offset srcOffset;

  const _Material(
      {Key key,
      @required this.size,
      @required this.srcSize,
      @required this.srcOffset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _MaterialPainter(srcOffset, srcSize, materialIGot),
      child: SizedBox.fromSize(size: size),
    );
  }
}

class _MaterialPainter extends CustomPainter {
  ///offset to adjust the drawing
  final Offset offset;

  ///the size we pick from [_material]
  final Size size;

  final ui.Image material;

  _MaterialPainter(this.offset, this.size, this.material);

  Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    final src =
        Rect.fromLTWH(offset.dx, offset.dy, this.size.width, this.size.height);
    canvas.scale(size.width / this.size.width, size.height / this.size.height);
    canvas.drawImageRect(material, src,
        Rect.fromLTWH(0, 0, this.size.width, this.size.height), _paint);
  }

  @override
  bool shouldRepaint(_MaterialPainter oldDelegate) {
    return oldDelegate.offset != offset || oldDelegate.size != size;
  }
}
