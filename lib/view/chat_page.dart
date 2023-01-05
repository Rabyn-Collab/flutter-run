import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutterrun/commons/firebase_instances.dart';
import 'package:flutterrun/providers/common_provider.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/room_provider.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';


class ChatPage extends ConsumerStatefulWidget {

  final  types.Room room;
  ChatPage(this.room);

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {

  bool isLoad = false;

  @override
  Widget build(BuildContext context) {
    final messageData = ref.watch(messageStream(widget.room));

    return Scaffold(
        body: messageData.when(
            data: (data){
              return Chat(
                isAttachmentUploading: isLoad,
                showUserNames: true,
                showUserAvatars: true,
                messages: data,
                onAttachmentPressed: () async{
                  final ImagePicker _picker = ImagePicker();
               final image =  await  _picker.pickImage(source: ImageSource.gallery);
               if(image != null){
                 setState(() {
                   isLoad = true;
                 });
                 final ref = FirebaseInstances.firebaseStorage.ref().child('chtImages/${image.name}');
                 await ref.putFile(File(image.path));
                 final url = await ref.getDownloadURL();
                 final length = File(image.path).lengthSync();

                 final imageMessage = types.PartialImage(
                   name: image.path,
                       uri: url,
                   size: length
                 );
                 FirebaseInstances.firebaseChatCore.sendMessage(imageMessage, widget.room.id);
                 setState(() {
                   isLoad = false;
                 });
               }

                },
                onSendPressed: (PartialText message) async{
                 FirebaseInstances.firebaseChatCore.sendMessage(message, widget.room.id);
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
