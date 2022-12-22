import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterrun/providers/common_provider.dart';



class AuthPage extends ConsumerWidget {
  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final passController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ref) {
    final isLogin = ref.watch(loginProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _form,
          child: Container(
            padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 45, top: 10),
                  child: Text(isLogin ? 'Login Form': 'SignUp Form', style: TextStyle(fontSize: 22, letterSpacing: 2),),
                ),

              if(!isLogin)  TextFormField(
                controller: nameController,
                  validator: (val){
                  if(val!.isEmpty){
                    return 'please provide name';
                  }
                    return null;
                  },
                  decoration:  InputDecoration(
                    hintText: 'username',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: mailController,
                  validator: (val){
                    if(val!.isEmpty){
                      return 'please provide name';
                    }
                    return null;
                  },
                  decoration:  InputDecoration(
                      hintText: 'Email',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: passController,
                  validator: (val){
                    if(val!.isEmpty){
                      return 'please provide name';
                    }else if(val.length > 20){
                      return 'password character is limit to less than 20';
                    }
                    return null;
                  },
                    obscureText: true,
                  decoration:  InputDecoration(
                      hintText: 'Password',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 20,),
                if(!isLogin)    Container(
                  height: 200,
                  width: double.infinity,
                  decoration:  BoxDecoration(
                    border: Border.all(color: Colors.black)
                  ),
                  child: Center(child: Text('please select a image')),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: (){
                      _form.currentState!.save();
                      if(_form.currentState!.validate()){
                        if(isLogin){

                        }else{

                        }
                      }


                    }, child: Text(isLogin ? 'Login' : 'Sign Up')),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(isLogin ?'Don\'t have an account' : 'Already have an account'),
                    TextButton(onPressed: (){
                      ref.read(loginProvider.notifier).toggleState();
                    }, child: Text(isLogin ? 'Sign Up' : 'Login'))
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
