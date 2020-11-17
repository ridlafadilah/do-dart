import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/eva_icons/outline/svg/home-outline.svg',
      selectedImagePath: 'assets/eva_icons/fill/svg/home.svg',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/eva_icons/outline/svg/activity-outline.svg',
      selectedImagePath: 'assets/eva_icons/fill/svg/activity.svg',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/eva_icons/outline/svg/bulb-outline.svg',
      selectedImagePath: 'assets/eva_icons/fill/svg/bulb.svg',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/eva_icons/outline/svg/person-outline.svg',
      selectedImagePath: 'assets/eva_icons/fill/svg/person.svg',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
