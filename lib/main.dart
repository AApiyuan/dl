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

  final accoutController = TextEditingController();
  final passwordController = TextEditingController();
  loadDataByDio() async {
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
          "/wxarticle/chapters/json");
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
  bool checkLogin() {
    var accout = accoutController.text.trim();
    var password = passwordController.text.trim();
    if (accout.isEmpty || password.isEmpty) {
      //BotToast.showText(text: '用户名或者密码不能为空| ');
      //BotToast.showSimpleNotification(title: '提示', subTitle: '用户名或者密码不能为空');
      return false;
    }
    return true;
    //界面跳转
    // Get.toNamed(Routes.home);
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
            ElevatedButton(
                onPressed: (){
                  if (
                  checkLogin()) {
                    loadDataByDio();
                  }
                },
                child: const Text('登录'))
          ],
        ),
      ),


    );
  }
}