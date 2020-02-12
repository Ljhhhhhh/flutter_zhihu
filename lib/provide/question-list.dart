import 'package:flutter/material.dart';
import 'package:flutter_cli/model/question.dart';

class QuestionProvide with ChangeNotifier {
  int _page = 1;
  int get page => _page;
  List<QuestionItem> _question = [];
  List<QuestionItem> get question => _question;
  int _total = 0;
  int get total => _total;
  String _noMoreText = '';
  String get noMoreText => _noMoreText;

  addQuestion(QuestionResult result) {
    _question.addAll(result.records);
    _total = result.total;
    notifyListeners();
  }

  addPage() {
    ++_page;
    notifyListeners();
  }

  changeNoMore(String text) {
    _noMoreText = text;
    notifyListeners();
  }
}