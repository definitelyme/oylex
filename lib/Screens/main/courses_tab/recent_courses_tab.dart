import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentCoursesTab extends StatefulWidget {
  static final keyValue = "my-courses---recent-tab";

  RecentCoursesTab({Key key, this.scrollController}) : super(key: key);

  final ScrollController scrollController;

  @override
  _RecentCoursesTabState createState() => _RecentCoursesTabState();
}

class _RecentCoursesTabState extends State<RecentCoursesTab> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
