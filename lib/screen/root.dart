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
      appBar: AppBar(
        title: const Text("AppBar"),
        backgroundColor: backgroundColorMain_greedot,
        centerTitle: false,
        elevation: 0.0,
      ),
      endDrawer: const drawer_greedot(),
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

class drawer_greedot extends StatelessWidget {
  const drawer_greedot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              //backgroundImage: AssetImage('assets/gozero.png'),
            ),
            accountName: Text('dong'),
            accountEmail: Text('dongdong@naver.com'),
            onDetailsPressed: () {
              print('Hello, My Hope World!');
            },
            decoration: BoxDecoration(
              color: Colors.red[200],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.grey[850],
            ),
            title: const Text('Home'),
            onTap: () {
              print('Home button is clicked!');
            },
            trailing: Icon(Icons.add),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.grey[850],
            ),
            title: Text('settings'),
            onTap: () {
              print('settings button is clicked!');
            },
            trailing: Icon(Icons.add),
          ),
          ListTile(
            leading: Icon(
              Icons.question_answer,
              color: Colors.grey[850],
            ),
            title: Text('Q&A'),
            onTap: () {
              print('Q&A button is clicked!');
            },
            trailing: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
