import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/app_icons_icons.dart';

class Destination {
  final String title;
  final IconData selectedIcon;
  final IconData unSelectedIcon;

  Destination({
    this.title,
    this.selectedIcon,
    this.unSelectedIcon,
  });

  static final List<Destination> destinations = <Destination>[
    Destination(
      title: "Featured",
      selectedIcon: AppIcons.star_filled,
      unSelectedIcon: AppIcons.star_outline,
    ),
    Destination(
      title: "Search",
      selectedIcon: AppIcons.search_filled,
      unSelectedIcon: AppIcons.search_enctype,
    ),
    Destination(
      title: "My Courses",
      selectedIcon: AppIcons.book_filled,
      unSelectedIcon: AppIcons.book_outlined,
    ),
    Destination(
      title: "Favorites",
      selectedIcon: AppIcons.like_filled,
      unSelectedIcon: AppIcons.like_outlined,
    ),
    Destination(
      title: "Account",
      selectedIcon: AppIcons.user_filled,
      unSelectedIcon: AppIcons.user_outlined,
    ),
  ];
}
