import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterrun/view/home_page.dart';
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
      home:  HomePage(),
    );
  }
}




