import 'package:flutterrun/models/movie.dart';




class MovieState{

  final bool isLoad;
  final String err;
  final List<Movie> movies;
  final String apiPath;
  final int page;
  final bool isLoadMore;

  MovieState({
    required this.err,
    required this.isLoad,
    required this.movies,
    required this.apiPath,
    required this.page,
    required this.isLoadMore
});

  MovieState copyWith({required MovieState movieState, String? err, bool? isLoad, List<Movie>? movies,
    int? page, bool? isLoadMore}){
    return MovieState(
        err: err ?? movieState.err,
        isLoad: isLoad ?? movieState.isLoad,
        movies: movies ?? movieState.movies,
      apiPath: movieState.apiPath,
      page: page ?? movieState.page,
      isLoadMore: isLoadMore ?? movieState.isLoadMore
    );
  }


}