import 'package:flutter/material.dart';



class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.cyanAccent,
      backgroundColor: Color(0xFFF2F5F9),
      // backgroundColor: Colors.cyan[500],
      // backgroundColor: Color.fromRGBO(20, 50, 100, 0.9),
        appBar: AppBar(
          backgroundColor: Color(0xFFF2F5F9),
          elevation: 0,
          title: Text('Hi John,', style: TextStyle(color: Colors.black),),
          actions: [

          ],
        ),
        body: Container()
    );
  }
}
