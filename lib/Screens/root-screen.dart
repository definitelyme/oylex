import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Models/destination.dart';
import 'package:oylex/Screens/main/account-screen.dart';
import 'package:oylex/Screens/main/favorite-screen.dart';
import 'package:oylex/Screens/main/featured-screen.dart';
import 'package:oylex/Screens/main/my_courses-screen.dart';
import 'package:oylex/Screens/main/search-screen.dart';

class RootScreen extends StatefulWidget {
  static final routeName = "/";

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;
  ScrollController _bottomNavigationController = ScrollController();
  bool _isBottomNavVisible = true;
  List<Widget> _destinationViews;

  void _updateNavigationIndex(int index) =>
      setState(() => _currentIndex = index);

  @override
  void initState() {
    super.initState();
    _bottomNavigationController.addListener(() {
      if (_bottomNavigationController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          _bottomNavigationController.offset > kBottomNavigationBarHeight) {
        if (_isBottomNavVisible)
          setState(() {
            _isBottomNavVisible = false;
          });
      }
      if (_bottomNavigationController.position.userScrollDirection ==
          ScrollDirection.forward) if (!_isBottomNavVisible)
        setState(() => _isBottomNavVisible = true);
    });

    _destinationViews = [
      FeaturedScreen(
        scrollController: _bottomNavigationController,
      ),
      SearchScreen(
        scrollController: _bottomNavigationController,
      ),
      MyCoursesScreen(
        scrollController: _bottomNavigationController,
      ),
      FavoriteScreen(
        scrollController: _bottomNavigationController,
      ),
      AccountScreen(
        scrollController: _bottomNavigationController,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _destinationViews[_currentIndex],
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: _isBottomNavVisible ? kBottomNavigationBarHeight : 0.0,
        child: Wrap(
          children: <Widget>[
            BottomNavigationBar(
              currentIndex: _currentIndex,
              elevation: 5.0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: _updateNavigationIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.windowBackground.shade700,
              selectedItemColor: AppColors.oylexPrimary.shade600,
              unselectedItemColor: AppColors.oylexPrimaryDark.shade400,
              items: Destination.destinations.map((destination) {
                return BottomNavigationBarItem(
                  title: Text(destination.title),
                  icon: Icon(destination.unSelectedIcon),
                  activeIcon: Icon(destination.selectedIcon),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
