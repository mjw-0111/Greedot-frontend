import 'package:flutter/material.dart';

import '../screen/rigging/riggingRoot.dart';
import '../screen/rigging/getImage.dart';
import '../widget/design/settingColor.dart';
import './drawer/drawer.dart';

class Navigation_Greedot extends StatefulWidget {
  const Navigation_Greedot({super.key});

  @override
  State<Navigation_Greedot> createState() => _Navigation_GreedotState();
}

class _Navigation_GreedotState extends State<Navigation_Greedot> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Greedot"),
        backgroundColor: colorMainBG_greedot,
        centerTitle: false,
        elevation: 0.0,
      ),
      endDrawer: const drawer_greedot(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: colorNaviBar_greedot,
        selectedItemColor: colorText_greedot,
        unselectedItemColor: Colors.grey,
        items: bottomNavigationBarItems,
      ),
      body: <Widget>[
        const RootScreen(),
        const getImage_greedot(),
        const RootScreen(),
      ][currentPageIndex],
    );
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
