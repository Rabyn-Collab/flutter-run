import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../commons/firebase_instances.dart';


final userStream = StreamProvider((ref) => AuthService.getSingleUser());
final allUserStream = StreamProvider((ref) =>FirebaseInstances.firebaseChatCore.users());

class AuthService {

 static final uid = FirebaseInstances.firebaseAuth.currentUser!.uid;


 static Stream<types.User> getSingleUser (){
   final data = FirebaseInstances.firebaseCloud.collection('users').doc(uid).snapshots().map((event) {
     final json = event.data() as Map<String, dynamic>;
     return types.User(
         id: event.id,
         firstName: json['firstName'],
         imageUrl: json['imageUrl'],
         metadata: {
           'email' : json['metadata']['email']
         }
     );
   });
    return data;
  }


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