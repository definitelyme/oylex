import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  static final keyValue = "favorite-screen";

  FavoriteScreen({Key key, this.scrollController}) : super(key: key);

  final ScrollController scrollController;

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: SafeArea(
        top: true,
        child: Text("Favorites"),
      ),
    );
  }
}
