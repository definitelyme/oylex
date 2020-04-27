import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
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
      child: NestedScrollView(
        physics: defaultScrollPhysics(),
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        headerSliverBuilder: (_, isScrolled) {
          return [
            SliverSafeArea(
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: deviceHeight(context) * 0.3,
                  width: deviceWidth(context),
                  decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    backgroundBlendMode: BlendMode.darken,
                  ),
                ),
              ),
            ),
          ];
        },
        body: ListView.builder(
          itemBuilder: (_, index) => Text("Another Text $index"),
          itemExtent: 230,
        ),
      ),
    );
  }
}
