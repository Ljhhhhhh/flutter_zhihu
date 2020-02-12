import 'package:flutter/material.dart';
import 'package:flutter_cli/model/question-answer.dart';
import 'package:flutter_cli/utils/request.dart';
// import 'package:provider/provider.dart';

class QAProvide with ChangeNotifier {
  QAResult _question = null;
  QAResult get question => _question;

  setData(String id) {
    HTTP.getInstance().get('questions/' + id, null, (res) {
      QAModel data = QAModel.fromJson(res);
      print(data.result.title);
      _question = data.result;
      notifyListeners();
    }, null);
    // notifyListeners();
  }
}