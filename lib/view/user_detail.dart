import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutterrun/view/chat_page.dart';
import 'package:get/get.dart';
import '../providers/room_provider.dart';
import '../services/crud_service.dart';




class UserDetail extends ConsumerWidget {
 final  types.User user;
 UserDetail(this.user);

  @override
  Widget build(BuildContext context, ref) {
    final postData = ref.watch(dataStream);
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
              Row(
                children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user.imageUrl!),
                ),
                  SizedBox(width: 10,),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.firstName!),
                          Text(user.metadata!['email']),
                          ElevatedButton(
                              onPressed: () async{
                             final response = await ref.read(roomProvider).roomCreate(user);
                             if(response != null){
                               Get.to(() => ChatPage(response), transition: Transition.leftToRight);
                             }
                              }, child: Text('Start Chat'))
                        ],
                      )
                  )
                ],
              ),
                SizedBox(height: 15,),
                Expanded(
                    child: postData.when(
                        data: (data){
                          final userPost =data.where((element) => element.userId == user.id).toList();
                          return GridView.builder(
                            itemCount: userPost.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 2/3,
                                  crossAxisCount: 2
                              ),
                              itemBuilder: (context, index){
                              return Image.network(userPost[index].imageUrl);
                              }
                          );
                        },
                        error: (err, stack) => Text(''),
                        loading: () => Center(child: CircularProgressIndicator())
                    )
                )
              ],
            ),
          ),
        )
    );
  }
}
