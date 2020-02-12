import 'package:flutter/material.dart';
import 'package:flutter_cli/model/question.dart';
import 'package:flutter_cli/provide/question-list.dart';
import 'package:flutter_cli/routers/application.dart';
import 'package:flutter_cli/utils/request.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _getMoreList(1);
  }

  EasyRefreshController _controller = EasyRefreshController();
  Widget build(BuildContext context) {
    final scrollController = new ScrollController();
    final list = Provider.of<QuestionProvide>(context).question;
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: Container(
        width: ScreenUtil().setWidth(750),
        child: EasyRefresh(
          controller: _controller,
          // enableControlFinishLoad: true,
          footer: ClassicalFooter(
              loadedText: '加载完成',
              loadReadyText: '释放加载',
              loadingText: '正在加载...',
              loadFailedText: '加载失败',
              noMoreText: '没有更多',
              infoText: '更新于 %T'
              // bgColor: Colors.white,
              // textColor: Colors.blue,
              // loadingText: '加载中',
              // noMoreText: Provider.of<QuestionProvide>(context).noMoreText,
              // infoText: Provider.of<QuestionProvide>(context).noMoreText == '' ? '加载中……' : null,
              // loadReadyText: '上拉加载'
              ),
          child: ListView.builder(
            controller: scrollController,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return _listItem(list, index);
            },
          ),
          // onRefresh: () async {
          //   _getMoreList();
          // },
          onLoad: () async {
            print('onLoad');
            final questionProvide = Provider.of<QuestionProvide>(context);
            int total = questionProvide.total;
            // print(questionProvide.question.length);
            print(total);
            if (questionProvide.question.length >= total) {
              print('没有更多了');
              questionProvide.changeNoMore('没有更多了');
              _controller.finishLoad(success: true, noMore: true);
              return;
            }
            questionProvide.addPage();
            int page = questionProvide.page;
            _getMoreList(page);
          },
        ),
      ),
    );
  }

  void _getMoreList(page) async {
    print('get question');
    var params = {'page': page};
    await HTTP.getInstance().get('questions', params, (res) {
      // _controller.callLoad()
      final questionProvide = Provider.of<QuestionProvide>(context);
      QuestionModel data = QuestionModel.fromJson(res);
      questionProvide.addQuestion(data.result);
      // _controller.finishLoad();
    }, () {});
  }

  Widget _listItem(List list, int index) {
    final QuestionItem item = list[index];
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, '/question?id=' + item.sId);
      },
        child: Container(
      height: ScreenUtil().setHeight(285),
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          border:
              new Border.all(color: Color(0xFFF3F4F6), width: 0.5), // 边色与边宽度
          color: Color(0xFFFFFFFF),
          boxShadow: [
            BoxShadow(
                color: Color(0xFFAAAAAA),
                offset: Offset(5.0, 5.0),
                blurRadius: 10.0,
                spreadRadius: 2.0),
            BoxShadow(color: Color(0xFFAAAAAA), offset: Offset(1.0, 1.0)),
            BoxShadow(color: Color(0xFFAAAAAA))
          ]),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(80),
            alignment: Alignment.center,
            child: Text((index + 1).toString()),
          ),
          Column(
              mainAxisAlignment:
                  item.description != null && item.description.isNotEmpty
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.center,
              // main MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(600),
                  child: Text(
                    item.title,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                _itemDesc(item.description)
              ])
        ],
      ),
    ));
  }

  Widget _itemDesc(String description) {
    if (description != '' || description.isNotEmpty) {
      return Container(
          width: ScreenUtil().setWidth(600),
          child: Text(
            description ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ));
    } else {
      return null;
    }
  }
}
