import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeaturedScreen extends StatefulWidget {
  static final keyValue = "featured-screen";

  FeaturedScreen({Key key}) : super(key: key);

  @override
  _FeaturedScreenState createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  ScrollController _scrollController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController = Provider.of<ScrollController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        controller: _scrollController,
        itemCount: 150,
        itemBuilder: (context, index) => ListTile(title: Text("This is ITEM ${index.toString()}")),
      ),
    );
  }
}
