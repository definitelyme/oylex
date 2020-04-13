import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeaturedScreen extends StatefulWidget {
  static final routeName = "/featured-screen";

  FeaturedScreen({Key key, this.scrollController}) : super(key: key);

  final ScrollController scrollController;

  @override
  _FeaturedScreenState createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        controller: widget.scrollController,
        itemCount: 80,
        itemBuilder: (context, index) =>
            ListTile(title: Text("This is ITEM ${index.toString()}")),
      ),
    );
  }
}
