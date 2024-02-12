import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/design/settingColor.dart';
import '../../screen/mypage/userAuth.dart';

class MyInfo {
  final String accountName;
  final String accountEmail;
  final String phoneNumber;
  final String password;

  MyInfo({
    required this.accountName,
    required this.accountEmail,
    required this.phoneNumber,
    required this. password,
  });
}

class MyPage extends StatefulWidget {
  MyPage({Key? key}) : super(key: key); // 외부에서 MyInfo를 받지 않음

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late MyInfo myInfo; // 상태로 MyInfo 객체 선언
  bool showMyInfoCard = true;

  @override
  void initState() {
    super.initState();
    // MyInfo 객체를 여기서 생성하고 초기화
    myInfo = MyInfo(
        accountName: '홍길동',
        accountEmail: 'honggildong@example.com',
        phoneNumber: '010-1234-5678',
        password: '1234'
    );
  }

  void _handleEdit() {
    // 프로필 수정 로직
  }

  void _handleLogout() {
    //Provider.of<UserAuth>(context, listen: false).logout();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: showMyInfoCard
            ? Card(
          //color: Colors.transparent,
          color: colorMainBG_greedot,
          elevation: 4.0,
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(70),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius:60,
                      backgroundColor: colorBut_greedot,
                      backgroundImage: AssetImage('assets/images/kid.png'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      myInfo.accountName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 80),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoContainer('이메일 계정', myInfo.accountEmail),
                    SizedBox(height: 40), // 간격 조정
                    _buildInfoContainer('비밀번호', myInfo.password),
                    SizedBox(height: 40), // 간격 조정
                    _buildInfoContainer('전화번호', myInfo.phoneNumber),
                  ],
                ),
                SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: Text('프로필 수정'),
                      onPressed: _handleEdit,
                    ),
                    TextButton(
                      child: Text('로그아웃'),
                      onPressed: _handleLogout,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
            : CircleAvatar(
          backgroundImage: AssetImage('assets/images/kid.png'),
        ),
      ),
    );
  }
}

Widget _buildInfoContainer(String title, String value) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
    decoration: BoxDecoration(
      color: colorBut_greedot,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            '$title  :  $value',
            style: TextStyle(
              fontSize: 15,
              color: colorText_greedot, // 텍스트 색상
            ),
          ),
        ),
      ],
    ),
  );
}
