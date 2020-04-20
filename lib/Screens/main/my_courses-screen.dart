import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/Screens/main/courses_tab/all_courses-tab.dart';
import 'package:oylex/Screens/main/courses_tab/owned_courses-tab.dart';
import 'package:oylex/Screens/main/courses_tab/recent_courses_tab.dart';
import 'package:oylex/components/main/courses-tab.dart';
import 'package:provider/provider.dart';

class MyCoursesScreen extends StatefulWidget {
  static final keyValue = "my-courses-screen";

  MyCoursesScreen({Key key, this.scrollController}) : super(key: key);

  final ScrollController scrollController;

  @override
  _MyCoursesScreenState createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> with SingleTickerProviderStateMixin {
  final Key _recentTabKey = PageStorageKey(RecentCoursesTab.keyValue);
  final Key _allTabKey = PageStorageKey(AllCoursesTab.keyValue);
  final Key _ownedTabKey = PageStorageKey(OwnedCoursesTab.keyValue);
  int _tabCount = 3;
  double _tabBarHeight;
  bool _isAppBarVisible = true;
  TabController _tabController;
  ScrollController _inheritedScrollController;

  void _inheritedScrollListener() {
//    if (_inheritedScrollController.position.userScrollDirection == ScrollDirection.reverse && _inheritedScrollController.offset > _tabBarHeight) {
//      if (_isAppBarVisible) setState(() => _isAppBarVisible = false);
//    }
//    if (_inheritedScrollController.position.userScrollDirection == ScrollDirection.forward) if (!_isAppBarVisible) setState(() => _isAppBarVisible = true);
  }

  @override
  void initState() {
    _tabController = TabController(length: _tabCount, vsync: this);
//    _inheritedScrollController = widget.scrollController;
//    _inheritedScrollController.addListener(_inheritedScrollListener);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _tabBarHeight = deviceHeight(context) * 0.13;
    var _scrollController = Provider.of<ScrollController>(context);
//    widget.scrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    print("Did change Dependencies!");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: PreferredSize(
//        preferredSize: Size.fromHeight(_tabBarHeight),
//        child: AnimatedContainer(
//          duration: Duration(microseconds: 400),
//          height: _isAppBarVisible ? _tabBarHeight : 0.0,
//          child: ScrollableAppbarTab(
//            tabWidth: deviceWidth(context) - (deviceLeftMargin(context) + deviceRightMargin(context)),
//            tabController: _tabController,
//          ),
//        ),
//      ),
      appBar: CoursesTab(
        parentKey: MyCoursesScreen.keyValue,
        height: deviceHeight(context) * 0.09,
        tabWidth: deviceWidth(context) - (deviceLeftMargin(context) + deviceRightMargin(context)),
        tabController: _tabController,
      ),
      body: TabBarView(
        controller: _tabController,
        physics: BouncingScrollPhysics(),
        children: [
          RecentCoursesTab(
            key: _recentTabKey,
          ),
          AllCoursesTab(
            key: _allTabKey,
          ),
          OwnedCoursesTab(
            key: _ownedTabKey,
          )
        ],
      ),
    );
  }
}
