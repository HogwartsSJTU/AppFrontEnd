import 'package:Hogwarts/pages/home.dart';
import 'package:Hogwarts/theme/app_theme.dart';

import 'package:flutter/material.dart';
import 'drawer_user_controller.dart';
import 'home_drawer.dart';
import 'package:Hogwarts/pages/friend.dart';

class NavigationHomeScreen extends StatefulWidget {
  NavigationHomeScreen({
    this.drawerIndex = DrawerIndex.HOME
  });

  final DrawerIndex drawerIndex;

  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = widget.drawerIndex;
    setIndex();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width > 1080 ? 300 : MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void setIndex() {
    if (drawerIndex == DrawerIndex.HOME) {
        screenView = HomePage();
    } else if (drawerIndex == DrawerIndex.Finder) {
        screenView = Center(child: Text("DISCOVER"),);
    } else if (drawerIndex == DrawerIndex.Project) {
        screenView = FriendPage();
    } else if (drawerIndex == DrawerIndex.Contact) {
        screenView = Center(child: Text("CONTACT"),);
    } else if (drawerIndex == DrawerIndex.Setting) {
        screenView = Center(child: Text("SETTING"),);
    } else {
      //do in your way......
    }
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = HomePage();
        });
      } else if (drawerIndex == DrawerIndex.Finder) {
        setState(() {
          screenView = Center(child: Text("DISCOVER"),);
        });
      } else if (drawerIndex == DrawerIndex.Project) {
        setState(() {
          screenView = FriendPage();
        });
      } else if (drawerIndex == DrawerIndex.Contact) {
        setState(() {
          screenView = Center(child: Text("CONTACT"),);
        });
      } else if (drawerIndex == DrawerIndex.Setting) {
        setState(() {
          screenView = Center(child: Text("SETTING"),);
        });
      } else {
        //do in your way......
      }
    }
  }
}
