import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/Screens/main/courses_tab/all_courses-tab.dart';
import 'package:oylex/Screens/main/courses_tab/owned_courses-tab.dart';
import 'package:oylex/Screens/main/courses_tab/recent_courses_tab.dart';
import 'package:oylex/components/main/courses-tab.dart';

class MyCoursesScreen extends StatefulWidget {
  static final routeName = "/my_courses-screen";

  MyCoursesScreen({Key key, this.scrollController}) : super(key: key);

  final ScrollController scrollController;

  @override
  _MyCoursesScreenState createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen>
    with SingleTickerProviderStateMixin {
  int _tabCount = 3;
  TabController _tabController;
  List<Widget> _list = [
    RecentCoursesTab(),
    AllCoursesTab(),
    OwnedCoursesTab(),
  ];

  @override
  void initState() {
    _tabController = TabController(length: _tabCount, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoursesTab(
        height: deviceHeight(context) * 0.085, // Means 9.5% of screen height
        tabWidth: deviceWidth(context) -
            (deviceLeftMargin(context) + deviceRightMargin(context)),
        tabController: _tabController,
      ),
      body: TabBarView(
        controller: _tabController,
        physics: BouncingScrollPhysics(),
        children: _list,
      ),
    );
  }
}
