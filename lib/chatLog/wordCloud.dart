// import 'package:flutter/material.dart';
// import 'package:word_cloud/word_cloud.dart';
// import '../../../widget/design/settingColor.dart';
//
// class SimpleWordCloud extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // 단어와 해당 빈도수를 나타내는 맵
//     final Map<String, double> words = {
//       "example": 5,
//       "word": 3,
//       "cloud": 4,
//       "flutter": 2,
//       // 추가 단어와 빈도수
//     };
//
//     // WordCloud 위젯을 포함하는 컨테이너 반환
//     return Container(
//       color: colorMainBG_greedot,
//       width: double.infinity, // 또는 특정 크기
//       height: 400, // 워드 클라우드에 할당할 높이
//       child: WordCloud(
//         words: words,
//         config: WordCloudConfig(
//           // 워드 클라우드의 시각적 및 배치 관련 설정
//           // 예: 폰트 크기, 색상, 회전 등
//         ),
//       ),
//     );
//   }
// }
