import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterrun/models/todo.dart';
import 'package:flutterrun/providers/todo_provider.dart';
import 'package:get/get.dart';

import 'edit_page.dart';

class HomePage extends StatelessWidget {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(builder: (context, ref, child) {
      final todoData = ref.watch(todoProvider);
      return SafeArea(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                children: [
                  _buildText('laskd'),
                  _buildText('laskdjklsdaj'),
                  TextFormField(
                    controller: textController,
                    decoration: InputDecoration(hintText: 'add some'),
                    onFieldSubmitted: (val) {
                      if (val.isEmpty) {
                        _buildDefaultDialog();
                      } else {
                        final newTodo =
                            Todo(title: val, id: DateTime.now().toString());
                        ref.read(todoProvider.notifier).addTodo(newTodo);
                        textController.clear();
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: todoData.length,
                      itemBuilder: (context, index) {
                        final todo = todoData[index];
                        return ListTile(
                          leading: Icon(Icons.account_tree),
                          title: Text(todo.title),
                          subtitle: Text(todo.id.substring(0, 10)),
                          trailing: Container(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.to(() => EditPage(todo, index),
                                          transition: Transition.leftToRight);
                                    },
                                    icon: Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                          title: 'Hold On',
                                          content:
                                              Text('Are you sure to delete'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                  // Navigator.of(context).pop();
                                                },
                                                child: Text('No')),
                                            TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                  ref
                                                      .read(
                                                          todoProvider.notifier)
                                                      .deleteTodo(todo);
                                                  // Navigator.of(context).pop();
                                                },
                                                child: Text('Yes'))
                                          ]);
                                    },
                                    icon: Icon(Icons.delete)),
                              ],
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ),
      ));
    }));
  }

  Future<dynamic> _buildDefaultDialog() {
    return Get.defaultDialog(
        title: 'Required',
        content: Text('add some data'),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
                // Navigator.of(context).pop();
              },
              child: Text('Close'))
        ]);
  }

  Text _buildText(String label) => Text(label);
}
