import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo.dart';



class A {
  final int age;
  A(this.age);
}


class B extends A{
  B(super.age);

}
List<Todo> todos = [
  Todo(title: 'sample', id: DateTime.now().toString()),
];



final todoProvider = StateNotifierProvider<TodoProvider, List<Todo>>((ref) => TodoProvider([]));

class TodoProvider extends StateNotifier<List<Todo>>{
  TodoProvider(super.state);

final numbers = ['22'];
  addTodo(Todo todo){
    state.add(todo);
    state = [...state];
  }

  deleteTodo(Todo todo){
   state.remove(todo);
  }

  updateTodo(){

  }


}