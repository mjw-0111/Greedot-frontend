import 'package:flutter/material.dart';

import '../screen/rigging/riggingRoot.dart';
import '../screen/rigging/getImage.dart';
import '../widget/design/settingColor.dart';

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
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: buttonColor_greedot,
        backgroundColor: navigationBarColor_greedot,
        selectedIndex: currentPageIndex,
        height: 60,
        destinations: navigationMenu_greedot,
      ),
      body: <Widget>[
        const RootScreen(),
        const getImage_greedot(),
        const RootScreen(),
      ][currentPageIndex],
    );
  }

  List<Widget> get navigationMenu_greedot {
    return const <Widget>[
      NavigationDestination(
        selectedIcon: Icon(Icons.home),
        icon: Icon(Icons.home_outlined),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Badge(child: Icon(Icons.notifications_sharp)),
        label: 'Notifications',
      ),
      NavigationDestination(
        icon: Badge(
          child: Icon(Icons.messenger_sharp),
        ),
        label: 'Messages',
      ),
    ];
  }
}
