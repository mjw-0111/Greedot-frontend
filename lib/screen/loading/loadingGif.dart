import 'dart:async';
import 'package:flutter/material.dart';

class LoadingGifWidget extends StatefulWidget {
  @override
  _LoadingGifWidgetState createState() => _LoadingGifWidgetState();
}

class _LoadingGifWidgetState extends State<LoadingGifWidget> {
  List<String> gifPaths = [
    'assets/images/loading_gif/gif1.gif',
    'assets/images/loading_gif/gif2.gif',
    // 여기에 나머지 GIF 경로들을 추가
  ];
  int currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % gifPaths.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(gifPaths[currentIndex]);
  }
}
