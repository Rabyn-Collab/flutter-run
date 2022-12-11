import 'package:dio/dio.dart';

import '../models/movie.dart';



class MovieService{


  static Dio dio =  Dio();
  static Future getMovieByCategory({required String apiPath, required int page}) async{
      try{
     final response =  await dio.get(apiPath,
           queryParameters: {
             'api_key': '2a0f926961d00c667e191a21c14461f8',
             'page': page
       });
     final newData = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
     print(newData[0].title);

      }on DioError catch (err){
        print(err.message);
      }
  }


}