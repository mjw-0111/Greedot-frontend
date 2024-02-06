import 'dart:async';
import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechSampleApp extends StatefulWidget {
  const SpeechSampleApp({Key? key}) : super(key: key);

  @override
  State<SpeechSampleApp> createState() => _SpeechSampleAppState();
}
class _SpeechSampleAppState extends State<SpeechSampleApp> {
  final SpeechToText speechToText = SpeechToText();
  var text = "Hold the button and speak";
  var isListening = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(text),
            SizedBox(height: 100),
            AvatarGlow(
              animate: isListening,
              duration: const Duration(milliseconds: 2000),
              repeat: true,
              glowColor: Colors.black,
              child: IconButton(
                onPressed: () async {
                  setState(() {
                    isListening = !isListening;
                  });
                  if (isListening) {
                    var available = await speechToText.initialize(
                      onError: (val) => print('Error: $val'),
                      onStatus: (val) => print('Status: $val'),
                    );
                    if (available) {
                      speechToText.listen(
                        onResult: (result) {
                          setState(() {
                            text = result.recognizedWords;
                          });
                        },
                        localeId: 'ko_KR', // 한국어 로케일 설정
                      );
                    } else {
                      print(
                          "The user has denied the use of speech recognition.");
                    }
                  } else {
                    speechToText.stop();
                  }
                },
                icon: Icon(isListening ? Icons.mic : Icons.mic_none,
                    color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}


// class _SpeechSampleAppState extends State<SpeechSampleApp> {

//   SpeechToText speechToText = SpeechToText();

//   var text = "hold the button and speak";
//   var isListening = false;

// @override
// Widget build(BuildContext context) {
//   return Center( // 전체를 Center 위젯으로 감싸서 가운데 정렬
//     child: Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center, // 세로 방향으로 중앙 정렬
//         crossAxisAlignment: CrossAxisAlignment.center, // 가로 방향으로 중앙 정렬
//         children: [
//           Text(text),
//           SizedBox(height: 100),
//           AvatarGlow(
//             animate: isListening,
//             duration: const Duration(milliseconds: 2000),
//             repeat: true,
//             glowColor: Colors.black,
//             child: IconButton(
//               onPressed: () async{
//                 setState(() {
//                 isListening = !isListening;
//                 });
//                 if(isListening){
//                  var avaliable = await speechToText.initialize();
//                   if(avaliable){
//                     print('성공');
//                     setState(() {
//                       speechToText.listen(
//                         onResult: ((result) {
//                           setState(() {
//                             text = result.recognizedWords;
//                           });
//                         })
//                       );
//                     });
//                     print(text);
//                   }
//                   else{
//                     print("2에 걸림");
//                   }
//                 }
//                 else{
//                   speechToText.stop();
//                   print('1에 걸림');
//                 }
//               },
//               icon: Icon(isListening ? Icons.mic : Icons.mic_none, color: Colors.black),
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }

// }