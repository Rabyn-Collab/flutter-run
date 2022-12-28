import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterrun/view/status_page.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';




void main() async{
  await Future.delayed(Duration(milliseconds: 500));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(ProviderScope(
      child: Home()
  )
  );
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
      home: StatusPage(),
    );
  }
}



class Counter extends StatelessWidget {

  StreamController<int> numbers = StreamController();
 int numSome =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<Object>(
          stream: numbers.stream,
          builder: (context, snapshot) {
            final number = snapshot.data;
            print(snapshot.data);
            return Center(
                child: Text('$number', style: TextStyle(fontSize: 20),)
            );
          }
        ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
           numbers.sink.add(numSome++);
          },
        child: Icon(Icons.add),
      ),
    );
  }
}

