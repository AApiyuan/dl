import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';

import 'package:dio/dio.dart';

void main() {
  //一定要有MaterialApp，Scaffold
  runApp(new MaterialApp(
    title: "input",
    home: new Scaffold(

      body: LoginPage(),
    ),
  ));
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginPageState();
  }
}


class LoginPageState extends State<LoginPage> {
  ///账号
  String account = "";
  ///密码
  String password = "";
  static const String registerAccountLength = 'registerAccountLength';
  static const String registerAccountEmpty = 'registerAccountEmpty';
  final accoutController = TextEditingController();
  final passwordController = TextEditingController();
  loadDataByDio() async {
    String _result;
    try {
      print('登陆中');
      Response response;
      Dio dio = new Dio()
        ..options = BaseOptions(
            baseUrl: 'https://www.wanandroid.com/',
            connectTimeout: 10000,
            receiveTimeout: 1000 * 60 * 60 * 24,
            responseType: ResponseType.json,
            headers: {"Content-Type": "application/json"});
      response = await dio.get(
          'user/login');
      if (response.statusCode == 200) {
        _result = 'success';
        print(response.data);
      } else {
        _result = 'error code : ${response.statusCode}';
        print(_result);
      }
    } catch (exception) {
      print('exc:$exception');
    }
    setState(() {});
  }
  loadDataByDi() async {
    String _result;
    try {
      print('登陆中');
      Response response;
      Dio dio = new Dio()
        ..options = BaseOptions(
            baseUrl: "https://www.wanandroid.com/",
            connectTimeout: 10000,
            receiveTimeout: 1000 * 60 * 60 * 24,
            responseType: ResponseType.json,
            headers: {"Content-Type": "application/json"});
      response = await dio.get(
          'user/register');
      if (response.statusCode == 200) {
        _result = 'success';
        print(response.data);
      } else {
        _result = 'error code : ${response.statusCode}';
        print(_result);
      }
    } catch (exception) {
      print('exc:$exception');
    }
    setState(() {});
  }

  ///当前按钮是否可点击
  bool changeShowButton(){
    return account.isNotEmpty &&
        password.isNotEmpty;
  }

   checkLogin() {
    //定义当前按钮是否可点击
    var accout = accoutController.text.trim();
    var password = passwordController.text.trim();
    ///用户登录
    if (accout.isEmpty || password.isEmpty) {
      BotToast.showText(text: '用户名或者密码不能为空| ');
      BotToast.showSimpleNotification(title: '提示', subTitle: '用户名或者密码不能为空');
      return;
    }
    if (account.isEmpty || account.length < 6) {
      BotToast.showText(text: '用户名或者密码不能小于6位 ');
      BotToast.showSimpleNotification(title: '提示', subTitle: '用户名或者密码不能小于6位');
      return;
    }

    ///密码：>6位
    if (password.isEmpty || password.length < 6) {
      BotToast.showText(text: '用户名或者密码不能小于6位 ');
      BotToast.showSimpleNotification(title: '提示', subTitle: '用户名或者密码不能小于6位');
      return;
    }
      //页面跳转
      //Get.offAllNamed(Routes.homePage);


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),

      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly, //只允许输入数字
                LengthLimitingTextInputFormatter(11)
              ],
              controller: accoutController,
              decoration: const InputDecoration(
                hintText: '请输入用户名',
                //helperText: '请输入用户名'--在横线下面
              ),
            ),

            TextField(
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly, //只允许输入数字
                LengthLimitingTextInputFormatter(11)
              ],
              //只允许输入字母 //
              controller: passwordController,
              decoration: const InputDecoration(
                  hintText: '请输入密码'
              ),
            ),
            const SizedBox(height: 10),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  ElevatedButton(
                      onPressed: (){
                        if (
                        checkLogin()) {
                          loadDataByDio();
                        }
                      },
                      child: const Text('登录')),
                  ElevatedButton(
                      onPressed: (){
                        if (
                        checkLogin()) {
                          loadDataByDi();
                        }
                      },
                      child: const Text('注册'))
                ],

            ),

          ],
        ),
      ),


    );
  }
}