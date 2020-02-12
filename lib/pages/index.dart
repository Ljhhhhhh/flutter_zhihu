import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cli/pages/about.dart';
import 'package:flutter_cli/pages/home.dart';
import 'package:flutter_cli/provide/currentIndex.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    final List<BottomNavigationBarItem> bottomTabs = [
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home), title: Text('首页')),
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search), title: Text('关于')),
    ];

    final List<Widget> tabBodies = [
      HomePage(),
      AboutPage()
    ];
    CurrentIndexProvide currentIndexProvide = Provider.of<CurrentIndexProvide>(context);

    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndexProvide.currentIndex,
        items: bottomTabs,
        onTap: (index) {
          currentIndexProvide.changeIndex(index);
        },
      ),
      body: Center(
        child: IndexedStack(
          index: currentIndexProvide.currentIndex,
          children: tabBodies,
        ),
      ),
    );
  }
}
