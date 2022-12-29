import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import '../commons/firebase_instances.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class CrudService {


  static CollectionReference postDb = FirebaseInstances.firebaseCloud.collection('posts');
  
  static Future<Either<String, bool>> postAdd({
    required String title,
    required String detail,
    required XFile image,
    required String uid
  })async{

    try{
      final imageId = DateTime.now().toString();
      final ref = FirebaseInstances.firebaseStorage.ref().child('postImages/$imageId');
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();

      await  postDb.add({
      'userId': uid,
      'title': title,
      'imageUrl': url,
      'imageId': imageId,
      'detail': detail,
      'comments': [],
        'like': {
          'usernames': [],
          'likes': 0
        }

      });
      return Right(true);
    }on FirebaseAuthException catch (err){
      return  Left('${err.message}');
    }


  }



  static Future<Either<String, bool>> postUpdate({
    required String title,
    required String detail,
     XFile? image,
    required String id,
     String? imageId
  })async{
    try{
      if(image == null){
        await postDb.doc(id).update({
          'title': title,
          'detail': detail
        });
      }else{
        final oldRef = FirebaseInstances.firebaseStorage.ref().child('postImages/$imageId');
        await oldRef.delete();
        final newImageId = DateTime.now().toString();
        final ref = FirebaseInstances.firebaseStorage.ref().child('postImages/$newImageId');
        await ref.putFile(File(image.path));
        final url = await ref.getDownloadURL();
        await postDb.doc(id).update({
          'title': title,
          'imageUrl': url,
          'imageId': imageId,
          'detail': detail,
        });
      }
      return Right(true);
    }on FirebaseAuthException catch (err){
      return  Left('${err.message}');
    }
  }



  static Future<Either<String, bool>> postRemove({
    required String id,
    required String imageId
 })async{
    try{
      final oldRef = FirebaseInstances.firebaseStorage.ref().child('postImages/$imageId');
      await oldRef.delete();
      await postDb.doc(id).delete();
      return Right(true);
    }on FirebaseAuthException catch (err){
      return  Left('${err.message}');
    }
  }




}