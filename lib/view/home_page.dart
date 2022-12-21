import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return Scaffold(
        body: Container()
    );
  }
}
