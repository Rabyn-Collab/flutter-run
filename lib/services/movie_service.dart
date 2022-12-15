import 'package:dio/dio.dart';
import '../models/movie.dart';
import 'package:dartz/dartz.dart';



class MovieService{

  static Dio dio =  Dio();
  static Future<Either<String, List<Movie>>> getMovieByCategory({required String apiPath, required int page}) async{
      try{
     final response =  await dio.get(apiPath,
           queryParameters: {
             'api_key': '2a0f926961d00c667e191a21c14461f8',
             'page': page
       });
     final newData = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
      return Right(newData);
      }on DioError catch (err){
      return  Left(err.message);
      }
  }


  static Future<Either<String, List<Movie>>> getSearchMovie({required String apiPath, required String queryText}) async{
    try{
      final response =  await dio.get(apiPath,
          queryParameters: {
            'api_key': '2a0f926961d00c667e191a21c14461f8',
            'query': queryText
          });
      final newData = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
      return Right(newData);
    }on DioError catch (err){
      return  Left(err.message);
    }
  }





  static Future<Either<String, Movie>> getLatest({required String apiPath}) async{
    try{
      final response =  await dio.get(apiPath,
          queryParameters: {
            'api_key': '2a0f926961d00c667e191a21c14461f8'
          });
      final newData =  Movie.fromJson(response.data);
      return Right(newData);
    }on DioError catch (err){

      return  Left(err.message);
    }
  }




  static Future<Either<String, dynamic>> getNews() async{
    try{
      final response =  await dio.get('https://free-news.p.rapidapi.com/v1/search',
          queryParameters: {
            'q': 'Hollywood',
            'lang': 'en'
          }, options: Options(
            headers: {
              'X-RapidAPI-Key': 'a5f227e63fmsh1662507e838257fp171f14jsna0bec840d641',
              'X-RapidAPI-Host': 'free-news.p.rapidapi.com'
            }
          ));

      return Right(response.data);
    }on DioError catch (err){

      return  Left(err.message);
    }
  }

}


