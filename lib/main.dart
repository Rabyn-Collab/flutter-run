import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterrun/models/movie_state.dart';
import 'package:flutterrun/providers/example_providers.dart';
import 'package:flutterrun/services/movie_service.dart';
import 'package:flutterrun/view/home_page.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api.dart';


Future<String> delaySome() async{
 return Future.delayed(Duration(seconds: 5), (){
   return 'hello world';
  });
}


// MovieState newState = MovieState(err: '', isLoad: false, movies: []);
//
// void m(){
//  newState =  newState.copyWith( err: 'hello', movieState: newState);
// }

void main() async{
  await Future.delayed(Duration(milliseconds: 500));
  // print(newState.err);
  // m();
  // print(newState.isLoad);
 //  print('hello world');
 // final m = await delaySome();
 // print(m);


   // final response = await MovieService.getMovieByCategory(apiPath: Api.popularMovie, page: 1);
   //   response.fold((l) => print(l), (r) => print(r));
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
     theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home:  HomePage(),
    );
  }
}










class Counter extends StatelessWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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


