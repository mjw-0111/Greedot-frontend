import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
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
  int touchedIndex = -1;
  Map<String, List<String>> emotion_sentences = {  // 나중에 stt한 문장 감정 분류해 이 dict에 저장(?)
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

  final Map<String, Color> emotionColor = {
    '기쁨': Colors.blue,
    '당황': Colors.orange,
    '분노': Colors.red,
    '불안': Colors.yellow,
    '상처': Colors.purple,
    '슬픔': Colors.green,
  };

  Widget buildLegend() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(emotionColor.length, (index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: <Widget>[
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.primaries[index % Colors.primaries.length],
                ),
              ),
              SizedBox(width: 4),
              Text(emotionColor.keys.elementAt(index)),
            ],
          ),
        );
      }),
    );
  }

  List<PieChartSectionData> showingSections() {
    int totalSentences = emotion_sentences.values.fold(0, (previousValue, element) => previousValue + element.length);
    List<PieChartSectionData> sections = [];
    int i = 0; // 섹션 인덱스를 추적하기 위한 변수
    emotion_sentences.forEach((emotion, sentences) {
      final isTouched = i == touchedIndex;
      final color = Colors.primaries[i % Colors.primaries.length];
      final value = (sentences.length / totalSentences) * 100;
      final fontSize = isTouched ? 18.0 : 12.0; // 선택된 섹션은 폰트 크기를 더 크게 설정
      final radius = isTouched ? 135.0 : 120.0; // 선택된 섹션은 반지름을 더 크게 설정
      sections.add(
        PieChartSectionData(
          color: color,
          value: value,
          title: isTouched ? '$emotion ${value.toStringAsFixed(1)}%' : '$emotion',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
        ),
      );
      i++; // 다음 섹션으로 넘어갈 때 인덱스 증가
    });
    return sections;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorMainBG_greedot,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 35, // 상단에 위치
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height / 2,
              child: buildChartAndImageRow(),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 24, // 파이 차트 바로 아래에 위치
              left: 0,
              right: 0,
              child: buildLegend(), // 범례를 빌드하는 함수를 호출
            ),
            if (touchedIndex != -1) // touchedIndex가 -1이 아닐 때만 문장을 표시
              Positioned(
                bottom: 30, // 하단에 위치
                left: 10,
                right: 10,
                height: 200,
                child: buildScrollableEmotionSentences(
                  emotion_sentences.keys.elementAt(touchedIndex),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildChartAndImageRow() {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (event is FlTapUpEvent && pieTouchResponse != null && pieTouchResponse.touchedSection != null) {
                        // 사용자가 섹션을 탭한 경우, 해당 섹션의 인덱스를 touchedIndex에 저장
                        touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                      }
                    });
                  },
                ),
                centerSpaceRadius: 0,
                sectionsSpace: 2,
                sections: showingSections(),
              ),

            ),
          ),
          Expanded(
            child: Image.asset('assets/images/greegirl.png', width: 100.0),
          ),
        ],
      ),
    );
  }


  Widget buildScrollableEmotionSentences(String emotion) {
    // 특정 감정에 대한 모든 문장을 스크롤 가능한 텍스트로 표시하는 메서드 구현
    String allSentences = emotion_sentences[emotion]!.join('\n\n');
    return Container(
      height: 200,
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