// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'dart:async';
//
// new SmartRefresher(
// enablePullDown: true,
// // enablePullUp: true,https://www.jianshu.com/p/e6dafb114855
// onRefresh: (bool up) async {
// await new Future.delayed(const Duration(milliseconds: 2000)); // 等待异步操作
// this.controller2.sendBack(true, RefreshStatus.completed);     // 设置状态为完成
// setState(() {});                                              // 更新界面
// },
// onOffsetChange: (bool up, double offset) {},
// headerBuilder: (context, mode) {
// return new ClassicIndicator(
// mode: mode,
// height: 45.0,
// releaseText: '松开手刷新',
// refreshingText: '刷新中',
// completeText: '刷新完成',
// failedText: '刷新失败',
// idleText: '下拉刷新',
// );
// },
// controller: this.controller2,   // 控制器
// child: new ListView.builder(
// itemCount: 1000,
// controller: this.controller,
// itemBuilder: (BuildContext context, int index) {
// return new Container(
// padding: const EdgeInsets.all(8.0),
// child: new Text('今天吃什么？ $index'),
// );
// },
// ),
// ),