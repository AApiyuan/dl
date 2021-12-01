import 'dart:convert';
import 'lb.dart';
import 'zc.dart';
import 'keyboard.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';

void main() {
  //一定要有MaterialApp，Scaffold
  runApp(MaterialApp(
    title: "input",
    home: Scaffold(

      body: LoginPage(),
    ),
  ));
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
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
  String account = "";
  ///密码
  String password = "";

  late bool ButtonDisabled;
  ///当前按钮是否可点击

  checkLogin() {
    var accout = accoutController.text.trim();
    var password = passwordController.text.trim();
    if (accout.length<11) {
      //print("密码为空");
      toast("请输入11位账号");
      return false;
    }
    if (password.length<6) {
      //print("密码为空");
      toast("请输入6位密码");
      return false;
    }
    //if()
    Navigator.push(context,new MaterialPageRoute(builder: (context) => new  ListViewWidget()));
    return true;
    //界面跳转

    // Get.toNamed(Routes.home);
  }

  toast(String msg) {
    var entry = OverlayEntry(
        builder: (BuildContext context) => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              child: Row(
                children: [Container(child: Text(msg, style: const TextStyle(fontSize: 16, color: Colors.black),), color: Colors.black12,)],
              ),
              bottom: 100,
            )
          ],
        ));
    Overlay.of(context)?.insert(entry);
    Future.delayed(const Duration(milliseconds: 1500))
        .whenComplete(() => entry.remove());
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
              // obscureText: true,
// 是否自动对焦
              autofocus: false,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly, //只允许输入数字
                LengthLimitingTextInputFormatter(11)
              ],
              onChanged: (text) => setState(() {
            account = text;
              }),
              controller: accoutController,
              decoration: const InputDecoration(
                hintText: '请输入用户名',
                //helperText: '请输入用户名'--在横线下面
              ),
            ),

            TextField(
              // obscureText: true,
// 是否自动对焦
              autofocus: false,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly, //只允许输入数字
                LengthLimitingTextInputFormatter(11)
              ],
              onChanged: (text) => setState(() {
                password = text;
              }),
              //只允许输入字母 //
              controller: passwordController,
              decoration: const InputDecoration(
                  hintText: '请输入密码'
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 50,
              //阻断,直接不让点击
              child: AbsorbPointer(
                child: ElevatedButton(
                  onPressed: (){
                    //②不用AbsorbPointer
                   // if(account.isEmpty || password.isEmpty){} else
                      if(checkLogin()){
                      KeyboardUtils.hideKeyboard(context);
                      loadDataByDio();
                    }

                  },
                  child: const Text('登录'),

                ),
                //①账号密码为空的时候不可以点击  absorbing
                absorbing: account.isEmpty || password.isEmpty,
              ),

              decoration: BoxDecoration(

                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 50,
                child: ElevatedButton(
                  onPressed: (){

                      Navigator.push(context,
                          new MaterialPageRoute(
                          builder: (context) => new LoginPage2()));
                  },
                  child: const Text('注册'),

                ),

              decoration: BoxDecoration(

                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
            ),
          ],
        ),
      ),


    );
  }
}
