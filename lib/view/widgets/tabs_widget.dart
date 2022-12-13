import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterrun/models/movie_state.dart';
import 'package:flutterrun/providers/movie_provider.dart';



class TabsWidget extends StatelessWidget {
final  ProviderListenable<MovieState> provider;
TabsWidget(this.provider);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Consumer(
          builder: (context, ref, child) {
            final movieState = ref.watch(provider);
            if(movieState.isLoad){
              return Center(child: CircularProgressIndicator());
            }else if(movieState.err.isNotEmpty){
              return Center(child: Text(movieState.err));
            }else{
              return GridView.builder(
                itemCount: movieState.movies.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    childAspectRatio: 2/3,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5
                  ),
                  itemBuilder: (context, index){
                  final movie = movieState.movies[index];
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(movie.poster_path));
                  }
              );
            }
          }

      ),
    );
  }
}
