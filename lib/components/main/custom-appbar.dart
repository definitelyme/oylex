import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oylex/components/main/courses-tab.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  CustomAppBar({
    Key key,
    @required this.scrollAppBarController,
    this.tabController,
    this.height = kToolbarHeight,
    this.tabWidth,
    this.tabBarKey,
    this.isTabbed = false,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.shape,
    this.backgroundColor,
    this.backgroundGradient,
    this.brightness,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
  })  : assert(scrollAppBarController != null),
        super(key: key);

  final ScrollAppBarController scrollAppBarController;
  final TabController tabController;
  final bool isTabbed;
  final double height;
  final double tabWidth;
  final String tabBarKey;
  final Widget leading;
  final bool automaticallyImplyLeading;
  final Widget title;
  final List<Widget> actions;
  final Widget flexibleSpace;
  final PreferredSizeWidget bottom;
  final double elevation;
  final Color backgroundColor;
  final Gradient backgroundGradient;
  final Brightness brightness;
  final IconThemeData iconTheme;
  final IconThemeData actionsIconTheme;
  final TextTheme textTheme;
  final bool primary;
  final bool centerTitle;
  final double titleSpacing;
  final ShapeBorder shape;
  final double bottomOpacity;
  final double toolbarOpacity;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(this.height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  Widget toolbar;
  double elevation;
  Color backgroundColor;

  @override
  void initState() {
    super.initState();

    switch (widget.isTabbed) {
      case true:
        {
          toolbar = CustomTabAppBar(
            key: widget.key,
            parentKey: widget.tabBarKey,
            height: widget.height,
            tabController: widget.tabController,
            tabWidth: widget.tabWidth,
          );
          break;
        }

      case false:
      default:
        {
          toolbar = AppBar(
            key: widget.key,
            leading: widget.leading,
            automaticallyImplyLeading: widget.automaticallyImplyLeading,
            title: widget.title,
            actions: widget.actions,
            flexibleSpace: widget.flexibleSpace,
            bottom: widget.bottom,
            elevation: widget.elevation,
            backgroundColor: widget.backgroundColor,
            brightness: widget.brightness,
            iconTheme: widget.iconTheme,
            actionsIconTheme: widget.actionsIconTheme,
            textTheme: widget.textTheme,
            primary: widget.primary,
            centerTitle: widget.centerTitle,
            titleSpacing: widget.titleSpacing,
            bottomOpacity: widget.bottomOpacity,
            toolbarOpacity: widget.toolbarOpacity,
            shape: widget.shape,
          );
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    backgroundColor = widget.backgroundColor ?? Colors.transparent;
    elevation = widget.elevation ?? Theme.of(context).appBarTheme.elevation ?? 2.0;

    return StreamBuilder<bool>(
      stream: widget.scrollAppBarController.pinStream,
      builder: _pinBuilder,
    );
  }

  Widget _pinBuilder(
    BuildContext context,
    AsyncSnapshot<bool> pinSnapshot,
  ) {
    if (!widget.isTabbed && (!pinSnapshot.hasData || pinSnapshot.data)) {
      return _elevation(1.0);
    }
    return StreamBuilder(
      stream: widget.scrollAppBarController.heightFactorStream,
      builder: _heightFactorBuilder,
    );
  }

  Widget _heightFactorBuilder(
    BuildContext context,
    AsyncSnapshot<double> heightFactorSnapshot,
  ) {
    if (!widget.isTabbed && (!heightFactorSnapshot.hasData)) {
      return _elevation(1.0);
    }
    return !widget.isTabbed ? _align(heightFactorSnapshot.data) : toolbar;
  }

  Widget _elevation(double heightFactor) {
    return Material(
      elevation: elevation,
      child: _decoratedContainer(heightFactor),
    );
  }

  Widget _align(double heightFactor) {
    return Align(
      alignment: Alignment(0, 1),
      heightFactor: heightFactor,
      child: _elevation(heightFactor),
    );
  }

  Widget _decoratedContainer(double heightFactor) {
    return Container(
      height: widget.scrollAppBarController.height,
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: widget.backgroundGradient,
      ),
      child: _opacity(heightFactor),
    );
  }

  Widget _opacity(double heightFactor) {
    return Opacity(
      opacity: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ).transform(heightFactor),
      child: toolbar,
    );
  }
}
