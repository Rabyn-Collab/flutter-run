import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api.dart';
import '../models/movie_state.dart';
import '../services/movie_service.dart';



final searchProvider = StateNotifierProvider<SearchProvider, MovieState>((ref) => SearchProvider(MovieState(
    err: '',
    isLoad: false,
    movies: [],
    apiPath: Api.searchMovie,
    page: 1,
  isLoadMore: false
)));


class SearchProvider extends StateNotifier<MovieState>{
  SearchProvider(super.state);

  Future<void> getData({required String searchText}) async{
    state = state.copyWith(movieState: state, isLoad: true);
    final response = await MovieService.getSearchMovie(apiPath: state.apiPath, queryText: searchText);
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
