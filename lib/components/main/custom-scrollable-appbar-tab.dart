import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/constants.dart';

class ScrollableAppbarTab extends StatefulWidget {
  ScrollableAppbarTab(
      {Key key, this.tabWidth, this.tabController, this.onPressed})
      : super(key: key);

  @required
  final double tabWidth;
  @required
  final TabController tabController;
  final Function onPressed;

  @override
  _ScrollableAppbarTabState createState() => _ScrollableAppbarTabState();
}

class _ScrollableAppbarTabState extends State<ScrollableAppbarTab> {
  TabController _tabController;
  int _currentIndex;
  final borderRadius = Radius.circular(16.0);

  void _onTabChange(index) => setState(() => _currentIndex = index);

  void _tabChangeListener() {
    setState(() => _currentIndex = _tabController.index);
  }

  @override
  void initState() {
    _tabController = widget.tabController;
    _currentIndex = _tabController.index;
    _tabController.addListener(_tabChangeListener);
    super.initState();
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
          child: TabBar(
            labelPadding: EdgeInsets.zero,
            isScrollable: false,
            controller: _tabController,
            indicatorColor: AppColors.windowBackground.shade900,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 5.0,
            indicatorPadding:
                EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.04),
            onTap: _onTabChange,
//            indicator: ShadowTabIndicator(
//              color: AppColors.windowBackground.shade900,
//              currentIndex: _currentIndex,
//              lastIndex: _tabController.length,
//            ),
            tabs: <Widget>[
              Container(
                child: _buildTab("RECENT", position: TAB_POSITION.LEFT),
              ),
              Container(
                child: _buildTab("ALL"),
              ),
              Container(
                child: _buildTab("STUDYING", position: TAB_POSITION.RIGHT),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String title, {TAB_POSITION position}) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: _buildTabRadius(position),
            ),
            child: ClipRRect(
              borderRadius: _buildTabRadius(position),
              clipBehavior: Clip.hardEdge,
              child: Material(
                color: Colors.transparent,
                child: Center(
                  child: Ink(
                    width: widget.tabWidth,
                    child: InkWell(
                      child: Center(
                        child: Text(title),
                      ),
                      onTap: widget.onPressed,
                    ),
                  ),
                ),
                elevation: 0.0,
                type: MaterialType.card,
                textStyle: deviceFontTheme().title.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: position != TAB_POSITION.RIGHT,
          child: VerticalDivider(thickness: 1.5, width: 1.5),
        ),
      ],
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

  @override
  void dispose() {
    _tabController.removeListener(_tabChangeListener);
    _tabController.dispose();
    super.dispose();
  }
}

enum TAB_POSITION {
  LEFT,
  RIGHT,
}

class ShadowTabIndicator extends Decoration {
  final BoxPainter _painter;

  ShadowTabIndicator({@required Color color, int currentIndex, int lastIndex})
      : _painter = ShadowPainter(color, currentIndex, lastIndex - 1);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class ShadowPainter extends BoxPainter {
  Paint _paint;
  TAB_POSITION position;
  int currentIndex;
  int lastIndex;

  ShadowPainter(Color color, this.currentIndex, this.lastIndex) {
    _paint = Paint()
      ..color = color.withAlpha(0xFFEE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(4));
  }

  static double convertRadiusToSigma(double radius) => radius * 0.57735 + 0.5;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final size = configuration.size; // Tab Size (or Child size)

    final path = Path();

    if (currentIndex == 0) {
      /// If index is at the beginning
      // Move to point 0.0, 0.0
      path.moveTo(offset.dx, size.height * 0.25);
      // Draw line from point 0.0 (x-axis) to height (y-axis)
      path.lineTo(offset.dx, size.height * 0.8);
      // Apply a curve from 1% of width (x-axis) to height (y-axis)
      path.lineTo(offset.dx + size.width * .1, size.height);
      // Draw line from point 0.0 + width (x-axis) to height (y-axis)
      path.lineTo(offset.dx + size.width * 0.95, size.height);
    } else if (currentIndex == lastIndex) {
      /// If Last Index
      // Move to point horizontalOffset + width (x-axis), stop at 25% of height (y-axis)
      path.moveTo(offset.dx + size.width, size.height * 0.25);
      // Start from point horizontalOffset + width (x-axis), stop at 80% of height (y-axis)
      path.lineTo(offset.dx + size.width, size.height * 0.8);
      // Start from point horizontalOffset / 69% of width (x-axis), stop at 80% of height (y-axis)
      path.lineTo(offset.dx / 0.69, size.height);
      // Start from point horizontalOffset / 95% (x-axis), stop at verticalOffset + height (y-axis)
      path.lineTo(offset.dx / 0.95, offset.dy + size.height);
    } else {
      /// Else somewhere in the middle
      // Move to point horizontalOffset (x-axis), height (y-axis)
      path.moveTo(offset.dx, size.height);
      // Move to point horizontalOffset + width (x-axis), height (y-axis)
      path.lineTo(offset.dx + size.width, size.height);
    }
    // Paint Path
    canvas.drawPath(path, _paint);
  }
}
