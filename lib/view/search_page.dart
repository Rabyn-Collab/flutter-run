import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../providers/search_video_provider.dart';
import 'detail_page.dart';




class SearchPage extends StatelessWidget {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ref, child) {
          final movieState = ref.watch(searchProvider);
          return SafeArea(
            child: Scaffold(
                body: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: textController,
                        onFieldSubmitted: (val){
                          if(val.isEmpty){

                          }else{
                            ref.read(searchProvider.notifier).getData(searchText: val);
                            textController.clear();
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Search Movies',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                        ),
                      ),
                      Expanded(
                          child: movieState.isLoad ? Center(child: CircularProgressIndicator())
                              : movieState.err.isEmpty ? GridView.builder(
                              itemCount: movieState.movies.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 2/3,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5
                              ),
                              itemBuilder: (context, index){
                                final movie = movieState.movies[index];
                                return InkWell(
                                  onTap: (){
                                    Get.to(() =>DetailPage(movie), transition: Transition.leftToRight);
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                          errorWidget: (c,s,d){
                                            return Image.asset('assets/movie.png');
                                          },
                                          placeholder: (context, string){
                                            return Center(
                                                child: SpinKitFadingCube(
                                                  color: Colors.pinkAccent,
                                                  size: 30,
                                                )
                                            );
                                          },
                                          imageUrl: movie.poster_path
                                      )
                                  ),
                                );
                              }
                          )  : Text(movieState.err)
                      )
                    ],
                  ),
                )
            ),
          );
        }
    );
  }
}
