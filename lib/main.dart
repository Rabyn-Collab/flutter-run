import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterrun/providers/example_providers.dart';
import 'package:flutterrun/view/home_page.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
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
      home: HomePage(),
    );
  }
}

class Counter extends StatelessWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
        body: Container(
          child:  Consumer(
            builder: (context, ref, child) {
             // final number = ref.watch(sampleProvider).number;
            //  final number = ref.watch(changeProvider).number;
              final number = ref.watch(stateProvider);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$number', style: TextStyle(fontSize: 40),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                           // ref.read(sampleProvider).increment();
                          //  ref.read(changeProvider).increment();
                            ref.read(stateProvider.notifier).state++;
                          }, child: Text('Incre')),
                      TextButton(
                          onPressed: () {
                            //ref.read(sampleProvider).decrement();
                           // ref.read(changeProvider).decrement();
                            ref.read(stateProvider.notifier).state--;
                          }, child: Text('Decre')),
                    ],
                  )
                ],
              );
            }
          ),
        )
    );
  }
}


