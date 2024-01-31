import 'package:flutter/material.dart';
import '../root.dart';
import '../../widget/design/settingColor.dart';
import 'memberRegister.dart';
import '../../widget/design/sharedController.dart';
import 'findPassword.dart';
import '../../screen/rigging/riggingRoot.dart';
import 'loading.dart';


class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  // TextEditingController controller = TextEditingController();
  // TextEditingController controller2 = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorMainBG_greedot,
      child: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ScaffoldMessenger(
                key: scaffoldMessengerKey,
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
                                  labelStyle: TextStyle(color: colorSnackBar_greedot, fontSize: 15.0)
                              )
                          ),
                          child: Container(
                            padding: EdgeInsets.all(40.0),
                            child: Column(
                              children: [
                                Material(
                                  child : TextField(
                                      controller: emailController,
                                      autofocus: true,
                                    decoration: InputDecoration(
                                      labelText: 'Enter email',
                                      hintText: 'mjw01@hello.com',
                                      hintStyle: TextStyle(color: Colors.grey),
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
                                ),
                                SizedBox(height: 10),
                                Material(
                                  child : TextField(
                                  controller: passwordController,
                                    decoration: InputDecoration(
                                      labelText: '비밀번호',
                                      hintStyle: TextStyle(color: Colors.grey),
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
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  ),
                                ),
                                SizedBox(height: 40.0),
                                ButtonTheme(
                                    minWidth: 100.0,
                                    height: 50.0,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // 로그인 버튼 로직
                                      },
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: colorText_greedot,
                                        size: 35.0,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: colorBut_greedot,
                                      ),
                                    )
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
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
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }

  void showSnackBar(BuildContext context, Text text) {
    final snackBar = SnackBar(
      content: text,
      backgroundColor: colorSnackBar_greedot,
    );
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
