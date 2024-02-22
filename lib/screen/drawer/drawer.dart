import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/design/settingColor.dart';
import '../../provider/pageNavi.dart';
import '../mypage/mypage.dart';

class drawer_greedot extends StatelessWidget {
  const drawer_greedot({super.key});

  @override
  Widget build(BuildContext context) {
    // PageNavi Provider에 접근
    final pageNavi = Provider.of<PageNavi>(context, listen: false);

    return SizedBox(
      width: 200,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              //backgroundColor: Colors.white,
              backgroundImage: AssetImage('/assets/images/kid.png'),
            ),
            accountName: const Text('dong',style:TextStyle(fontFamily:'greedot_font')),
            accountEmail: const Text('dongdong@naver.com',style:TextStyle(fontFamily:'greedot_font')),
            onDetailsPressed: () {
              print('Hello, My Hope World!');
              pageNavi.changePage('RiggingRoot');
              Navigator.of(context).pop();// 드로어를 닫습니다.

              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return MyPage();
                  },
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent
              );},
            decoration: const BoxDecoration(
              color: colorBut_greedot,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
            ),
          ),
          DrawerListTile(
            listTileIcon: Icons.home,
            listTileText: "home",
            onTap: () {
              pageNavi.changePage('RiggingRoot');
              Navigator.of(context).pop(); // 드로어를 닫습니다.
            },
          ),
          DrawerListTile(listTileIcon: Icons.settings, listTileText: "mes"),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData listTileIcon;
  final String listTileText;
  final VoidCallback? onTap; // onTap 콜백을 추가합니다.

  DrawerListTile({
    super.key,
    this.listTileIcon = Icons.home,
    this.listTileText = "needinput",
    this.onTap, // onTap을 생성자 매개변수로 추가합니다.
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(listTileIcon, color: colorText_greedot),
      title: Text(
        listTileText,
        style: TextStyle(color: colorText_greedot,fontFamily:'greedot_font'),
      ),
      onTap: onTap, // onTap 콜백 사용
      trailing: Icon(
        Icons.add,
        color: colorText_greedot,
      ),
    );
  }
}
