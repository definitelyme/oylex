import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBuilder extends StatelessWidget {
  final double rating;

  RatingBuilder({this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      initialRating: rating,
      minRating: 1.0,
      maxRating: 5.0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      unratedColor: Colors.amber.withAlpha(50),
      itemCount: 5,
      itemSize: 14.0,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
        semanticLabel: "Star",
      ),
      ignoreGestures: true,
      glow: true,
      glowColor: Colors.black87,
      glowRadius: 3.0,
      onRatingUpdate: (rating) {},
    );
  }
}
