import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterrun/models/todo.dart';
import 'package:flutterrun/providers/todo_provider.dart';
import 'package:get/get.dart';


class TodoEditPage extends StatelessWidget {
 final Todo todo;
 final int index;
 TodoEditPage(this.todo, this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer(
              builder: (context, ref, child) {
                return Container(
                  child: TextFormField(
                    initialValue: todo.title,
                    // controller: textController,
                    decoration: InputDecoration(
                        hintText: 'add some'
                    ),
                    onFieldSubmitted: (val) {
                      if (val.isEmpty) {
                        Get.defaultDialog(
                            title: 'Required',
                            content: Text('add some data'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                    // Navigator.of(context).pop();
                                  }, child: Text('Close'))
                            ]
                        );
                      } else {
                        final newTodo = Todo(title: val, id: todo.id);
                       ref.read(todoProvider.notifier).updateTodo(newTodo, index);
                       Get.back();
                      }
                    },
                  ),
                );
              }
            ),
          ),
        )
    );
  }
}
