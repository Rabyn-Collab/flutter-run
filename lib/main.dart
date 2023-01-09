import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterrun/view/home_page.dart';
import 'package:flutterrun/view/status_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';


void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(milliseconds: 500));
  await Hive.initFlutter();
  runApp(ProviderScope(child: Home(),));
}


class Home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 866),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return GetMaterialApp(
          theme: ThemeData(
            fontFamily: ''
          ),
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: StatusPage(),
    );
  }
}
