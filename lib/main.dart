import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterrun/view/home_page.dart';
import 'package:flutterrun/view/sample.dart';
import 'package:get/get.dart';



void main() {
  runApp(Home());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(

    )
  );
}



class Home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // themeMode: ThemeMode.light,
      // theme: ThemeData.light().copyWith(
      //  buttonTheme: ButtonThemeData().copyWith(
      //    buttonColor: Colors.black
      //  ),
      // ),
      home: HomePage(),

    );
  }
}
