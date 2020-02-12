import 'package:flutter/material.dart';

class UserinfoProvide with ChangeNotifier { 
  int _userinfo = 0;
  int get userinfo => _userinfo;

  changeIndex(int newIndex) {
    _userinfo = newIndex;
    notifyListeners();
  }
}