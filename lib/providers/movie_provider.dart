import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterrun/api.dart';
import 'package:flutterrun/services/movie_service.dart';
import '../models/movie_state.dart';


final popularProvider = StateNotifierProvider<PopularProvider, MovieState>((ref) => PopularProvider(MovieState(
    err: '',
    isLoad: false,
    movies: [],
  apiPath: Api.popularMovie,
  page: 1,
  isLoadMore: false
)));


class PopularProvider extends StateNotifier<MovieState>{
  PopularProvider(super.state){
   getData();
  }

  Future<void> getData() async{
    state = state.copyWith(movieState: state, isLoad: state.isLoadMore ? false: true);
      final response = await MovieService.getMovieByCategory(apiPath: state.apiPath, page: state.page);
      response.fold(
              (l){
                state = state.copyWith(movieState: state, err: l, isLoad: false);
              },
              (r){
                state = state.copyWith(movieState: state, err: '', isLoad: false, movies: [...state.movies, ...r]);
              }
      );

  }

  void loadMore(){
    state  = state.copyWith(movieState: state, page: state.page + 1, isLoadMore: true);
    getData();
  }


}


final topProvider = StateNotifierProvider<TopProvider, MovieState>((ref) => TopProvider(MovieState(
    err: '',
    isLoad: false,
    movies: [],
    apiPath: Api.topRatedMovie,
    page: 1,
    isLoadMore: false
)));


class TopProvider extends StateNotifier<MovieState>{
  TopProvider(super.state){
    getData();
  }

  Future<void> getData() async{
    state = state.copyWith(movieState: state, isLoad: state.isLoadMore ? false: true);
    final response = await MovieService.getMovieByCategory(apiPath: state.apiPath, page: state.page);
    response.fold(
            (l){
          state = state.copyWith(movieState: state, err: l, isLoad: false);
        },
            (r){
          state = state.copyWith(movieState: state, err: '', isLoad: false, movies: [...state.movies, ...r]);
        }
    );

  }

  void loadMore(){
    state  = state.copyWith(movieState: state, page: state.page + 1, isLoadMore: true);
    getData();
  }


}


final upcomingProvider = StateNotifierProvider<UpcomingProvider, MovieState>((ref) => UpcomingProvider(MovieState(
    err: '',
    isLoad: false,
    movies: [],
    apiPath: Api.upcomingMovie,
    page: 1,
    isLoadMore: false
)));


class UpcomingProvider extends StateNotifier<MovieState>{
  UpcomingProvider(super.state){
    getData();
  }

  Future<void> getData() async{
    state = state.copyWith(movieState: state, isLoad: state.isLoadMore ? false: true);
    final response = await MovieService.getMovieByCategory(apiPath: state.apiPath, page: state.page);
    response.fold(
            (l){
          state = state.copyWith(movieState: state, err: l, isLoad: false);
        },
            (r){
          state = state.copyWith(movieState: state, err: '', isLoad: false, movies: [...state.movies,...r]);
        }
    );

  }
  void loadMore(){
    state  = state.copyWith(movieState: state, page: state.page + 1, isLoadMore: true);
    getData();
  }



}


final latestProvider = StateNotifierProvider<LatestProvider, MovieState>((ref) => LatestProvider(MovieState(
    err: '',
    isLoad: false,
    movies: [],
    apiPath: Api.upcomingMovie,
    page: 1,
    isLoadMore: false
)));


class LatestProvider extends StateNotifier<MovieState>{
  LatestProvider(super.state){
    getData();
  }

  Future<void> getData() async{
    state = state.copyWith(movieState: state, isLoad: true);
    final response = await MovieService.getLatest(apiPath: state.apiPath);
    response.fold(
            (l){
          state = state.copyWith(movieState: state, err: l, isLoad: false);
        },
            (r){
          state = state.copyWith(movieState: state, err: '', isLoad: false, movies: [r]);
        }
    );

  }

}