import 'dart:convert';
import 'package:flutter/material.dart';
import 'login.dart'; //
import '../../widget/design/settingColor.dart';
import '../../widget/design/sharedController.dart';
import '../../models/user_model.dart';
import '../../service/user_service.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: colorMainBG_greedot,
        body: SignupPage(),
      ),
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
      email: emailController.text,
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
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max, // Column의 크기를 최대로 설정
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
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
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: '닉네임',
                prefixIcon: Icon(Icons.person_outline),
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
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '비밀번호',
                prefixIcon: Icon(Icons.lock_outline),
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
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '비밀번호 확인',
                prefixIcon: Icon(Icons.repeat),
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
            TextField(
              controller: logPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '대화 로그 확인용 비밀번호',
                prefixIcon: Icon(Icons.child_care),
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
            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorBut_greedot,
              ),
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
void _showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("회원가입 성공"),
        content: Text("회원가입이 성공적으로 완료되었습니다."),
        actions: <Widget>[
          TextButton(
            child: Text("확인"),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LogIn()), // Login 페이지 경로 확인 필요
                    (Route<dynamic> route) => false,
              );
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
      duration: Duration(seconds: 2),
    ),
  );
}

void _showPasswordMismatchError(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('비밀번호가 일치하지 않습니다'),
      backgroundColor: colorSnackBar_greedot,
      duration: Duration(seconds: 2),
    ),
  );
}