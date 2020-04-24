import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/components/main/shaped-course-container.dart';

class NoCoursesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                left: deviceWidth(context) * 0.15,
                child: Transform.rotate(
                  angle: 5.98,
                  child: Container(
                    width: deviceWidth(context) * 0.4,
                    height: deviceHeight(context) * 0.21,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      shape: ShapedCourseContainer(),
                      color: Colors.white,
                      shadows: [
                        BoxShadow(
                          color: AppColors.windowBackground.shade700,
                          blurRadius: 6.0,
                          offset: Offset(4.0, 4.0),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 7,
                          child: Container(
                            padding: EdgeInsets.zero,
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                              clipBehavior: Clip.hardEdge,
                              child: Image(
                                image: AssetImage("$MISC_IMAGES_FOLDER/03.jpg"),
                                width: double.infinity,
                                fit: BoxFit.cover,
                                semanticLabel: "Course Image",
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: deviceWidth(context) * 0.15,
                child: Transform.rotate(
                  angle: 0.34,
                  child: Container(
                    width: deviceWidth(context) * 0.4,
                    height: deviceHeight(context) * 0.21,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      shape: ShapedCourseContainer(),
                      color: Colors.white,
                      shadows: [
                        BoxShadow(
                          color: AppColors.windowBackground.shade700,
                          blurRadius: 6.0,
                          offset: Offset(4.0, 4.0),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 7,
                          child: Container(
                            padding: EdgeInsets.zero,
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                              clipBehavior: Clip.hardEdge,
                              child: Image(
                                image: AssetImage("$IMAGES_FOLDER/knowledge-07.jpg"),
                                width: double.infinity,
                                fit: BoxFit.cover,
                                semanticLabel: "Course Image",
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  width: deviceWidth(context) * 0.40,
                  height: deviceHeight(context) * 0.26,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    shape: ShapedCourseContainer(),
                    color: Colors.white,
                    shadows: [
                      BoxShadow(
                        color: AppColors.windowBackground.shade700,
                        blurRadius: 6.0,
                        offset: Offset(4.0, 4.0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 7,
                        child: Container(
                          padding: EdgeInsets.zero,
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                            clipBehavior: Clip.hardEdge,
                            child: Image(
                              image: AssetImage("$IMAGES_FOLDER/knowledge-03.jpg"),
                              width: double.infinity,
                              fit: BoxFit.cover,
                              semanticLabel: "Course Image",
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Center(
            child: Text(
              "No Courses!",
              style: Theme.of(context).textTheme.title.copyWith(fontSize: 20.0, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              "Choose a course from \nFeatured Courses or use the button \nbelow to start.",
              style: Theme.of(context).textTheme.display2.copyWith(
                    fontSize: 17.0,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: Container(
              width: deviceHeight(context) * 0.09,
              height: deviceHeight(context) * 0.09,
              child: Material(
                child: Ink(
                  child: InkWell(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 28.0,
                    ),
                    splashColor: Colors.white60,
                    onTap: () {},
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                type: MaterialType.button,
                color: AppColors.oylexPrimary.shade200,
                borderRadius: BorderRadius.all(Radius.circular(14.0)),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(14.0)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.oylexPrimary.shade50,
                    blurRadius: 8.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
