import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OwnedCoursesTab extends StatefulWidget {
  static final keyValue = "my-courses---owned-tab";

  OwnedCoursesTab({Key key, this.scrollController}) : super(key: key);

  final ScrollController scrollController;

  @override
  _OwnedCoursesTabState createState() => _OwnedCoursesTabState();
}

class _OwnedCoursesTabState extends State<OwnedCoursesTab> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
