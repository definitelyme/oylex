import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/Screens/main/courses_tab/all_courses-tab.dart';
import 'package:oylex/Screens/main/courses_tab/owned_courses-tab.dart';
import 'package:oylex/Screens/main/courses_tab/recent_courses_tab.dart';
import 'package:oylex/components/main/custom-appbar.dart';
import 'package:provider/provider.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class MyCoursesScreen extends StatefulWidget {
  static final keyValue = "my-courses-screen";

  MyCoursesScreen({Key key}) : super(key: key);

  @override
  _MyCoursesScreenState createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> with TickerProviderStateMixin {
//  final Key _recentTabKey = PageStorageKey(RecentCoursesTab.keyValue);
//  final Key _allTabKey = PageStorageKey(AllCoursesTab.keyValue);
//  final Key _ownedTabKey = PageStorageKey(OwnedCoursesTab.keyValue);
  int _tabCount = 3;
  TabController _tabController;
  ScrollAppBarController _appBarController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var _scrollController = Provider.of<ScrollController>(context, listen: false);
    _tabController = TabController(length: _tabCount, vsync: this);
    _appBarController = ScrollAppBarController(scrollController: _scrollController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        scrollAppBarController: _appBarController,
        isTabbed: true,
        backgroundColor: Colors.transparent,
        tabBarKey: MyCoursesScreen.keyValue,
        height: deviceHeight(context) * 0.09,
        tabController: _tabController,
        tabWidth: deviceWidth(context) - (deviceLeftMargin(context) + deviceRightMargin(context)),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: BouncingScrollPhysics(),
        children: [RecentCoursesTab(), AllCoursesTab(), OwnedCoursesTab()],
      ),
      /////
//      appBar: CoursesTab(
//        parentKey: MyCoursesScreen.keyValue,
//        height: deviceHeight(context) * 0.09,
//        tabWidth: deviceWidth(context) - (deviceLeftMargin(context) + deviceRightMargin(context)),
//        tabController: _tabController,
//      ),
//      body: TabBarView(
//        controller: _tabController,
//        physics: BouncingScrollPhysics(),
//        children: [RecentCoursesTab(), AllCoursesTab(), OwnedCoursesTab()],
//      ),
    );
  }
}
