import 'dart:math' as math;

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/Foundation/Utils/helper.dart';
import 'package:oylex/Models/course-models/content-levels.dart';
import 'package:oylex/Models/course-models/course-content.dart';
import 'package:oylex/Models/course-models/course.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class AllCoursesTab extends StatefulWidget {
  static final keyValue = "my-courses---all-tab";

  AllCoursesTab({Key key, this.scrollController}) : super(key: key);

  final ScrollController scrollController;

  @override
  _AllCoursesTabState createState() => _AllCoursesTabState();
}

class _AllCoursesTabState extends State<AllCoursesTab> with TickerProviderStateMixin {
  static List<Course> _courses = Course.generatedCourses();

  var _tabKey;
  final PageStorageBucket _storageBucket = PageStorageBucket();
  final ItemScrollController _itemScrollController = ItemScrollController();
  int _currentIndex = 0;
  double radius = 16.0;
  ScrollController _scrollController;

  Course _currentlySelected;

  void _handleSelectedCourse(int index, Course course) {
    double alignment = 0.0;
    if (index == 0)
      alignment = 0.0;
    else if (index == _courses.length - 1)
      alignment = 0.55;
    else
      alignment = 0.15;
    setState(() {
      _currentIndex = index;
      _currentlySelected = _courses[index];
//      PageStorage.of(context).writeState(context, _currentIndex, identifier: _tabKey);
      writeTo_PageState(context, _tabKey, _currentIndex);
    });

    _itemScrollController.scrollTo(index: index, duration: Duration(milliseconds: 600), curve: Curves.easeIn, alignment: alignment);
    /*
I/flutter (12894): Init StorageBucket Key: [<'jlkkwb'>]
I/flutter (12894): Tab Key => [<'jlkkwb'>]
I/flutter (12894): Current Index => 0
I/flutter (12894): Selected Course => Arts and Humanities
I/flutter (12894): ================================ I'VE BEEN TAPPED ===============================================
I/flutter (12894): Key => [<'jlkkwb'>]
I/flutter (12894): Stored Value => 1
I/flutter (12894): ================================ I'VE BEEN TAPPED ===============================================
I/flutter (12894): Key => [<'jlkkwb'>]
I/flutter (12894): Stored Value => 4

I/flutter (12894): Init StorageBucket Key: [<'bmi`Yo'>]
I/flutter (12894): Tab Key => [<'bmi`Yo'>]
I/flutter (12894): Current Index => 0
I/flutter (12894): Selected Course => Arts and Humanities
I/flutter (12894): ================================ I'VE BEEN TAPPED ===============================================
I/flutter (12894): Key => [<'bmi`Yo'>]
I/flutter (12894): Stored Value => 1

Performing hot restart...
Syncing files to device TECNO LC6...
Restarted application in 7,880ms.
E/AccessibilityBridge(12894): VirtualView node must not be the root node.
W/1.gpu   (12894): type=1400 audit(0.0:64682): avc: denied { search } for name="battery" dev="sysfs" ino=6609 scontext=u:r:untrusted_app:s0:c99,c257,c512,c768 tcontext=u:object_r:sysfs_batteryinfo:s0 tclass=dir permissive=0
F/libc    (12894): Fatal signal 11 (SIGSEGV), code 128 (SI_KERNEL), fault addr 0x0 in tid 13016 (Thread-3), pid 12894 (co.oylex)
*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Build fingerprint: 'TECNO/H617/TECNO-LC6:9/PPR1.180610.011/CDE-200316V293:user/release-keys'
Revision: '0'
ABI: 'arm'
pid: 12894, tid: 13016, name: Thread-3  >>> co.oylex <<<
signal 11 (SIGSEGV), code 128 (SI_KERNEL), fault addr 0x0
    r0  96ed6e60  r1  96ed6eb4  r2  0fc4f684  r3  00000008
    r4  96ed6e54  r5  98603158  r6  00000000  r7  985e6108
    r8  8e6c5e00  r9  81a89498  r10 f03b097b  r11 81a89498
    ip  00000000  sp  99299b34  lr  978347f1  pc  b056aa40
backtrace:
    #00 pc 00019a40  /system/lib/libc.so (sigsetjmp+144)
    #01 pc 007f37ef  /data/app/co.oylex-9366J_O52SI0LH0ysQFS4g==/lib/arm/libflutter.so

     */
  }

