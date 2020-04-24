import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/Screens/main/courses_tab/owned_courses-tab.dart';
import 'package:oylex/Screens/main/courses_tab/recent_courses_tab.dart';
import 'package:oylex/components/main/courses-tab.dart';

class MyCoursesScreen extends StatefulWidget {
  static final keyValue = "my-courses-screen";

  MyCoursesScreen({Key key}) : super(key: key);

  @override
  _MyCoursesScreenState createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> with TickerProviderStateMixin {
  int _tabCount = 2;
  TabController _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabController = TabController(length: _tabCount, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//      appBar: CustomAppBar(
//        scrollAppBarController: _appBarController,
//        isTabbed: true,
//        backgroundColor: Colors.transparent,
//        tabBarKey: MyCoursesScreen.keyValue,
//        height: deviceHeight(context) * 0.09,
//        tabController: _tabController,
//        tabTitles: ['recent', 'any', 'saved'],
//      ),
        appBar: CustomTabAppBar(
          uniqueKey: MyCoursesScreen.keyValue,
          height: deviceHeight(context) * 0.09,
          tabController: _tabController,
          titles: ['recent', 'saved'],
//        scrollCallback: widget.callback,
        ),
        body: TabBarView(
          controller: _tabController,
          physics: BouncingScrollPhysics(),
          children: [
            RecentCoursesTab(),
//          AllCoursesTab(),
            OwnedCoursesTab(),
          ],
        ),
      ),
    );
  }
}
