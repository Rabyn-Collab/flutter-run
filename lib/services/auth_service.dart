import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../commons/firebase_instances.dart';




class AuthService {

  Future<Either<String, bool>> userSignUp()async{

    try{
   final ref = FirebaseInstances.firebaseStorage.ref().child('');
      return Right(true);
    }on FirebaseAuthException catch (err){
     return  Left('${err.message}');

    }


  }


}