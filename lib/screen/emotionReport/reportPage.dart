import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../widget/design/settingColor.dart';
import '../../widget/design/sharedController.dart';
import '../../provider/pageNavi.dart';
import '../../service/user_service.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  Map<String, List<String>> emotion_sentences = {
    // 감정 문장 딕셔너리
    '기쁨': ['기쁨을 느낄 때 나는 노래를 부른다.'],
    '당황': ['당황할 때면 얼굴이 빨개진다.'],
    '분노': ['화가 날 때는 숨을 깊게 쉰다.'],
    '불안': ['불안할 때는 친구와 이야기한다.'],
    '상처': [
      '누군가 나를 오해했을 때 상처를 받는다.',
      '말없이 돌아선 친구에게 마음이 아팠다.',
      '상처 주네',
      '어쩌고',
      '저쩌고',
      '무언가',
      '상처 되는 말',
      '각박한',
      '현대사회',
    ],
    '슬픔': ['슬플 때는 혼자만의 시간을 갖는다.'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorMainBG_greedot,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 130, // 상단에 위치
              left: 0,
              right: 0,
              child: buildChartAndImageRow(),
            ),
            Positioned(
              bottom: 50, // 하단에 위치
              left: 10,
              right: 10,
              child: buildScrollableEmotionSentences('상처'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChartAndImageRow() {
    // 차트와 이미지 표시하는 메서드 구현
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: Center(
              child: Text('파이 차트', style: TextStyle(color: Colors.white)),
            ),
          ),
          Image.asset('assets/images/greegirl.png', width: 100.0),
        ],
      ),
    );
  }

  Widget buildScrollableEmotionSentences(String emotion) {
    // 특정 감정에 대한 모든 문장을 스크롤 가능한 텍스트로 표시하는 메서드 구현
    String allSentences = emotion_sentences[emotion]!.join('\n\n');
    return Container(
      height: 300,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: colorFilling_greedot,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey[400]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Text(
          allSentences,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}

