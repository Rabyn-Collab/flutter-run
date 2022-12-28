import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterrun/commons/firebase_instances.dart';
import 'package:flutterrun/services/auth_service.dart';

import '../providers/auth_provider.dart';


class HomePage extends ConsumerWidget {

  final uid = FirebaseInstances.firebaseAuth.currentUser!.uid;
  @override
  Widget build(BuildContext context, ref) {
    FlutterNativeSplash.remove();
    final userData = ref.watch(userStream);
    final allUserData = ref.watch(allUserStream);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sample Chat'),
      ),
      drawer: Drawer(
        child: userData.when(
            data: (data){
              return ListView(
                children: [
                  DrawerHeader(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(data.imageUrl!), fit: BoxFit.cover)
                      ),
                      child: Container()),
                  ListTile(

                    leading: Icon(Icons.person),
                    title: Text(data.firstName!),
                  ),
                  ListTile(
                    leading: Icon(Icons.mail),
                    title: Text(data.metadata!['email']),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.of(context).pop();
                      ref.read(authProvider.notifier).userLogOut();
                    },
                    leading: Icon(Icons.exit_to_app),
                    title: Text('SignOut'),
                  )
                ],
              );
            },
            error: (err, stack) => Center(child: Text('$err')),
            loading: () => Center(child: CircularProgressIndicator())
        )
      ),
        body: ListView(
            children: [
              Container(
                height: 190,
                child: allUserData.when(
                    data: (data){
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                          itemBuilder: (context, index){
                          return Padding(
                            padding:index == 0 ? EdgeInsets.only(left: 10, top: 10) : EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(data[index].imageUrl!),
                                ),
                                SizedBox(height: 10,),
                                Text(data[index].firstName!, style: TextStyle(fontSize: 17),)
                              ],
                            ),
                          );
                          }
                      );
                    },
                    error: (err, stack) => Center(child: Text('$err')),
                    loading: () => Container()
                ),
              ),
            ]
        )
    );
  }
}
