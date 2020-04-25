import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/Models/course-models/course-category.dart';
import 'package:oylex/Models/course-models/course.dart';
import 'package:oylex/components/auth/text-form-input.dart';
import 'package:oylex/components/main/square-course-card.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static final keyValue = "search-screen";

  SearchScreen({Key key, this.scrollController}) : super(key: key);

  final ScrollController scrollController;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Course> _courses = Course.generatedCourses();
  ScrollController _scrollController;
  String _searchString;
  bool _isTyping = false;
  double radius = 14.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController = Provider.of<ScrollController>(context, listen: false);
  }

  Future<List<CourseCategory>> _getCourses(String searchValue) async {
    return await Future.delayed(Duration(milliseconds: 1000), () {
      List<CourseCategory> listCategories = List<CourseCategory>(); // Empty
      if (searchValue != null && searchValue.length > 0) {
        Iterable<Course> searchResult = _courses.where((course) => course.title.toLowerCase().contains(searchValue.toLowerCase())); // List where searchString == course title
        searchResult.forEach((course) {
          if (!listCategories.any((category) => category.id == course.category.id)) listCategories.add(course.category);
          listCategories.firstWhere((category) => category.id == course.category.id).addCourse(course);
        });
      }
      return listCategories;
    });
  }

//  void _search() {
//    setState(() => _isTyping = true);
//    setState(() {});
//  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: defaultEdgeSpacing(context),
          child: Column(
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(milliseconds: 250),
                margin: !_isTyping ? EdgeInsets.only(top: deviceHeight(context) * 0.1) : EdgeInsets.only(top: deviceHeight(context) * 0.01),
                width: double.infinity,
                height: deviceHeight(context) * 0.088,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radius),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.windowBackground.shade800,
                      blurRadius: 6.0,
                      offset: Offset(4.0, 4.0),
                    )
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 20.0),
                        child: AuthTextField(
                          hint: "Find something..",
                          enableSuggestions: true,
                          inputAction: TextInputAction.search,
                          validator: (value) {},
                          onChanged: (String value) {
                            setState(() {
                              _searchString = value.trim();
                              _isTyping = false;
                            });

                            setState(() => _isTyping = _searchString != null && _searchString.length > 0);
                          },
                          textStyle: Theme.of(context).textTheme.subhead.copyWith(
                                fontSize: 20.0,
                                color: Colors.black87,
                              ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(5.0, 6.0, 8.0, 6.0),
                      decoration: BoxDecoration(
                        color: AppColors.oylexPrimary.shade400,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black87.withAlpha(20),
                            blurRadius: 4.0,
                            offset: Offset(4.0, 4.0),
                          )
                        ],
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        clipBehavior: Clip.hardEdge,
                        type: MaterialType.transparency,
                        color: Colors.transparent,
                        child: InkWell(
//                          onTap: _search,
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.033),
                              child: Icon(
                                Icons.search,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Visibility(
                  visible: !_isTyping,
                  replacement: _searchOutput(),
                  child: _noSearchOutput(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchOutput() {
    return FutureBuilder(
      future: _getCourses(_searchString),
      builder: (_, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Align(
              alignment: Alignment.center,
              heightFactor: 5,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.oylexPrimary.shade400),
              ),
            );
          case ConnectionState.done:
            {
              Iterable<CourseCategory> categories = snapshot.data;
              return _categoriesBuilder(categories);
            }
          default:
            return Align(
              alignment: Alignment.center,
              heightFactor: 5,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.oylexPrimary.shade400),
              ),
            );
        }
      },
    );
  }

  Widget _noSearchOutput() {
    return Column(
      children: <Widget>[
        SizedBox(height: deviceHeight(context) * 0.08),
        Text(
          "Hi, Antonio",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.title.copyWith(
                color: Colors.black,
                fontSize: 26.5,
                letterSpacing: 0.7,
              ),
        ),
        SizedBox(height: 10.0),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.caption.copyWith(
                  fontSize: 17.0,
                  color: Colors.grey.shade700,
                  letterSpacing: 0.7,
                ),
            children: [
              TextSpan(
                text: "What would you like to learn",
              ),
              TextSpan(
                text: "\ntoday? Search above.",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _categoriesBuilder(Iterable<CourseCategory> categories) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 12.0),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      controller: _scrollController,
      physics: BouncingScrollPhysics(),
      addAutomaticKeepAlives: true,
      itemCount: categories.length,
      itemBuilder: (_, index) {
        CourseCategory category = categories.elementAt(index);
        Iterable<Course> categoryCourses = category.courses;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(8.0, 3.0, 10.0, 3.0),
              margin: const EdgeInsets.only(bottom: 5.0),
              color: Colors.white38,
              child: RichText(
                text: TextSpan(
                  text: "#",
                  semanticsLabel: "Hash",
                  style: Theme.of(context).textTheme.title.copyWith(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                        color: AppColors.oylexPrimary,
                      ),
                  children: [
                    TextSpan(
                      text: category.name,
                      style: Theme.of(context).textTheme.body2.copyWith(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            letterSpacing: 0.7,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: deviceHeight(context) * 0.3,
              child: ListView.builder(
                controller: ScrollController(keepScrollOffset: false),
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categoryCourses.length,
                itemBuilder: (_, index) {
                  return SquareCourseCard(
                    course: categoryCourses.elementAt(index),
                    flexAlignment: MainAxisAlignment.start,
                    radius: radius,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
