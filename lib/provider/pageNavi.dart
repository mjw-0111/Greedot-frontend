import 'package:flutter/material.dart';

class PageNavi with ChangeNotifier {
  String _currentPageKey = "RootScreen";
  String get currentPageKey => _currentPageKey;

  void changePage(String pageKey) {
    _currentPageKey = pageKey;
    notifyListeners();
  }
}
