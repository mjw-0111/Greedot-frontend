import 'package:flutter/material.dart';
//import 'homePage.dart';
import '../root.dart';
import '../../widget/design/settingColor.dart';
import 'memberRegister.dart';
import '../../widget/design/sharedController.dart';
import 'findPassword.dart';
import '../../screen/rigging/riggingRoot.dart';

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorMainBG_greedot,
      // email, password 입력하는 부분을 제외한 화면을 탭하면, 키보드 사라지게 GestureDetector 사용
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 50)),
              Center(
                child: Image(
                  image: AssetImage('assets/images/gree.png'),
                  width: 200.0,
                ),
              ),
              Form(
                  child: Theme(
                    data: ThemeData(
                        primaryColor: Colors.grey,
                        inputDecorationTheme: InputDecorationTheme(
                            labelStyle:
                            TextStyle(color: colorSnackBar_greedot, fontSize: 15.0))),
                    child: Container(
                        padding: EdgeInsets.all(40.0),
                        child: Builder(builder: (context) {
                          return Column(
                            children: [
                              TextField(
                                controller: controller,
                                autofocus: true,
                                decoration:
                                InputDecoration(
                                    labelText: 'Enter email',
                                    hintText: 'mjw01@hello.com',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    icon: Icon(Icons.mail_outline)
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              TextField(
                                controller: controller2,
                                decoration:
                                InputDecoration(
                                    labelText: 'Enter password',
                                    icon: Icon(Icons.lock_outline)
                                ),
                                keyboardType: TextInputType.text,
                                obscureText: true, // 비밀번호 안보이도록 하는 것
                              ),
                              SizedBox(
                                height: 40.0,
                              ),
                              ButtonTheme(
                                  minWidth: 100.0,
                                  height: 50.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (controller.text == emailController.text &&
                                          controller2.text == passwordController.text) {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => Navigation_Greedot()),
                                        );
                                      } else if (controller.text ==
                                          emailController.text &&
                                          controller2.text != passwordController.text) {
                                        showSnackBar(
                                            context, Text('비밀번호를 다시 확인해주세요'));
                                      } else if (controller.text !=
                                          emailController.text &&
                                          controller2.text == passwordController.text) {
                                        showSnackBar(context, Text('이메일 주소를 다시 확인해주세요'));
                                      } else {
                                        showSnackBar(
                                            context, Text('회원 정보를 다시 확인해주세요'));
                                      }
                                    },
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: colorText_greedot,
                                      size: 35.0,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: colorBut_greedot,
                                    ),
                                  )),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row( // 'child'를 추가해야 합니다.
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => SignupScreen()),
                                        );
                                      },
                                      child: Text(
                                        '회원가입 하기',
                                        style: TextStyle(color: colorSnackBar_greedot),
                                      ),
                                    ),
                                    Text('|', style: TextStyle(color: colorSnackBar_greedot)),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => FindPassword()),
                                        );
                                      },
                                      child: Text(
                                        '아이디·비밀번호 찾기',
                                        style: TextStyle(color: colorSnackBar_greedot),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        })),
                  ))
            ],
          ),
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
