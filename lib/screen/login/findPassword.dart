// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../widget/design/settingColor.dart'; // Ensure these paths are correct
// import '../../widget/design/sharedController.dart'; // Ensure this path is correct
// import 'package:provider/provider.dart';
// import '../../provider/pageNavi.dart';
//
// class FindPassword extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width, // 전체 너비
//       height: MediaQuery.of(context).size.height, // 전체 높이
//       child: FindPasswordPage(),
//     );
//   }
// }
//
//
//
// class FindPasswordPage extends StatefulWidget {
//   @override
//   FindPasswordPageState createState() => FindPasswordPageState();
// }
//
// class FindPasswordPageState extends State<FindPasswordPage> {
//   TextEditingController confirmEmailController = TextEditingController();
//
//   void findPassword() {
//     if (confirmEmailController.text == emailController.text) {
//       OverlayEntry overlayEntry = OverlayEntry(
//         builder: (context) =>
//             Container(
//               width: MediaQuery
//                   .of(context)
//                   .size
//                   .width, // 전체 너비
//               height: MediaQuery
//                   .of(context)
//                   .size
//                   .height, // 전체 높이
//               color: Colors.orangeAccent.withOpacity(0.7), // 반투명 배경
//               child: Center(
//                 child: Container(
//                   width: 300,
//                   // 박스 너비
//                   height: 100,
//                   // 박스 높이
//                   alignment: Alignment.center,
//                   // 텍스트를 중앙에 위치시킵니다.
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10), // 박스의 모서리를 둥글게
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Flexible(
//                         child: Text(
//                           '비밀번호 : ${passwordController.text} ', // 예제 텍스트
//                           style: TextStyle(
//                               color: Colors.deepOrange, fontSize: 25),
//                           overflow: TextOverflow
//                               .ellipsis, // 텍스트가 박스를 넘어가면 말줄임표로 표시
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.copy),
//                         onPressed: () {
//                           Clipboard.setData(
//                               ClipboardData(text: passwordController
//                                   .text)); // 클립보드에 복사
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text('비밀번호가 클립보드에 복사되었습니다.'),
//                               backgroundColor: colorSnackBar_greedot,
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//       );
//       // Overlay에 추가
//       Overlay.of(context)?.insert(overlayEntry);
//
//       // 일정 시간 후 Overlay 제거
//       Future.delayed(Duration(seconds: 5), () {
//         overlayEntry.remove();
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('이메일이 일치하지 않습니다'),
//           backgroundColor: colorSnackBar_greedot,
//         ),
//       );
//     }
//   }
//
//   void _copyToClipboard(String text) {
//     Clipboard.setData(ClipboardData(text: text));
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Copied to clipboard'),
//         backgroundColor: colorSnackBar_greedot,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final pageNavi = Provider.of<PageNavi>(context, listen: false);
//
//     return Material(
//       child: Container(
//         color: colorMainBG_greedot,
//         child: Center( // Center 위젯을 사용하여 중앙 정렬
//           child: Container(
//             padding: EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min, // 최소 크기로 설정
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   '회원가입 시 사용한 이메일을 입력해주세요',
//                   style: TextStyle(color: colorSnackBar_greedot),
//                 ),
//                 SizedBox(height: 20),
//                 TextField(
//                   controller: confirmEmailController,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     prefixIcon: Icon(Icons.mail_outline),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(20)),
//                     ),
//                     filled: true,
//                     fillColor: colorFilling_greedot,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: findPassword,
//                   child: Text('비밀번호 찾기'),
//                   style: ElevatedButton.styleFrom(
//                     primary: colorBut_greedot,
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                     textStyle: TextStyle(fontSize: 18),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 TextButton(
//                   onPressed: () {
//                     pageNavi.changePage('LogIn');
//                   },
//                   child: Text(
//                     '로그인 화면 돌아가기',
//                     style: TextStyle(color: colorSnackBar_greedot),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
// // This function is a helper to show SnackBars, if you need to use it elsewhere
//   void showSnackBar(BuildContext context, Text content) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: content,
//         backgroundColor: colorSnackBar_greedot, // Use your SnackBar background color here
//       ),
//     );
//   }
// }
