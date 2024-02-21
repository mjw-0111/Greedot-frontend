import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../widget/design/settingColor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../service/gree_service.dart';

import '../../widget/design/sharedController.dart';
import '../../provider/pageNavi.dart';
import '../../service/user_service.dart';
import 'package:provider/provider.dart';
import 'package:projectfront/widget/design/basicButtons.dart';
import '../../models/user_model.dart';

class ReportPage extends StatefulWidget {
  final int? greeId;
  const ReportPage({Key? key, this.greeId}) : super(key: key);
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  int touchedIndex = -1;
  Map<String, List<String>> emotions = {}; // 초기 상태는 비어있음
  Map<String, String> urls = {};


  @override
  void initState() {
    super.initState();
    fetchEmotionData();
  }

  Future<void> fetchEmotionData() async {
    try {
      if (widget.greeId == null) {
        throw Exception('% greeId is null');
      }

      List<String> sentences = await ApiServiceGree.fetchSentences(widget.greeId!);
      if (sentences.isEmpty) {
        throw Exception('% No sentences returned');
      }

      var report = await ApiServiceGree.makeEmotionReport(sentences, widget.greeId!);
      if (report == null) {
        throw Exception('% Report generation failed');
      }

      setState(() {
        emotions = report['emotions'].map((emotion, sentences) =>
            MapEntry(emotion, List<String>.from(sentences))).cast<String, List<String>>();
        urls = report['urls'].cast<String, String>();
      });
    } catch (e) {
      print('% Error fetching emotion data: $e');
    }
  }

  final Map<String, Color> emotionColor = {
    '기쁨': Colors.blue[400]!,
    '당황': Colors.orange[400]!,
    '분노': Colors.red[400]!,
    '불안': Colors.teal[400]!,
    '상처': Colors.purple[400]!,
    '슬픔': Colors.green[400]!,
  };

  Widget buildLegend() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: emotionColor.keys.map((emotion) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: <Widget>[
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: emotionColor[emotion],
                ),
              ),
              SizedBox(width: 2),
              Text(emotion),
            ],
          ),
        );
      }).toList(),
    );
  }

  List<PieChartSectionData> showingSections() {
    int totalSentences = emotions.values.fold(0, (previous, element) => previous + element.length);
    if (totalSentences == 0) {
      // 데이터가 없을 때 기본 섹션 데이터를 반환
      return [PieChartSectionData(
        color: Colors.grey,
        value: 100,
        title: '데이터 없음',
        radius: 30,
        titleStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
      )];
    }

    List<PieChartSectionData> sections = [];
    emotions.forEach((key, sentences) {
      final bool isTouched = emotions.keys.toList().indexOf(key) == touchedIndex;
      final double fontSize = isTouched ? 16 : 14;
      final double radius = isTouched ? 40 : 30;
      final double percentage = sentences.length / totalSentences * 100;

      if (percentage > 0) {
        String titleText = isTouched ? '$key\n${percentage.toStringAsFixed(1)}%' : key;
        sections.add(PieChartSectionData(
          color: emotionColor[key],
          value: percentage,
          title: titleText,
          radius: radius,
          titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
        ));
      }
    });

    return sections;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          touchedIndex = -1;
        });
      },
      child: Scaffold(
        backgroundColor: colorMainBG_greedot,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text('< 차트를 클릭하면 대화 로그가 보여요! >'),
                ),
              ),
              Positioned(
                top: 20,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height / 2,
                child: buildChartAndImageRow(),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 35,
                left: 0,
                right: 0,
                child: buildLegend(),
              ),
              if (touchedIndex != -1)
                Positioned(
                  bottom: 25,
                  left: 10,
                  right: 10,
                  height: 200,
                  child: buildScrollableEmotionSentences(emotions.keys.elementAt(touchedIndex)),
                ),
            ],
          ),
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
                    touchCallback: (event, pieTouchResponse) {
                      if (event is FlTapUpEvent && pieTouchResponse != null && pieTouchResponse.touchedSection != null) {
                        int currentIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                        setState(() {
                          touchedIndex = currentIndex;
                        });
                      }
                    },
                  ),
                  sections: showingSections(),
                )
            ),
          ),
          if (touchedIndex != -1 && urls.isNotEmpty)
            Expanded(
              child: Image.network(
                urls[emotions.keys.elementAt(touchedIndex)] ?? '',
                width: 70.0,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/greegirl_3.png', width: 70.0);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget buildScrollableEmotionSentences(String emotion) {
    List<String>? sentencesList = emotions[emotion];
    String allSentences = sentencesList != null ? sentencesList.join('\n\n') : 'No sentences found for this emotion.';
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
          style: TextStyle(fontSize: 11.0),
        ),
      ),
    );
  }
}
