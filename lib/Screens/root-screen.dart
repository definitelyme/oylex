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
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  static final routeName = "/";
//  static final routeName = "/home";

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final PageStorageBucket _storageBucket = PageStorageBucket();
  final Key featuredScreenKey = PageStorageKey(FeaturedScreen.keyValue);
  final Key searchScreenKey = PageStorageKey(SearchScreen.keyValue);
  final Key myCoursesScreenKey = PageStorageKey(MyCoursesScreen.keyValue);
  final Key favoriteScreenKey = PageStorageKey(FavoriteScreen.keyValue);
  final Key accountScreenKey = PageStorageKey(AccountScreen.keyValue);
  int _currentIndex = 0;
  bool _isBottomNavVisible = true;
  List<Widget> _destinationViews;
  ScrollController _bottomNavigationController = ScrollController(keepScrollOffset: true);

  scrollStateCallback() {
    if (!_isBottomNavVisible) setState(() => _isBottomNavVisible = true);
    print("Found you");
  }

  void _updateNavigationIndex(int index) => setState(() => _currentIndex = index);

  void _scrollListener() {
    if (_bottomNavigationController.position.userScrollDirection == ScrollDirection.reverse && _bottomNavigationController.offset > kBottomNavigationBarHeight) {
      if (_isBottomNavVisible)
        setState(() {
          _isBottomNavVisible = false;
        });
    }
    if (_bottomNavigationController.position.userScrollDirection == ScrollDirection.forward || _bottomNavigationController.offset == 0.0) if (!_isBottomNavVisible)
      setState(() => _isBottomNavVisible = true);
  }

  @override
  void initState() {
    super.initState();
    _bottomNavigationController.addListener(_scrollListener);

    _destinationViews = [
      FeaturedScreen(key: featuredScreenKey),
      SearchScreen(key: searchScreenKey),
      MyCoursesScreen(key: myCoursesScreenKey),
      FavoriteScreen(key: favoriteScreenKey),
      AccountScreen(key: accountScreenKey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        // For storing navigation state
        bucket: _storageBucket,
        child: ListenableProvider<ScrollController>.value(
          value: _bottomNavigationController,
          child: _destinationViews[_currentIndex],
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 350),
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

  @override
  void dispose() {
    _bottomNavigationController.removeListener(_scrollListener);
    _bottomNavigationController.dispose();
    super.dispose();
  }
}
