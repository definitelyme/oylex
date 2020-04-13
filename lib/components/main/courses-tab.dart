import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/constants.dart';

class CoursesTab extends StatefulWidget with PreferredSizeWidget {
  CoursesTab(
      {Key key,
      this.height,
      this.tabWidth,
      this.animationDuration,
      this.onPressed})
      : super(key: key);

  @required
  final double height;
  @required
  final double tabWidth;
  final int animationDuration;
  @required
  final Function onPressed;

  @override
  _CoursesTabState createState() => _CoursesTabState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CoursesTabState extends State<CoursesTab> {
  bool _tabOneSelected = true;
  bool _tabTwoSelected = false;
  bool _tabThreeSelected = false;

  final borderRadius = Radius.circular(16.0);

  void _onTabClicked(TAB_POSITION position) {
    switch (position) {
      case TAB_POSITION.LEFT:
        setState(() {
          _tabOneSelected = true;
          _tabTwoSelected = false;
          _tabThreeSelected = false;
          widget.onPressed(0); // First Tab index
        });
        break;
      case TAB_POSITION.RIGHT:
        setState(() {
          _tabOneSelected = false;
          _tabTwoSelected = false;
          _tabThreeSelected = true;
          widget.onPressed(2); // Third tab index
        });
        break;
      default:
        setState(() {
          _tabOneSelected = false;
          _tabTwoSelected = true;
          _tabThreeSelected = false;
          widget.onPressed(1); // Second Tab index
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      left: true,
      right: true,
      child: Container(
        key: widget.key,
        color: Colors.transparent,
        padding: EdgeInsets.only(top: 8.0),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(
              left: deviceLeftMargin(context),
              right: deviceRightMargin(context)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: _buildTab("RECENT", position: TAB_POSITION.LEFT),
              ),
              VerticalDivider(thickness: 1.5, width: 1.5),
              Flexible(
                child: _buildTab("ALL"),
              ),
              VerticalDivider(thickness: 1.5, width: 1.5),
              Flexible(
                child: _buildTab("STUDYING", position: TAB_POSITION.RIGHT),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String title, {TAB_POSITION position}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: widget.animationDuration),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: _buildTabRadius(position),
          boxShadow: _buildBoxShadow(position)),
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: _buildTabRadius(position),
        child: Material(
          child: Center(
            child: Ink(
              width: widget.tabWidth,
              height: widget.height,
              child: InkWell(
                onTap: () => _onTabClicked(position),
                child: Center(
                  child: Text(title),
                ),
                highlightColor: Colors.grey.shade200,
              ),
            ),
          ),
          elevation: 0.0,
          type: MaterialType.card,
          textStyle: GoogleFonts.workSansTextTheme().title.copyWith(
                fontSize: 15.5,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }

  BorderRadius _buildTabRadius(TAB_POSITION position) {
    switch (position) {
      case TAB_POSITION.LEFT:
        return BorderRadius.only(
            topLeft: borderRadius, bottomLeft: borderRadius);
      case TAB_POSITION.RIGHT:
        return BorderRadius.only(
            topRight: borderRadius, bottomRight: borderRadius);
      default:
        return BorderRadius.zero;
    }
  }

  List<BoxShadow> _buildBoxShadow(TAB_POSITION position) {
    // I know this is a very amateur way to achieving this task
    // But i'm currently in a hurry, can't waste time.
    // Perhaps later, i'll modify it
    switch (position) {
      case TAB_POSITION.LEFT:
        return _tabOneSelected
            ? [
                BoxShadow(
                    color: AppColors.windowBackground.shade900,
                    blurRadius: 8.0,
                    spreadRadius: 0.0,
                    offset: Offset(-6.0, 6.0))
              ]
            : null;
      case TAB_POSITION.RIGHT:
        return _tabThreeSelected
            ? [
                BoxShadow(
                    color: AppColors.windowBackground.shade900,
                    blurRadius: 8.0,
                    spreadRadius: 0.0,
                    offset: Offset(0.0, 6.0))
              ]
            : null;
      default:
        return _tabTwoSelected
            ? [
                BoxShadow(
                    color: AppColors.windowBackground.shade900,
                    blurRadius: 8.0,
                    spreadRadius: 0.0,
                    offset: Offset(8.0, 6.0))
              ]
            : null;
    }
  }
}

enum TAB_POSITION {
  LEFT,
  RIGHT,
}