  @override
  void didChangeDependencies() {
    _tabKey = widget.key;
    _scrollController = Provider.of<ScrollController>(context);
    _currentIndex = read_PageState(context, _tabKey) ?? 0;
    _currentlySelected = _courses[_currentIndex];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
      body: SafeArea(
        child: PageStorage(
          bucket: _storageBucket,
          child: ListView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            children: <Widget>[
              _buildCourseTabs(),
              _buildCourseTabViews(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseTabs() {
    return Container(
      height: deviceHeight(context) * 0.24,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: ScrollablePositionedList.builder(
        itemCount: _courses.length,
        itemScrollController: _itemScrollController,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          Course course = _courses[index];
          return GestureDetector(
            onTap: () => _handleSelectedCourse(index, course),
            onLongPress: () => Tooltip(message: "${course.title}"),
            child: Container(
              width: deviceWidth(context) * 0.36,
              margin: EdgeInsets.only(right: 12.0, bottom: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.zero,
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                        clipBehavior: Clip.hardEdge,
                        child: FutureBuilder(
                          future: precacheImage(AssetImage(course.image), context),
                          builder: (_, dataSnapshot) {
                            if (dataSnapshot.connectionState == ConnectionState.done) {
                              return Image(
                                image: AssetImage(course.image),
                                width: double.infinity,
                                fit: BoxFit.cover,
                                semanticLabel: course.title,
                              );
                            } else
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircularProgressIndicator(strokeWidth: 3.0),
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
                        style: Theme.of(context).textTheme.title.copyWith(fontSize: 15.4, fontWeight: FontWeight.w600, letterSpacing: 0.8),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.windowBackground.shade700,
                    blurRadius: 4.0,
                    offset: Offset(4.0, 4.0),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCourseTabViews() {
    Content content = Content.generatedContentForCourse(_currentlySelected);

    TimelineModel _buildLevelListTile(Level level, index) {
      bool hasSecondLevel = level.children.isNotEmpty;
      Icon icon = Icon(Icons.fiber_manual_record, size: 13, color: Colors.grey, semanticLabel: "Incomplete");
      switch (level.status) {
        case STATUS.INCOMPLETE:
          icon = Icon(Icons.fiber_manual_record, size: 13, color: Colors.grey, semanticLabel: "Incomplete");
          break;
        case STATUS.IN_PROGRESS:
          icon = Icon(Icons.fiber_manual_record, size: 13, color: AppColors.oylexPrimary.shade600, semanticLabel: "Incomplete");
          break;
        case STATUS.COMPLETE:
          icon = Icon(Icons.check_circle, size: 13, color: AppColors.oylexPrimary.shade600, semanticLabel: "Incomplete");
          break;
      }

      // ignore: non_constant_identifier_names
      _build_subLevel_ListTile(Level level) {
        return ListTile(
          title: Text(
            level.title,
            style: TextStyle(color: Colors.grey.shade600),
          ),
          onTap: () {},
          contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.0),
          dense: true,
        );
      }

      return TimelineModel(
        ExpandableNotifier(
          child: ScrollOnExpand(
            child: ExpandablePanel(
              theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapHeaderToExpand: true,
                tapBodyToExpand: true,
                tapBodyToCollapse: false,
                hasIcon: false,
              ),
              header: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                dense: true,
                title: Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          level.title,
                          style: Theme.of(context).textTheme.body2.copyWith(fontSize: 19.0),
                        ),
                      ),
                      hasSecondLevel
                          ? ExpandableIcon(
                              theme: const ExpandableThemeData(
                                expandIcon: Icons.arrow_right,
                                collapseIcon: Icons.arrow_drop_down,
                                iconRotationAngle: math.pi / 2,
                                iconPadding: EdgeInsets.zero,
                                useInkWell: true,
                                hasIcon: false,
                                iconSize: 16.5,
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
                subtitle: Text(
                  level.subtitle,
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 14.0),
                ),
              ),
              expanded: Column(
                // Build expanded items of inner levels
                children: level.children.map<Widget>((level) => _build_subLevel_ListTile(level)).toList(),
              ),
            ),
          ),
        ),
        isFirst: index == 0,
        isLast: index == content.levels.length,
        iconBackground: Colors.transparent,
        icon: icon,
      );
    }

    Widget __buildExpandableCard(Level level) {
      bool hasFirstLevel = level.children.isNotEmpty;
      return ExpandableNotifier(
          child: Card(
        clipBehavior: Clip.antiAlias,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: true,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: false,
                ),
                header: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: deviceWidth(context) * 0.11,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: CircularProgressIndicator(
                          value: 0.63,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.oylexPrimary.shade400),
                          backgroundColor: Colors.grey.shade200,
                          semanticsLabel: "Progress",
                          semanticsValue: "Progress Value",
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 12.0),
                          child: Text(
                            level.title,
                            semanticsLabel: level.title,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.body2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                expanded: Timeline.builder(
                  itemCount: level.children.length,
                  itemBuilder: (_, index) {
                    Level currentLevel = level.children[index];
                    return _buildLevelListTile(currentLevel, index);
                  },
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  position: TimelinePosition.Left,
                  primary: true,
                  lineColor: Colors.grey.shade400,
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: EdgeInsets.only(left: 5.0),
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
      ));
    }

    return ListView.builder(
//      key: PageStorageKey("hello-key"),
      itemCount: content.levels.length,
      itemBuilder: (_, index) => __buildExpandableCard(content.levels[index]),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
//      addAutomaticKeepAlives: true,
    );
  }
}

class TriangleTabIndicator extends Decoration {
  final BoxPainter _painter;

  TriangleTabIndicator({@required Color color}) : _painter = TrianglePainter(color);

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

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset triangleOffset = offset + Offset(cfg.size.width / 2.2, cfg.size.height + 2);
    var path = Path();

    path.moveTo(triangleOffset.dx, triangleOffset.dy);
    path.lineTo(triangleOffset.dx + 16, triangleOffset.dy - 13);
    path.lineTo(triangleOffset.dx - 16, triangleOffset.dy - 13);
    path.close();

    canvas.drawShadow(path, Colors.black45, 6.0, true);
    canvas.drawPath(path, _paint);
  }
}
