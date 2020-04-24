import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';

class ItemTag extends StatefulWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final bool onlyBorder;
  final double fontSize;
  final double borderWidth;
  final double leftPadding;
  final double topPadding;
  final double rightPadding;
  final double bottomPadding;

  ItemTag({
    @required this.text,
    this.backgroundColor = AppColors.oylexPrimary,
    this.textColor = Colors.black87,
    this.fontSize = 14.0,
    this.onlyBorder = false,
    this.borderWidth = 1.7,
    this.leftPadding = 5.0,
    this.topPadding = 1.0,
    this.rightPadding = 10.0,
    this.bottomPadding = 1.0,
  }) : assert(text != null);

  @override
  _ItemTagState createState() => _ItemTagState();
}

class _ItemTagState extends State<ItemTag> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TagArtist(backgroundColor: widget.backgroundColor, onlyBorder: widget.onlyBorder, borderWidth: widget.borderWidth),
      child: Container(
        margin: EdgeInsets.fromLTRB(widget.leftPadding, widget.topPadding, widget.rightPadding, widget.bottomPadding),
        child: Text(
          widget.text,
          style: TextStyle(color: widget.textColor, fontSize: widget.fontSize),
        ),
      ),
    );
  }
}

class _TagArtist extends CustomPainter {
  final Color backgroundColor;
  final bool onlyBorder;
  final double borderWidth;

  _TagArtist({this.backgroundColor, this.onlyBorder, this.borderWidth});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..style = onlyBorder ? PaintingStyle.stroke : PaintingStyle.fill
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round;

    Path path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(size.width * 0.9, 0.0);
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(size.width * 0.9, size.height);
    path.lineTo(0.0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
