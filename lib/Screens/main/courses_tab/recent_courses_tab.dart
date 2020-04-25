import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/Models/course-models/course-category.dart';
import 'package:oylex/Models/course-models/course.dart';
import 'package:oylex/components/main/square-course-card.dart';
import 'package:provider/provider.dart';

class RecentCoursesTab extends StatefulWidget {
  static final keyValue = "my-courses---recent-tab";

  RecentCoursesTab({Key key}) : super(key: key);

  @override
  _RecentCoursesTabState createState() => _RecentCoursesTabState();
}

class _RecentCoursesTabState extends State<RecentCoursesTab> with SingleTickerProviderStateMixin {
  int _paginate = 3;
  List<Course> _courses = Course.generatedCourses();
  List<CourseCategory> _categories = CourseCategory.dummyCategories();
  ScrollController _scrollController;
  double radius = 16.0;

  void _tagClicked(String value) {
    // TODO: Handle Tag search on click
    print("Search value => $value");
  }

  void _showMoreRecent(int quantity) {
    print("Paginete Before State change=> $_paginate");
    setState(() {
      _paginate = quantity;
    });
    print("Paginete After State change=> $_paginate");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController = Provider.of<ScrollController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          controller: _scrollController,
          padding: defaultEdgeSpacing(context, top: 12.0),
          children: [
            /// RECENT LIST
            for (CourseCategory category in _categories.take(2)) _buildRecentCourse(category),
            SizedBox(height: 16.0),

            /// MOST POPULAR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomPaint(
                  painter: TitleUnderlinePainter(color: AppColors.windowBackground.shade900),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      "Most Popular",
                      style: Theme.of(context).textTheme.title.copyWith(fontSize: 18.0, fontWeight: FontWeight.w800, letterSpacing: 0.8),
                    ),
                  ),
                ),
                Container(
                  child: FlatButton(
                    onPressed: () {},
                    shape: StadiumBorder(),
                    highlightColor: Colors.white38,
                    splashColor: Colors.grey.shade400,
                    child: Text(
                      "View All",
                      style: Theme.of(context).textTheme.display2.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.oylexPrimary.shade500,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            /// MOST POPULAR LIST VIEW
            Container(
              height: deviceHeight(context) * 0.36,
              child: ListView.builder(
                controller: ScrollController(),
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _courses.take(6).length,
                itemBuilder: (_, index) => SquareCourseCard(
                  course: _courses.take(6).elementAt(index),
                  width: deviceWidth(context) * 0.7,
                  flexAlignment: MainAxisAlignment.end,
                  topFlex: 6,
                  bottomFlex: 5,
                  titleFont: 18.0,
                  radius: radius,
                ),
              ),
            ),
            SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentCourse(CourseCategory category) {
    Iterable<Course> catCourses = _courses.where((course) => course.category.id == category.id);

    return Column(
      key: ValueKey(category.name),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(8.0, 3.0, 10.0, 3.0),
          margin: const EdgeInsets.only(bottom: 5.0),
          color: Colors.white38,
          child: InkWell(
            onTap: () => _tagClicked(category.name),
            child: RichText(
              text: TextSpan(
                text: "#",
                semanticsLabel: "Hash",
                style: Theme.of(context).textTheme.title.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: AppColors.oylexPrimary,
                    ),
                children: [
                  TextSpan(
                    text: category.name,
                    style: Theme.of(context).textTheme.body2.copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          letterSpacing: 0.7,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: deviceHeight(context) * 0.3,
          child: ListView(
            controller: ScrollController(keepScrollOffset: false),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              for (Course recent in catCourses.take(0 + _paginate))
                SquareCourseCard(
                  course: recent,
                  flexAlignment: MainAxisAlignment.start,
                  radius: radius,
                ),
              SizedBox(width: 14.0),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                    borderRadius: BorderRadius.circular(100),
                    clipBehavior: Clip.hardEdge,
                    color: Colors.grey.shade500.withAlpha(80),
                    child: Ink(
                      child: InkWell(
                        onTap: () => _showMoreRecent(_paginate + 1),
                        splashColor: Colors.white70,
                        child: Container(
                          height: 60,
                          width: 60,
                          child: Icon(
                            Icons.arrow_forward,
                            size: 28.5,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(width: 20.0),
            ],
          ),
        ),
      ],
    );
  }
}

class TitleUnderlinePainter extends CustomPainter {
  final Color color;

  TitleUnderlinePainter({@required this.color}) : assert(color != null);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(0.0, size.height - 4), Offset(size.width, size.height - 4), paint);
    canvas.drawLine(Offset(0.0, size.height), Offset(size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
