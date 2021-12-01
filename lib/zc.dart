import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'lb.dart';
class LoginPage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPage2State();
  }
}


class LoginPage2State extends State<LoginPage2> {
  final accoutController = TextEditingController();
  final passwordController = TextEditingController();
  final password1Controller = TextEditingController();
  String account1 = "";
  ///密码
  String password1 = "";
  String password2 = "";
 bool? check = false;
 bool? checkboxSelected = false;
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
 checkLogin1(){
   var accout1 = accoutController.text.trim();
   var password1 = passwordController.text.trim();
   var password2 = passwordController.text.trim();
   if(accout1.length<11){
     toast("请输入11位账号");
     return false;
   }
   if(password1.length<11){
     toast("请输入11位密码");
     return false;
   }
   Navigator.push(context,new MaterialPageRoute(builder: (context) => new  ListViewWidget()));
 }
  loadDataByDio1() async {
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
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(


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
              //只允许输入字母 //
              controller: passwordController,
              decoration: const InputDecoration(
                  hintText: '请输入密码'
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
              //只允许输入字母 //
              controller: password1Controller,
              decoration: const InputDecoration(
                  hintText: '请再次输入密码'
              ),
            ),
            const SizedBox(height: 10),
            new  Row(
              children: [
             Checkbox(
                    value: check,
                    onChanged: (value){
                      if(value==true){
                        checkboxSelected=false;
                      }
                      check = value;
                      setState((){
                      });
                    }),
                Text('已阅读并同意服务条款'),
              ],
            ),

            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                 //if(account1.isEmpty||password1.isEmpty ){toast("请输入账号密码");} else
                   if(checkLogin1()){
                   loadDataByDio1();

                 }

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