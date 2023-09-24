// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../utils/constants.dart';
import 'categories.dart';

import 'home.dart';

final PersistentTabController bottomTabController =
    PersistentTabController(initialIndex: 0);

class LandingScreen extends StatelessWidget {
  LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildScreens() {
      return [
        Home(),
        CategoriesScreen(),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          title: "Home",
          inactiveIcon: Image.asset(
            "assets/home.png",
            height: kWidth(context) > 450 ? 25 : 20,
            width: kWidth(context) > 450 ? 25 : 20,
            color: Colors.grey,
          ),
          icon: Image.asset(
            "assets/home.png",
            height: kWidth(context) > 450 ? 30 : 25,
            width: kWidth(context) > 450 ? 30 : 25,
            color: Theme.of(context).primaryColor,
          ),
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: Theme.of(context).primaryColor,
        ),
        PersistentBottomNavBarItem(
          title: "Categories",
          inactiveIcon: Image.asset(
            "assets/categories.png",
            height: kWidth(context) > 450 ? 25 : 20,
            width: kWidth(context) > 450 ? 25 : 20,
            color: Colors.grey,
          ),
          icon: Image.asset(
            "assets/categories.png",
            height: kWidth(context) > 450 ? 30 : 25,
            width: kWidth(context) > 450 ? 30 : 25,
            color: Theme.of(context).primaryColor,
          ),
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: Theme.of(context).primaryColor,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: bottomTabController,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,

      backgroundColor:
          Theme.of(context).bottomAppBarColor, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(0.0),
          colorBehindNavBar: Color.fromARGB(255, 0, 0, 0)),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.easeInExpo,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style3, // Choose the nav bar style with this property.
    );
  }
}
