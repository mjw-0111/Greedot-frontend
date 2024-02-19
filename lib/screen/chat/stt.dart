import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:projectfront/widget/design/settingColor.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../service/user_service.dart';
import '../../widget/design/settingColor.dart';

import '../../provider/pageNavi.dart';

class ChatMessage {
  String messageContent;
  bool isUser; // True if this is a user message, false if it's a response

  ChatMessage({required this.messageContent, required this.isUser});
}

class ChatPage extends StatefulWidget {
  final int? greeId;
  const ChatPage({Key? key, this.greeId}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}
class _ChatPageState extends State<ChatPage> {
  final SpeechToText speechToText = SpeechToText();
  var text = "Hold the button and speak";
  var isListening = false;
  List<ChatMessage> messages = [];

  void _onSpeechResult(String newText) {
    if (isListening) { // isListening이 true일 때만 결과를 처리합니다.
      setState(() {
        isListening = false; // 음성 인식을 중지합니다.
        speechToText.stop(); // SpeechToText 인스턴스에도 인식을 중지하도록 합니다.
        messages.add(ChatMessage(messageContent: newText, isUser: true));
      });
      _sendMessage(newText);
    }
  }

  void _startListening() async {
    var available = await speechToText.initialize(
      onError: (val) => print('Error: $val'),
      onStatus: (val) => print('Status: $val'),
    );
    if (available) {
      setState(() => isListening = true);
      speechToText.listen(
        onResult: (result) {
          if (result.finalResult) { // 최종 결과가 나왔을 때만 처리합니다.
            _onSpeechResult(result.recognizedWords);
          }
        },
        listenFor: Duration(seconds: 15), // 사용자가 말할 수 있는 최대 시간을 늘립니다.
        pauseFor: Duration(milliseconds: 1500), // 사용자가 말을 멈춘 후 인식을 중지할 시간을 설정합니다.
        localeId: 'ko_KR',
      );
    } else {
      setState(() => isListening = false);
      print("The user has denied the use of speech recognition.");
    }
  }

  void _sendMessage(String message) async {
    print('Sending message with greeId: ${widget.greeId}');

    if (widget.greeId != null) {
      try {
        var response = await ApiService.GetChatBotMessage(widget.greeId!, message);
        print('Response received: ${response.body}'); // 응답 로그 출력

        if (response.statusCode == 200) {
          final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
          final gptTalkContent = decodedResponse['chat_response']['gpt_talk']['content'];

          setState(() {
            messages.add(ChatMessage(
                messageContent: gptTalkContent, isUser: false));
          });
        } else {
          // 서버 응답에 문제가 있을 때의 처리
          print('The request failed with status: ${response.statusCode}');
        }
      } catch (e) {
        print('An error occurred while sending the message: $e');
        setState(() {
          messages.add(ChatMessage(messageContent: "Error: $e", isUser: false));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(30.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[messages.length - 1 - index]; // 메시지 리스트를 역순으로 렌더링
                return Align(
                  alignment: message.isUser ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: message.isUser ? colorBut_greedot : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      message.messageContent,
                      style: TextStyle(color: message.isUser ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height:50),
          AvatarGlow(
            animate: isListening,
            duration: const Duration(milliseconds: 2000),
            repeat: true,
            glowColor: Colors.grey,
            //endRadius: 75.0,
            child: FloatingActionButton(
              backgroundColor: colorBut_greedot,
              onPressed: () {
                if (isListening) {
                  speechToText.stop();
                  setState(() => isListening = false);
                } else {
                  _startListening();
                }
              },
              child: Icon(isListening ? Icons.mic : Icons.mic_none, color: Colors.white),
            ),
          ),
          SizedBox(height:50),
        ],
      ),
    );
  }
}



  /*@override
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
                          _onSpeechResult(result.recognizedWords);
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
}*/


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
