import 'package:flutter/material.dart';
import 'screen2.dart';
import 'screen3.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key); // Key 타입을 명시하고 super로 넘겨줍니다.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              child: const Text('이미지 리깅하기'),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Screen2()),
                );
              },
            ),
            SizedBox(height: 20),
          ElevatedButton(
              child: const Text('이미지 리깅하기'),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Screen3()),
                );
              },
          ),
          ]
        )
      ), // Container 뒤에 콤마가 있으며, Scaffold를 닫는 괄호 뒤에 세미콜론을 추가해야 합니다.
    ); // 여기에 세미콜론을 추가합니다.
  }
}
