import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/movie_provider.dart';



class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Consumer(
              builder: (context, ref, child){
                final movieState = ref.watch(popularProvider);
                if(movieState.isLoad){
                  return Center(child: CircularProgressIndicator());
                }else if(movieState.err.isNotEmpty){
                  return Center(child: Text(movieState.err));
                }else{
                  return Center(child: Column(
                    children: [
                      Text(movieState.movies[1].poster_path),
                      Image.network('https://image.tmdb.org/t/p/w600_and_h900_bestv2'+movieState.movies[9].poster_path)
                    ],
                  ));
                }
              }),
        )
    );
  }
}
