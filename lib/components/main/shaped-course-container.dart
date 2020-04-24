import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShapedCourseContainer extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: 20);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) => null;

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    rect = Rect.fromPoints(rect.topLeft, rect.bottomRight - Offset(0, 20));
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(16.0)))
      ..moveTo(rect.bottomCenter.dx - 10, rect.bottomCenter.dy)
      ..relativeLineTo(10, 8)
      ..relativeLineTo(10, -8)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    // TODO: implement paint
  }

  @override
  ShapeBorder scale(double t) => this;
}
