import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/Models/course-models/course.dart';
import 'package:oylex/components/main/rating-builder.dart';
import 'package:oylex/components/main/tag-widget.dart';

class SquareCourseCard extends StatelessWidget {
  final Course course;
  final double height;
  final double width;
  final int topFlex;
  final int bottomFlex;
  final double titleFont;
  final MainAxisAlignment flexAlignment;
  final double radius;
  final Function onPressed;

  SquareCourseCard({
    @required this.course,
    this.height,
    this.width,
    this.topFlex = 5,
    this.bottomFlex = 7,
    this.titleFont = 15.0,
    this.flexAlignment = MainAxisAlignment.center,
    this.radius = 16.0,
    @required this.onPressed,
  }) : assert(course != null);

  @override
  Widget build(BuildContext context) {
    double cardHeight = height ?? double.infinity;
    double cardWidth = width ?? deviceWidth(context) * 0.5;

    precacheImage(AssetImage(course.image), context);

    return Stack(
      children: <Widget>[
        Container(
          width: cardWidth,
          height: cardHeight,
          margin: EdgeInsets.only(right: 12.0, bottom: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [
              BoxShadow(
                color: AppColors.windowBackground.shade700,
                blurRadius: 6.0,
                offset: Offset(4.0, 4.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: flexAlignment,
            children: <Widget>[
              Flexible(
                flex: topFlex,
                child: Container(
                  padding: EdgeInsets.zero,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
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
                flex: bottomFlex,
                child: Material(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(radius), bottomRight: Radius.circular(radius)),
                  clipBehavior: Clip.hardEdge,
                  type: MaterialType.transparency,
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onPressed,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Text(
                                course.title,
                                style: Theme.of(context).textTheme.title.copyWith(fontSize: titleFont, fontWeight: FontWeight.w500, letterSpacing: 0.8),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                semanticsLabel: "Course Title",
                                softWrap: true,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          Text(
                            course.user.fullName,
                            style: Theme.of(context).textTheme.caption.copyWith(fontSize: 13.5),
                          ),
                          RatingBuilder(rating: course.rating),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "NGN${course.price}",
                                style: Theme.of(context).textTheme.subhead.copyWith(fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                "${course.oldPrice ?? ""}",
                                style: Theme.of(context).textTheme.caption.copyWith(color: Colors.grey, fontSize: 13.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        course.tag != null
            ? Positioned(
                top: 0.0,
                left: 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0)),
                  child: ItemTag(
                    text: "${course.tag}",
                    backgroundColor: AppColors.oylexAccent.shade400,
                    textColor: Colors.white,
                    leftPadding: 10.0,
                    rightPadding: 17.0,
                    topPadding: 4.0,
                    bottomPadding: 4.0,
                  ),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
