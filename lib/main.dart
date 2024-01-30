import 'package:flutter/material.dart';
import 'package:projectfront/provider/pageNavi.dart';
import 'package:provider/provider.dart';

import 'screen/loading/startApp.dart';

void main() => runApp(NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => PageNavi()) // 여기에 다른 Provider들을 추가할 수 있습니다.
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: SplashScreen(),
      ),
    );
  }
}
