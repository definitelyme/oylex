import 'dart:math' as math;

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/Models/course-models/content-levels.dart';
import 'package:oylex/Models/course-models/course-content.dart';
import 'package:oylex/Models/course-models/course.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

// ignore: must_be_immutable
class CourseContentLevels extends StatelessWidget {
  CourseContentLevels({Key key, this.course}) : super(key: key);

  Course course;

  @override
  Widget build(BuildContext context) {
    Content _content = Course.generatedContentForCourse(course);

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
        isLast: index == _content.levels.length,
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
                theme: ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: false,
                  hasIcon: hasFirstLevel,
//                  bodyAlignment: ExpandablePanelBodyAlignment.center,
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
//                      controller: _expandableController,
                      theme: ExpandableThemeData(crossFadePoint: 0),
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
      itemCount: _content.levels.length,
      itemBuilder: (_, index) => __buildExpandableCard(_content.levels[index]),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
//      addAutomaticKeepAlives: true,
    );
  }
}
