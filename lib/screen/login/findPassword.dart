import 'package:flutter/material.dart';
import 'login.dart';
import 'package:flutter/services.dart';
import '../../widget/design/settingColor.dart';
import '../../widget/design/sharedController.dart';
import 'package:projectfront/widget/design/basicButtons.dart';

class FindPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: colorMainBG_greedot,
        body: FindPasswordPage(),
      ),
    );
  }
}

class FindPasswordPage extends StatefulWidget {
  @override
  _FindPasswordPageState createState() => _FindPasswordPageState();
}

class _FindPasswordPageState extends State<FindPasswordPage> {
  TextEditingController confirmEmailController = TextEditingController();

  void _findPassword() {
    if (confirmEmailController.text == emailController.text) {
      OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) =>
            Container(
              width: MediaQuery.of(context).size.width, // 전체 너비
              height: MediaQuery.of(context).size.height, // 전체 높이
              color: Colors.orangeAccent.withOpacity(0.7), // 반투명 배경
              child: Center(
                child: Container(
                  width: 300, // 박스 너비
                  height: 100, // 박스 높이
                  alignment: Alignment.center, // 텍스트를 중앙에 위치시킵니다.
                  decoration: BoxDecoration(
                    color: Colors.white, // 박스 배경색, 필요에 따라 수정하세요.
                    borderRadius: BorderRadius.circular(10), // 박스의 모서리를 둥글게
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          '비밀번호 : ${passwordController.text} ', // 예제 텍스트
                          style: TextStyle(color: Colors.deepOrange, fontSize: 25),
                          overflow: TextOverflow.ellipsis, // 텍스트가 박스를 넘어가면 말줄임표로 표시
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: passwordController.text)); // 클립보드에 복사
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('비밀번호가 클립보드에 복사되었습니다.'),
                              backgroundColor: colorSnackBar_greedot,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
      );

      // Overlay에 추가
      Overlay.of(context)?.insert(overlayEntry);

      // 일정 시간 후 Overlay 제거
      Future.delayed(Duration(seconds: 5), () {
        overlayEntry.remove();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('이메일이 일치하지 않습니다'),
          backgroundColor: colorSnackBar_greedot,
        ),
      );
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('비밀번호가 클립보드에 복사되었습니다.'),
        backgroundColor: colorSnackBar_greedot,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('회원가입 시 입력한 이메일 주소를 입력해주세요', style: TextStyle(color: colorSnackBar_greedot)),
            SizedBox(height: 10),
            TextField(
              controller: confirmEmailController,
              decoration: InputDecoration(
                labelText: '이메일',
                prefixIcon: Icon(Icons.mail_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                    color: colorAppbar_greedot,
                  ),
                ),
                filled: true,
                fillColor: colorFilling_greedot,
              ),
            ),
            SizedBox(height: 20),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children :[
                EleButton_greedot(
                height: 20,
                width: 150,
                buttonText: '비밀번호 찾기',
                additionalFunc: _findPassword, // _findPassword 함수를 호출합니다.
              ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogIn()),
                      );
                    },
                    child: Text('로그인 화면으로 돌아가기', style: TextStyle(color: colorSnackBar_greedot),),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, Text text) {
  final snackBar = SnackBar(
    content: text,
    backgroundColor: colorSnackBar_greedot,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
