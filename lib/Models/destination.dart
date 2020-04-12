import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/app_icons_icons.dart';

class Destination {
  final String title;
  final IconData selectedIcon;
  final IconData unSelectedIcon;
  final MaterialColor selectedColor;
  final MaterialColor unSelectedColor;

  Destination(
      {this.title,
      this.selectedIcon,
      this.unSelectedIcon,
      this.selectedColor,
      this.unSelectedColor});

  static final List<Destination> destinations = <Destination>[
    Destination(
        title: "Featured",
        selectedIcon: AppIcons.star_filled,
        unSelectedIcon: AppIcons.star_outline,
        selectedColor: AppColors.oylexPrimary.shade600,
        unSelectedColor: AppColors.oylexPrimaryDark.shade400),
    Destination(
        title: "Search",
        selectedIcon: AppIcons.search_filled,
        unSelectedIcon: AppIcons.search_enctype,
        selectedColor: AppColors.oylexPrimary.shade600,
        unSelectedColor: AppColors.oylexPrimaryDark.shade400),
    Destination(
        title: "My Courses",
        selectedIcon: AppIcons.book_filled,
        unSelectedIcon: AppIcons.book_outlined,
        selectedColor: AppColors.oylexPrimary.shade600,
        unSelectedColor: AppColors.oylexPrimaryDark.shade400),
    Destination(
        title: "Favorites",
        selectedIcon: AppIcons.like_filled,
        unSelectedIcon: AppIcons.like_outlined,
        selectedColor: AppColors.oylexPrimary.shade600,
        unSelectedColor: AppColors.oylexPrimaryDark.shade400),
    Destination(
        title: "Account",
        selectedIcon: AppIcons.user_filled,
        unSelectedIcon: AppIcons.user_outlined,
        selectedColor: AppColors.oylexPrimary.shade600,
        unSelectedColor: AppColors.oylexPrimaryDark.shade400),
  ];
}
