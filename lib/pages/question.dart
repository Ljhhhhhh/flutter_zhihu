import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cli/model/answer.dart';
import 'package:flutter_cli/model/question-answer.dart';
import 'package:flutter_cli/utils/request.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionPage extends StatefulWidget {
  final String questionId;
  QuestionPage(this.questionId);
  @override
  _QuestionPageState createState() => _QuestionPageState(this.questionId);
}

class _QuestionPageState extends State<QuestionPage> {
  final String questionId;
  _QuestionPageState(this.questionId);
  QAResult questionDetail;
  List<AnswerModel> answerList;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getQuestion(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(
                title: Text(questionDetail.title),
              ),
              body: SingleChildScrollView(
                child:  Container(
                  child: Column(
                    children: <Widget>[
                      _questionHead(),
                      _answerList()
                    ],
                  ),
              )));
        } else {
          return Center(child: Text('加载中……'));
        }
      },
    );
  }

  Future _getQuestion() async {
    await HTTP.getInstance().get('questions/' + this.questionId, null, (res) {
      QAModel data = QAModel.fromJson(res);
      setState(() {
        questionDetail = data.result;
      });
    }, () {});
    return '完成加载';
  }

  Future _getAnswers() async {
    print('get answers');
    return await HTTP.getInstance().get('questions/' + this.questionId + '/answers', null, (res) {
      AnswerResModel answerRes = AnswerResModel.fromJson(res);
      List<AnswerModel> answer = answerRes.result;
      print(answer[0].content);
      answerList = answer;
    }, () {});
    
  }

  Widget _questionHead() {
    return Container(
        padding: EdgeInsets.all(15),
        width: ScreenUtil().setWidth(750),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12)
          )
        ),
        child: Column(
          children: <Widget>[
            _questionHeadTopics(questionDetail.topics),
            _questionHeadTitle(questionDetail.title),
            _questionHeadDesc(questionDetail.description),
            _questionHeadInfo(questionDetail.questioner),
            _questionHeadControl()
          ],
        ),
      );
  }

  Widget _questionHeadTopics(List<Topics> topics) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(60),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: topics.length,
          itemBuilder: (context, index) {
            return Container(
              height: ScreenUtil().setHeight(32),
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.black12,
                  ),
                child: Text(topics[index].name,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(28),
                      color: Colors.black54,
                      height: 60 / 28
                    ))
                    );
          }),
    );
  }

  Widget _questionHeadTitle(String title) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.centerLeft,
      // padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(title, style: TextStyle(
        fontSize: ScreenUtil().setSp(36)
      )),
    );
  }

  Widget _questionHeadDesc(String desc) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerLeft,
      // padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(desc, style: TextStyle(
        fontSize: ScreenUtil().setSp(28)
      )),
    );
  }

  Widget _questionHeadInfo(Questioner questioner) {
    return Container(
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('提问者：', style: TextStyle(
                color: Colors.black45
              )),
              Text(questioner.name, style: TextStyle(
                color: Colors.black
              ))
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Text('·'),
          ),
          Row(
            children: <Widget>[
              Text('回答：', style: TextStyle(
                color: Colors.black45
              )),
              Text('65', style: TextStyle(
                color: Colors.black
              ))
            ],
          )
        ],
      ),
    );
  }

  Widget _questionHeadControl() {
    return Container(
      height: ScreenUtil().setHeight(80),
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton(
            color: Colors.white,
            // shape: Border.all(width: 2.0),
            onPressed: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.edit),
                Text("写回答")
              ],
            ),
          ),
          RaisedButton(
            color: Colors.white,
            // shape: Border.all(width: 2.0),
            onPressed: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.star_border),
                Text("关注用户")
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _answerList() {
    return FutureBuilder(
      future: _getAnswers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // 请求失败，显示错误
            return Text("Error: ${snapshot.error}");
          } else {
            // 请求成功，显示数据
            return Text("Contents: ${snapshot.data}");
          }
        } else {
          // 请求未结束，显示loading
          return CircularProgressIndicator();
        }
      },
    );
  }
}

// class QuestionPage extends StatelessWidget {
//   final String questionId;
//   QuestionPage(this.questionId);
//   @override
//   Widget build(BuildContext context) {
//   _getQuestion(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('问题详情'),
//       ),
//       body: FutureBuilder(
//         future: _getQuestion(context),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return Center(
//               child: Text('124'),
//             );
//           } else {
//             return Center(child: Text('加载中……'));
//           }
//         },
//       ),
//     );
//   }

//   Future _getQuestion(context) {
//     // await HTTP.getInstance().get('questions/' + this.questionId, null, (res) {
//     //   QAModel data = QAModel.fromJson(res);
//     //   print(data.result.title);
//     //   return '加载完成';
//     //   // _question = data.result;
//     //   // notifyListeners();
//     // }, () {});
//     Provider.of<QAProvide>(context).setData(this.questionId);
//     // return '完成加载';
//   }
// }
