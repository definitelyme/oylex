import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  static final routeName = "/favorite-screen";

  FavoriteScreen({Key key, this.scrollController}) : super(key: key);

  final ScrollController scrollController;

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Container(
        child: Text("Favorites here"),
      ),
    );
  }
}
