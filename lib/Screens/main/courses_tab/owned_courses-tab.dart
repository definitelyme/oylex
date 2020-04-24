import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/Models/course-models/course.dart';
import 'package:oylex/components/main/tag-widget.dart';
import 'package:provider/provider.dart';

class OwnedCoursesTab extends StatefulWidget {
  static final keyValue = "my-courses---owned-tab";

  OwnedCoursesTab({Key key}) : super(key: key);

  @override
  _OwnedCoursesTabState createState() => _OwnedCoursesTabState();
}

class _OwnedCoursesTabState extends State<OwnedCoursesTab> {
  List<Course> _courses = Course.generatedCourses();
  ScrollController _scrollController;
  double radius = 16.0;

  void _continueStudying(Course course) {
    print("Course Title to study => ${course.title}");
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
          padding: defaultEdgeSpacing(context),
          children: _courses.map<Widget>((course) => _buildItem(course)).toList(),
        ),
      ),
    );
  }

  Widget _buildItem(Course course) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.008),
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: deviceHeight(context) * 0.18,
            margin: EdgeInsets.only(left: deviceWidth(context) * 0.08),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(radius),
              boxShadow: [
                BoxShadow(color: AppColors.windowBackground.shade800, offset: Offset(4.0, 4.0), blurRadius: 6.0),
              ],
            ),
            child: Material(
              borderRadius: BorderRadius.circular(radius),
              clipBehavior: Clip.hardEdge,
              type: MaterialType.transparency,
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _continueStudying(course),
                child: Container(
                  padding: EdgeInsets.fromLTRB(deviceWidth(context) * 0.24, 8.0, 10.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        course.title,
                        style: Theme.of(context).textTheme.title.copyWith(color: Colors.black87, fontSize: 16.5),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        semanticsLabel: "Course Title",
                        softWrap: true,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 4.0),
                      course.tag != null
                          ? ItemTag(
                              text: course.tag,
                              backgroundColor: Colors.amber.withAlpha(190),
                            )
                          : SizedBox.shrink(),
                      Text(
                        course.user.fullName,
                        style: Theme.of(context).textTheme.caption.copyWith(fontSize: 14.0),
                      ),
                      _buildStars(course.rating),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radius),
                        child: LinearProgressIndicator(
                          value: course.progress,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.oylexPrimary.shade400),
                          backgroundColor: Colors.grey.shade300,
                          semanticsLabel: "Progress",
                          semanticsValue: "${course.progress}",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 8.0,
            bottom: 8.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Container(
                color: AppColors.windowBackground.shade800,
                child: Image(
                  width: deviceWidth(context) * 0.3,
                  image: AssetImage(course.image),
                  fit: BoxFit.cover,
                  semanticLabel: "${course.title} - Image",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStars(double rating) {
    return RatingBar(
      initialRating: rating,
      minRating: 1.0,
      maxRating: 5.0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      unratedColor: Colors.amber.withAlpha(50),
      itemCount: 5,
      itemSize: 15.0,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
        semanticLabel: "Star",
      ),
      ignoreGestures: true,
      glow: true,
      glowColor: Colors.black87,
      glowRadius: 3.0,
      onRatingUpdate: (rating) {},
    );
  }
}
