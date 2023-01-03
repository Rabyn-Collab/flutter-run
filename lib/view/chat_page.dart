import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutterrun/commons/firebase_instances.dart';
import '../providers/room_provider.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';


class ChatPage extends ConsumerWidget {

  final  types.Room room;
  ChatPage(this.room);

  @override
  Widget build(BuildContext context, ref) {
    final messageData = ref.watch(messageStream(room));
    return Scaffold(
        body: messageData.when(
            data: (data){
              return Chat(
                showUserNames: true,
                showUserAvatars: true,
                messages: data, 
                onSendPressed: (PartialText message) async{
                 FirebaseInstances.firebaseChatCore.sendMessage(message, room.id);
                }, user: types.User(
                id: FirebaseInstances.firebaseChatCore.firebaseUser!.uid
              ),
                
              );
            },
            error: (err, stack) => Center(child: Text('$err')),
            loading: () => Center(child: CircularProgressIndicator())
        )
    );
  }
}
