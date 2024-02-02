// import 'package:flutter/material.dart';

// import '../screen/rigging/riggingRoot.dart';
// import '../screen/rigging/getImage.dart';
// import '../widget/design/settingColor.dart';
// import './drawer/drawer.dart';

// class Navigation_Greedot extends StatefulWidget {
//   const Navigation_Greedot({super.key});

//   @override
//   State<Navigation_Greedot> createState() => _Navigation_GreedotState();
// }

// class _Navigation_GreedotState extends State<Navigation_Greedot> {
//   int currentPageIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Greedot"), //향후 우리 로고로 대체
//         backgroundColor: colorMainBG_greedot,
//         centerTitle: false,
//         elevation: 0.0,
//       ),
//       endDrawer: const drawer_greedot(),
//       bottomNavigationBar: NavigationBar(
//         onDestinationSelected: (int index) {
//           setState(() {
//             currentPageIndex = index;
//           });
//         },
//         indicatorColor: colorBut_greedot,
//         backgroundColor: colorNaviBar_greedot,
//         selectedIndex: currentPageIndex,
//         height: 60,
//         destinations: navigationMenu_greedot,
//       ),
//       body: <Widget>[
//         const RiggingRoot(),
//         const GetImage_greedot(),
//         const RiggingRoot(),
//       ][currentPageIndex],
//     );
//   }

//   List<Widget> get navigationMenu_greedot {
//     return const <Widget>[
//       NavigationMenuIcon(navIcon: Icons.home, navText: "home"),
//       NavigationMenuIcon(
//           navIcon: Icons.notification_add, navText: "notification"),
//       NavigationMenuIcon(navIcon: Icons.message, navText: "setting"),
//     ];
//   }
// }

// class NavigationMenuIcon extends StatelessWidget {
//   final IconData navIcon;
//   final String navText;

//   const NavigationMenuIcon({
//     super.key,
//     required this.navIcon,
//     required this.navText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return NavigationDestination(
//       selectedIcon: Icon(
//         navIcon,
//         color: colorText_greedot,
//       ),
//       icon: Icon(navIcon), // navIcon을 사용
//       label: navText, // navText를 사용
//     );
//   }
// }
