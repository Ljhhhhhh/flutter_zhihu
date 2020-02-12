import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cli/pages/question.dart';

Handler questionHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String questionId = params['id'].first;
    return QuestionPage(questionId);
  }
);