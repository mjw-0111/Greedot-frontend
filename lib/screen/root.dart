import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen/rigging/riggingRoot.dart';
import '../screen/rigging/getImage.dart';
import '../widget/design/settingColor.dart';
import '../provider/pageNavi.dart';

import './drawer/drawer.dart';
import './rigging/drawSkeleton.dart';
import '/screen/login/login.dart';

String currentPageKey = 'RootScreen';

class Navigation_Greedot extends StatefulWidget {
  const Navigation_Greedot({super.key});

  @override
  State<Navigation_Greedot> createState() => _Navigation_GreedotState();
}

class _Navigation_GreedotState extends State<Navigation_Greedot> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pageNavi = Provider.of<PageNavi>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Greedot"),
        backgroundColor: colorMainBG_greedot,
        centerTitle: false,
        elevation: 0.0,
      ),
      endDrawer: const drawer_greedot(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getCurrentPageIndex(pageNavi.currentPageKey),
        onTap: (int index) {
          String pageKey;
          switch (index) {
            case 0:
              pageKey = 'RootScreen';
              break;
            case 1:
              pageKey = 'getImage_greedot';
              break;
            case 2:
              pageKey = 'LogIn';
              break;
            default:
              pageKey = 'RootScreen';
              break;
          }
          pageNavi.changePage(pageKey);
        },
        backgroundColor: colorNaviBar_greedot,
        selectedItemColor: colorText_greedot,
        //todo 색수정
        unselectedItemColor: colorText_greedot,
        items: bottomNavigationBarItems,
      ),
      body: buildBody(pageNavi.currentPageKey),
    );
  }

  int _getCurrentPageIndex(String pageKey) {
    switch (pageKey) {
      case 'RootScreen':
        return 0;
      case 'getImage_greedot':
        return 1;
      case 'LogIn':
        return 2;
      default:
        return 0;
    }
  }

  Widget buildBody(String pageKey) {
    switch (pageKey) {
      case 'RootScreen':
        return RootScreen();
      case 'getImage_greedot':
        return getImage_greedot();
      case 'LogIn':
        return LogIn();
      case 'SkeletonCanvas':
        return SkeletonCanvas();
      default:
        return RootScreen();
    }
  }

  List<BottomNavigationBarItem> get bottomNavigationBarItems {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "home",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.notification_add),
        label: "notification",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.message),
        label: "setting",
      ),
    ];
  }
}
