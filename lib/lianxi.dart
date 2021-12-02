import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';

class ListViewPulltoRefresh1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('ListViewPulltoRefresh'),
      ),
      body: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  List<String> items = ["1", "2", "3", "4", "5"];
//  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController Controller2 = RefreshController(initialRefresh: true);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    Controller2.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length + 1).toString());
    if (mounted)
      setState(() {

      });
    Controller2.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: () async {
          await new Future.delayed(const Duration(milliseconds: 2000)); // 等待异步操作
            // 设置状态为完成
          setState(() {});                                              // 更新界面
        },


         header: ClassicHeader(
            height: 45.0,
            releaseText: '松开手刷新',
            refreshingText: '刷新中',
            completeText: '刷新完成',
            failedText: '刷新失败',
            idleText: '下拉刷新',
          ),

        controller: this.Controller2,   // 控制器
        child: new ListView.builder(
          itemCount: 1000,

          itemBuilder: (BuildContext context, int index) {
            return new Container(
              padding: const EdgeInsets.all(8.0),
              child: new Text('今天吃什么？ $index'),
            );
          },
        ),
      ),
    );
  }

  // 不要忘记处理refreshController
  @override
  void dispose() {
    // TODO: implement dispose
    Controller2.dispose();
    super.dispose();
  }
}

