import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/Models/course-models/course.dart';
import 'package:oylex/components/main/build-course-levels.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AllCoursesTab extends StatefulWidget {
  static final keyValue = "my-courses---all-tab";

  AllCoursesTab({Key key}) : super(key: key);

  @override
  _AllCoursesTabState createState() => _AllCoursesTabState();
}

class _AllCoursesTabState extends State<AllCoursesTab> with TickerProviderStateMixin {
  static List<Course> _courses = Course.generatedCourses();
  final PageStorageBucket _storageBucket = PageStorageBucket();
  final ItemScrollController _itemScrollController = ItemScrollController();
  int _currentIndex = 0;
  double radius = 16.0;
  ScrollController _scrollController;
  Course _currentlySelectedCourse;

  void _handleSelectedCourse(int index, Course course) {
    _scrollToPosition(index);
    setState(() {
      _currentIndex = index;
      _currentlySelectedCourse = _courses[index];
    });
  }

  void _scrollToPosition(int index) {
    // Left (default)
    double alignment = 0.0;
    if (index == 0)
      alignment = 0.0;
    else if (index == _courses.length - 1)
      alignment = 0.55;
    else
      alignment = 0.15;
    // Scroll To index
    _itemScrollController.scrollTo(index: index, duration: Duration(milliseconds: 600), curve: Curves.easeIn, alignment: alignment);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController = Provider.of<ScrollController>(context, listen: false);
    _currentlySelectedCourse = _courses[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
      body: SafeArea(
        child: PageStorage(
          bucket: _storageBucket,
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            children: <Widget>[
              _buildCourseTabs(),
              CourseContentLevels(course: _currentlySelectedCourse),
              SizedBox.shrink(),
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
          // PreCache the Images
          precacheImage(AssetImage(course.image), context);

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
                        child: Image(
                          image: AssetImage(course.image),
                          width: double.infinity,
                          fit: BoxFit.cover,
                          semanticLabel: course.title,
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
