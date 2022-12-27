import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../commons/firebase_instances.dart';



class AuthService {

 static Future<Either<String, bool>> userSignUp({
  required String email,
    required String username,
    required XFile image,
    required String password
})async{

    try{
   final ref = FirebaseInstances.firebaseStorage.ref().child('userImages/${image.name}');
   await ref.putFile(File(image.path));
   final url = await ref.getDownloadURL();

   final credential = await FirebaseInstances.firebaseAuth.createUserWithEmailAndPassword(
     email: email,
     password: password,
   );

   await  FirebaseInstances.firebaseChatCore.createUserInFirestore(
     types.User(
       firstName: username,
       id: credential.user!.uid,
       imageUrl: url,
       lastName: '',
       metadata: {
         'email': email
       }
     ),
   );

      return Right(true);
    }on FirebaseAuthException catch (err){
     return  Left('${err.message}');
    }


  }



 static Future<Either<String, bool>> userLogin({
   required String email,
   required String password
 })async{
   try{
     final credential = await FirebaseInstances.firebaseAuth.signInWithEmailAndPassword(
       email: email,
       password: password,
     );
     return Right(true);
   }on FirebaseAuthException catch (err){
     return  Left('${err.message}');
   }
 }



 static Future<Either<String, bool>> userLogOut()async{
   try{
     final credential = await FirebaseInstances.firebaseAuth.signOut();
     return Right(true);
   }on FirebaseAuthException catch (err){
     return  Left('${err.message}');
   }
 }




}