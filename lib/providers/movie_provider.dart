import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterrun/api.dart';
import 'package:flutterrun/services/movie_service.dart';
import '../models/movie_state.dart';


final popularProvider = StateNotifierProvider<PopularProvider, MovieState>((ref) => PopularProvider(MovieState(
    err: '',
    isLoad: false,
    movies: [],
  apiPath: Api.popularMovie,
  page: 1
)));


class PopularProvider extends StateNotifier<MovieState>{
  PopularProvider(super.state){
   getData();
  }

  Future<void> getData() async{
    state = state.copyWith(movieState: state, isLoad: true);
      final response = await MovieService.getMovieByCategory(apiPath: state.apiPath, page: state.page);
      response.fold(
              (l){
                state = state.copyWith(movieState: state, err: l, isLoad: false);
              },
              (r){
                state = state.copyWith(movieState: state, err: '', isLoad: false, movies: r);
              }
      );

  }

}