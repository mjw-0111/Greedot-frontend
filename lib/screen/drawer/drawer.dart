import 'package:flutter/material.dart';

import '../../screen/rigging/riggingRoot.dart';
import '../../screen/rigging/getImage.dart';
import '../../widget/design/settingColor.dart';

class drawer_greedot extends StatelessWidget {
  const drawer_greedot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            accountName: const Text('dong'),
            accountEmail: const Text('dongdong@naver.com'),
            onDetailsPressed: () {
              print('Hello, My Hope World!');
            },
            decoration: const BoxDecoration(
              color: colorBut_greedot,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
            ),
          ),
          DrawerListTile(listTileIcon: Icons.home, listTileText: "home"),
          DrawerListTile(listTileIcon: Icons.alarm, listTileText: "alarm"),
          DrawerListTile(listTileIcon: Icons.settings, listTileText: "mes"),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData listTileIcon; // 변수명을 소문자로 시작하도록 변경
  final String listTileText;
  DrawerListTile(
      {super.key,
      this.listTileIcon = Icons.home,
      this.listTileText = "needinput"});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(listTileIcon, color: colorText_greedot), // const 제거
      title: Text(
        listTileText,
        style: TextStyle(color: colorText_greedot),
      ),
      onTap: () {
        print('Home button is clicked!');
      },
      trailing: Icon(
        Icons.add,
        color: colorText_greedot, // const 제거
      ),
    );
  }
}
