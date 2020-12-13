import 'package:flutter/material.dart';

class BrikSize extends InheritedWidget {
  const BrikSize({
    Key key,
    @required this.size,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  final Size size;

  static BrikSize of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BrikSize>();
  }

  @override
  bool updateShouldNotify(BrikSize old) {
    return old.size != size;
  }
}

///the basic brik for game panel
class Brik extends StatelessWidget {
  final Color color;

  const Brik._({Key key, this.color}) : super(key: key);

  const Brik.normal() : this._(color: Colors.white);

  const Brik.empty() : this._(color: Colors.black);

  const Brik.highlight() : this._(color: const Color(0xFF560000));

  @override
  Widget build(BuildContext context) {
    final width = BrikSize.of(context).size.width;
    return SizedBox.fromSize(
      size: BrikSize.of(context).size,
      child: Container(
        margin: EdgeInsets.all(0.05 * width),
        padding: EdgeInsets.all(0.1 * width),
        decoration: BoxDecoration(
            border: Border.all(width: 0.10 * width, color: color)),
        child: Container(
          color: color,
        ),
      ),
    );
  }
}
