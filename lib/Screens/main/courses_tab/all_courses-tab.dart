import 'dart:math' as math;

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/Models/course-models/content-levels.dart';
import 'package:oylex/Models/course-models/course-content.dart';
import 'package:oylex/Models/course-models/course.dart';

class AllCoursesTab extends StatefulWidget {
  @override
  _AllCoursesTabState createState() => _AllCoursesTabState();
}

class _AllCoursesTabState extends State<AllCoursesTab>
    with TickerProviderStateMixin {
  static List<Course> _courses = Course.generatedCourses();
  int _initialIndex = 0;
  int _currentIndex = 0;
  int _tabLength = _courses.length;
  TabController _tabController;
  double radius = 16.0;
  final text =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  void _doStuff(int index) {
    print("OLD - Last Index => $_currentIndex");
    print("OLD - Current Index => $index");
    setState(() => _currentIndex = index);
    print("NEW - Last Index => $_currentIndex");
    print("NEW - Current Index => $index");
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        initialIndex: _initialIndex, length: _tabLength, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(height: deviceHeight(context) * 0.025),
          TabBar(
            controller: _tabController,
            indicator: TriangleTabIndicator(color: Colors.white),
            isScrollable: true,
            dragStartBehavior: DragStartBehavior.start,
            indicatorPadding: EdgeInsets.zero,
            labelPadding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 8.0),
            onTap: _doStuff,
            tabs: _courses
                .map<Widget>((course) => _generateTab(context, course))
                .toList(),
          ),
          Container(
            height: deviceHeight(context) * 2,
            child: TabBarView(
              controller: _tabController,
              physics: ClampingScrollPhysics(),
              children: _courses
                  .map((course) => _generateTabView(context, course))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _generateTab(BuildContext context, Course course) {
    return Container(
      width: deviceWidth(context) * 0.34,
      height: deviceHeight(context) * 0.21,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 4,
            child: Container(
              padding: EdgeInsets.zero,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(radius)),
                clipBehavior: Clip.hardEdge,
                child: Image(
                  image: AssetImage(course.image),
                  width: deviceWidth(context) * 0.35,
//                  height: deviceHeight(context) * 0.21,
                  fit: BoxFit.cover,
                  semanticLabel: course.title,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) return child;
                    return AnimatedOpacity(
                      duration: Duration(milliseconds: 200),
                      opacity: frame == null ? 0 : 1,
                      child: child,
                      curve: Curves.easeOut,
                    );
                  },
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return CircularProgressIndicator(
                      value: progress.expectedTotalBytes != null
                          ? progress.cumulativeBytesLoaded /
                              progress.expectedTotalBytes
                          : null,
                    );
                  },
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Text(
                course.title,
                style: Theme.of(context).textTheme.title.copyWith(
                    fontSize: 15.4,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
                color: AppColors.windowBackground.shade800,
                blurRadius: 8.0,
                offset: Offset(4.0, 4.0))
          ]),
    );
  }

  Widget _generateTabView(BuildContext context, Course course) {
    Content content = Content.generatedContentForCourse(course);

    Widget _buildTiles(Level level) {
      if (level.children.isEmpty) return ListTile(title: Text(level.title));

      buildItem(String label) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(label),
        );
      }

      buildList() {
        return Column(
          children: <Widget>[
            for (var i in [1, 2, 3, 4]) buildItem("Item $i"),
          ],
        );
      }

      return ExpandableNotifier(
//          key: PageStorageKey<Level>(level),
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: ScrollOnExpand(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToExpand: true,
                    tapBodyToCollapse: true,
                    hasIcon: false,
                  ),
                  header: Container(
                    color: Colors.indigoAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          ExpandableIcon(
                            theme: const ExpandableThemeData(
                              expandIcon: Icons.arrow_right,
                              collapseIcon: Icons.arrow_drop_down,
                              iconColor: Colors.white,
                              iconSize: 28.0,
                              iconRotationAngle: math.pi / 2,
                              iconPadding: EdgeInsets.only(right: 5),
                              hasIcon: false,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              level.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .body2
                                  .copyWith(color: Colors.white),
                            ),
                          ),
//                              level.children.map(_buildTiles).toList(),
                        ],
                      ),
                    ),
                  ),
                  expanded: buildList(),
                ),
              ],
            ),
          ),
        ),
      ));
    }

    Widget __buildExpanableCards(Level level) {
      return ExpandableNotifier(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.rectangle,
                  ),
                ),
              ),
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        level.title,
                        style: Theme.of(context).textTheme.body2,
                      )),
                  collapsed: Text(
                    level.description,
                    softWrap: true,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: level.children.map(_buildTiles).toList(),
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ));
    }

    return ListView.builder(
      itemCount: content.levels.length,
      itemBuilder: (_, index) => __buildExpanableCards(content.levels[index]),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      addAutomaticKeepAlives: true,
    );
//    return Column(
//      children: content.levels
//          .map<Widget>((level) => __buildExpanableCards(level))
//          .toList(),
//    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class TriangleTabIndicator extends Decoration {
  final BoxPainter _painter;

  TriangleTabIndicator({@required Color color})
      : _painter = TrianglePainter(color);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class TrianglePainter extends BoxPainter {
  Paint _paint;

  TrianglePainter(Color color) {
    _paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset triangleOffset =
        offset + Offset(cfg.size.width / 2.2, cfg.size.height + 2);
    var path = Path();

    path.moveTo(triangleOffset.dx, triangleOffset.dy);
    path.lineTo(triangleOffset.dx + 16, triangleOffset.dy - 13);
    path.lineTo(triangleOffset.dx - 16, triangleOffset.dy - 13);
    path.close();

    canvas.drawShadow(path, Colors.black45, 6.0, true);
    canvas.drawPath(path, _paint);
  }
}
