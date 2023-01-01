import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterrun/commons/firebase_instances.dart';
import 'package:flutterrun/providers/crud_provider.dart';
import 'package:flutterrun/services/auth_service.dart';
import 'package:flutterrun/services/crud_service.dart';
import 'package:flutterrun/view/create_page.dart';
import 'package:flutterrun/view/edit_page.dart';
import 'package:get/get.dart';

import '../providers/auth_provider.dart';


class HomePage extends ConsumerWidget {

  final uid = FirebaseInstances.firebaseAuth.currentUser!.uid;
  @override
  Widget build(BuildContext context, ref) {
    FlutterNativeSplash.remove();
    final userData = ref.watch(userStream(uid));
    final allUserData = ref.watch(allUserStream);
    final postData = ref.watch(dataStream);
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
                      Get.to(() => AddPage(), transition: Transition.leftToRight);
                    },
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Create Post'),
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
        body: Column(
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
                            child: Container(
                              margin: EdgeInsets.only(right: 15),
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
                            ),
                          );
                          }
                      );
                    },
                    error: (err, stack) => Center(child: Text('$err')),
                    loading: () => Container()
                ),
              ),
              Expanded(
                  child: Container(
                    child: postData.when(
                        data: (data){
                          return ListView.builder(
                            itemCount: data.length,
                              itemBuilder: (context, index){
                              final post = data[index];
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(post.title),
                                     if(uid == post.userId)   IconButton(
                                         onPressed: (){
                                           Get.defaultDialog(
                                             cancel: IconButton(
                                                 onPressed: (){
                                                   Get.back();
                                                 },
                                                 icon: Icon(Icons.close)
                                             ),
                                             title: 'Customize post',
                                             content: Text('Edit or remove post'),
                                             actions: [
                                               IconButton(
                                                   onPressed: (){
                                                     Get.back();
                                                     Get.to(() => EditPage(post), transition: Transition.leftToRight);
                                                   }, icon: Icon(Icons.edit)),
                                               IconButton(
                                                   onPressed: (){
                                                     Get.back();
                                                     Get.defaultDialog(
                                                       title: 'Hold on',
                                                       content: Text('Are you sure you want to remove this post ?'),
                                                       actions: [
                                                         TextButton(
                                                             onPressed: (){
                                                               Get.back();
                                                               ref.read(crudProvider.notifier).postRemove(id: post.id, imageId: post.imageId);
                                                             }, child: Text('yes')),
                                                         TextButton(
                                                             onPressed: (){
                                                               Get.back();
                                                             }, child: Text('no')),
                                                       ]
                                                     );
                                                   }, icon: Icon(Icons.delete)),
                                             ]
                                           );
                                         }, icon: Icon(Icons.more_horiz_outlined)
                                     )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Image.network(post.imageUrl, height: 350, width: double.infinity),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(child: Text(post.detail, maxLines: 2,)),
                                    if(uid != post.userId )    Row(
                                      children: [
                                        IconButton(
                                            onPressed: (){

                                        }, icon: Icon(Icons.thumb_up_alt_outlined)),
                                      if(post.like.like != 0)  Text('${post.like.like}')
                                      ],
                                    )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                              }
                          );
                        },
                        error: (err, stack) => Center(child: Text('$err')),
                        loading: () => Center(child: CircularProgressIndicator(),)
                    ),
                  )
              )
            ]
        )
    );
  }
}
