import 'package:flutter/material.dart';
import 'package:oylex/Models/RouteArgs/route-args.dart';

class PermissionArgs extends RouteArgs {
  PermissionArgs(
      {this.image,
      this.title,
      this.description,
      this.skipEnabled,
      this.nextRoute,
      this.nextRouteArgs})
      : assert(title != null, 'Please provide a Title for the permission.'),
        assert(description !=
            'Please provide a little Description for the permission.'),
        assert(nextRoute != 'Provide the next Route to navigate to');

  String image;
  @required
  String title;
  @required
  String description;
  @required
  String nextRoute;
  RouteArgs nextRouteArgs;
  bool skipEnabled;

  @override
  void isNonNull() {
    // TODO: implement isNonNull
  }
}
