import 'package:flutter/material.dart';
import '../screen/rigging/riggingRoot.dart';
import '../screen/rigging/getImage.dart';
import '../widget/design/settingColor.dart';
import './drawer/drawer.dart';
import './rigging/drawSkeleton.dart';
import 'login/logIn.dart';

String currentPageKey = 'RootScreen';

class Navigation_Greedot extends StatefulWidget {
  final int initialPageIndex;
  const Navigation_Greedot({super.key, this.initialPageIndex=0});

  @override
  State<Navigation_Greedot> createState() => _Navigation_GreedotState();
}

class _Navigation_GreedotState extends State<Navigation_Greedot> {
  late int currentPageIndex = 0;

  void _changePage(String pageKey) {
    setState(() {
      currentPageKey = pageKey;
    });
  }

  @override
  Widget build(BuildContext context) {
      return GestureDetector(
          onTap: () {
            // 포커스를 제거하여 키보드를 숨깁니다.
        FocusScope.of(context).unfocus();
      },
      child : Scaffold(
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
            switch (index) {
              case 0:
                _changePage('RootScreen');
                break;
              case 1:
                _changePage('getImage_greedot');
                break;
              case 2:
                _changePage('logIn_greedot'); // 로그인 페이지로 바꾸기
                break;
              default:
                _changePage('RootScreen');
                break;
            }
            currentPageIndex = index;
          });
        },
        backgroundColor: colorSnackBar_greedot,
        selectedItemColor: colorText_greedot,
        //todo 색수정
        unselectedItemColor: colorText_greedot,
        items: bottomNavigationBarItems,
      ),
      body: buildBody(currentPageKey),
      ),
    );
  }

  Widget buildBody(String pageKey) { // 로그인 페이지 추가하기
    // 현재 페이지 인덱스에 따라 다른 위젯을 반환합니다.
    switch (pageKey) {
      case 'RootScreen':
        return RootScreen(); // onPageChange: _changePage
      case 'getImage_greedot':
        return const getImage_greedot();
      case 'logIn':
        return LogIn();
      // case '가고싶은페이지':
      //   return 가고싶은페이지();
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
