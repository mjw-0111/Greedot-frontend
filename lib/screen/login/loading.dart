import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../widget/design/settingColor.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      // 2초 후에 다른 화면으로 이동
      Future.delayed(Duration(seconds: 2), () {
        // 이동할 화면으로 네비게이션

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Scaffold 대신 Container를 사용하되, 기능은 유지
      color: Colors.white, // 배경색 지정
      child: Center(
        // 로딩바 구현 부분
        child: SpinKitFadingCube(
          color: colorAppbar_greedot,
          size: 50.0,
          duration: Duration(seconds: 2),
        ),
      ),
    );
  }
}
