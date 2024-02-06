import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

import '../root.dart';
import '../../widget/design/settingColor.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), () {
      bool condition = checkCondition();
      if (condition) {
        exit(0);
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const Navigation_Greedot()));
      }
    });
  }

  bool checkCondition() {
    // 조건 로직 구현// 예시 조건 함수 //여기다 구현
    return false;
  }

  @override
  Widget build(BuildContext context) {
    //const String imageLogoName = 'assets/images/flyai.png';

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        // Handle the pop. If `didPop` is false, it was blocked.
      },
      child: MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: colorAppbar_greedot,
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.384375),
                // Container(
                //   child: SvgPicture.asset(
                //     imageLogoName,
                //     width: screenWidth * 0.616666,
                //     height: screenHeight * 0.0859375,
                //   ),
                // ),
                const Expanded(child: SizedBox()),
                Align(
                  child: Text("© Greedot",
                      style: TextStyle(
                        fontSize: screenWidth * (14 / 360),
                        color: Color.fromRGBO(255, 255, 255, 0.6),
                      )),
                ),
                SizedBox(
                  height: screenHeight * 0.0625,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
