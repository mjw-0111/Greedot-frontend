import 'package:flutter/material.dart';
import 'package:projectfront/provider/pageNavi.dart';
import 'package:provider/provider.dart';
import '../../models/user_model.dart';
import '../../service/user_service.dart';
import '../../widget/design/settingColor.dart';
import '../login/logIn.dart';

class MyPage extends StatefulWidget {
  MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late Future<UserModel> userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = ApiService.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: colorMainBG_greedot,
      ),
      body: FutureBuilder<UserModel>(
        future: userProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            UserModel user = snapshot.data!;
            return Container(
              color: Colors.transparent,
              child: Center(
                child: Card(
                  color: colorMainBG_greedot,
                  elevation: 4.0,
                  margin: EdgeInsets.all(20),
                  child: Padding(
                    padding: EdgeInsets.all(70),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 16),
                        Text(
                          user.nickname, // 사용자 이름 표시
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily:'greedot_font'
                          ),
                        ),
                        SizedBox(height: 80),
                        _buildInfoContainer('이메일 계정', user.username),
                        SizedBox(height: 40),
                        _buildInfoContainer('멤버쉽 등급', user.gradeString),
                        SizedBox(height: 100),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: Text('프로필 수정',style:TextStyle(fontFamily:'greedot_font')),
                              onPressed: () => showEditProfileDialog(context, user),
                            ),
                            TextButton(
                              child: Text('로그아웃',style:TextStyle(fontFamily:'greedot_font')),
                              onPressed: () => _handleLogout()
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(child: Text("No data"));
          }
        },
      ),
    );
  }

  void _handleLogout() async {
    await AuthService.deleteToken(); // 토큰 삭제하여 로그아웃 처리
    // 로그아웃 후 로그인 화면으로 이동
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (context) => LogIn()),
    // );
    Navigator.of(context).pop();
    final pageNavi = Provider.of<PageNavi>(context, listen: false);
    pageNavi.changePage('LogIn');
  }

  void showEditProfileDialog(BuildContext context, UserModel user) {
    TextEditingController nicknameController = TextEditingController(text: user.nickname);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: TextField(
            controller: nicknameController,
            decoration: InputDecoration(hintText: "Enter new nickname"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                UserProfileUpdateModel updatedData = UserProfileUpdateModel(
                  nickname: nicknameController.text,
                  // 다른 필드가 있다면 여기에 추가
                );
                var response = await ApiService.updateUserProfile(updatedData);
                if (response.statusCode == 200) {
                  setState(() {
                    userProfile = ApiService.getUserProfile(); // 프로필 정보 새로고침
                  });
                  Navigator.of(context).pop(); // 다이얼로그 닫기
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile update failed")));
                }
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
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
                color: colorText_greedot,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
