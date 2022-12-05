import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterrun/models/todo.dart';
import 'package:flutterrun/providers/todo_provider.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
            builder: (context, ref, child) {
              final todoData = ref.watch(todoProvider);
              return SafeArea(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'add some'
                            ),
                            onFieldSubmitted: (val){
                               ref.read(todoProvider.notifier).addTodo(Todo(
                                   title: val, id:DateTime.now().toString()));
                            },
                          ),
                          SizedBox(height: 10,),
                          Expanded(
                              child: ListView.builder(
                                    itemCount: todoData.length,
                                  itemBuilder: (context, index){
                                      final todo = todoData[index];
                                      return ListTile(
                                        leading: Icon(Icons.account_tree),
                                        title: Text(todo.title),
                                      );
                                  }
                              )
                          )
                        ],
                      ),
                    ),
                  )
              );
            }
    )
    );
  }
}
