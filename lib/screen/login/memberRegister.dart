import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projectfront/provider/pageNavi.dart';
import 'package:provider/provider.dart';
import '../../widget/design/settingColor.dart';
import '../../widget/design/sharedController.dart';
import '../../models/user_model.dart';
import '../../service/user_service.dart';
import '../../widget/design/textField_greedot.dart';
import 'package:http/http.dart' as http;
import 'package:projectfront/widget/design/basicButtons.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // 전체 너비
      height: MediaQuery.of(context).size.height, // 전체 높이
      child: SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //회원가입 로직
  Future<void> _register() async {
    if (passwordController.text != confirmPasswordController.text) {
      _showPasswordMismatchError(context);
      return;
    }
    final model = RegisterModel(
      username: usernameController.text,
      nickname: usernameController.text,
      password: passwordController.text,
    );
    final response = await ApiService.registerUser(model);

    _handleResponse(response);
  }

  // http 응답 200이면 넘어가고 아니면 에러 메세지 출력
  void _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      _showSuccessDialog(context);
    } else {
      final errorMessage = _extractErrorMessage(response);
      _showRegistrationFailedError(context, errorMessage);
    }
  }

  //응답 처리 인코딩 함수
  String _extractErrorMessage(http.Response response) {
    try {
      final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return decodedResponse['detail'] ?? '알 수 없는 오류가 발생했습니다.';
    } catch (e) {
      return '응답 처리 중 오류가 발생했습니다.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: colorMainBG_greedot,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max, // Column의 크기를 최대로 설정
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField_greedot(
              controller: usernameController,
              labelText: '이메일',
              icon: Icons.mail_outline,
            ),
            SizedBox(height: 20),
            TextField_greedot(
              controller: usernameController,
              labelText: '닉네임',
              icon: Icons.person_outline,
            ),
            SizedBox(height: 20),
            TextField_greedot(
              controller: passwordController,
              labelText: '비밀번호',
              icon: Icons.lock_outline,
            ),
            SizedBox(height: 20),
            TextField_greedot(
              controller: confirmPasswordController,
              labelText: '비밀번호 확인',
              icon: Icons.repeat,
            ),
            SizedBox(height: 20),
            TextField_greedot(
              controller: logPasswordController,
              labelText: '대화 로그 확인용 비밀번호',
              icon: Icons.child_care,
            ),
            SizedBox(height: 20),
            EleButton_greedot(
                additionalFunc: () {
                  _register(); //getImage 함수를 호출해서 카메라로 찍은 사진 가져오기
                },
                buttonText: "회원가입"),
          ],
        ),
      ),
    );
  }
}

void _showSuccessDialog(BuildContext context) {
  final pageNavi =
      Provider.of<PageNavi>(context, listen: false); // PageNavi 객체 접근
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("회원가입 성공"),
        content: const Text("회원가입이 성공적으로 완료되었습니다."),
        actions: <Widget>[
          TextButton(
            child: const Text("확인"),
            onPressed: () {
              Navigator.of(context).pop(); // 대화상자를 닫음
              pageNavi.changePage('LogIn');
            },
          ),
        ],
      );
    },
  );
}

void _showRegistrationFailedError(BuildContext context, errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage),
      backgroundColor: colorSnackBar_greedot,
      duration: const Duration(seconds: 2),
    ),
  );
}

void _showPasswordMismatchError(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('비밀번호가 일치하지 않습니다'),
      backgroundColor: colorSnackBar_greedot,
      duration: Duration(seconds: 2),
    ),
  );
}
