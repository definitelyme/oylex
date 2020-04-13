import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/Models/category.dart';

class AllCoursesTab extends StatefulWidget {
  @override
  _AllCoursesTabState createState() => _AllCoursesTabState();
}

class _AllCoursesTabState extends State<AllCoursesTab>
    with TickerProviderStateMixin {
  int _initialIndex = 0;
  int _tabLength = Category.generatedCategories().length;
  TabController _tabController;
  double radius = 16.0;

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
          SizedBox(height: deviceHeight(context) * 0.04),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent,
            labelColor: Colors.transparent,
            unselectedLabelColor: Colors.transparent,
            isScrollable: true,
            tabs: Category.generatedCategories()
                .map<Widget>((category) => _generateTab(context, category))
                .toList(),
          ),
          Container(
            height: deviceHeight(context) * 0.8,
            child: TabBarView(
              controller: _tabController,
              children: Category.generatedCategories()
                  .map<Widget>(
                      (category) => _generateTabView(context, category))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _generateTab(BuildContext context, Category category) {
    return Container(
      width: deviceWidth(context) * 0.4,
      height: deviceHeight(context) * 0.23,
      child: Column(
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
                  image: AssetImage(category.image),
                  width: deviceWidth(context) * 0.4,
                  height: deviceHeight(context) * 0.4,
                  fit: BoxFit.cover,
                  semanticLabel: category.title,
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
                category.title,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontSize: 15.4, fontWeight: FontWeight.w700),
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

  Widget _generateTabView(BuildContext context, Category category) {
    return Container(
      child: Text("This is a tab view of ${category.title}"),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
