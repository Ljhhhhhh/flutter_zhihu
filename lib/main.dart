import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cli/pages/index.dart';
import 'package:flutter_cli/provide/currentIndex.dart';
import 'package:flutter_cli/provide/question-list.dart';
import 'package:flutter_cli/provide/question.dart';
import 'package:flutter_cli/routers/application.dart';
import 'package:flutter_cli/routers/routes.dart';
import 'package:provider/provider.dart';

void main() {
  
  final currentIndexProvide = CurrentIndexProvide();
  final questionProvide = QuestionProvide();
  final qaProvide = QAProvide();
  runApp(MultiProvider(
    providers: [
      Provider.value(value: 'lujiehui'),
      ChangeNotifierProvider.value(
        value: currentIndexProvide,
      ),
      ChangeNotifierProvider.value(
        value: questionProvide,
      ),
      ChangeNotifierProvider.value(
        value: qaProvide,
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
    return MaterialApp(
      title: '仿知乎',
      onGenerateRoute: Application.router.generator,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: IndexPage(),
    );
  }
}
