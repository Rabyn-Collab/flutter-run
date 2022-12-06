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

  addTodo(Todo todo){
    state = [...state, todo];
  }

  deleteTodo(Todo todo){
    state = state.where((element) => element.id != todo.id).toList();
   // state.remove(todo);
   // state = [...state];
  }

  updateTodo(Todo todo, int index){
    // state = [
    //   for(final t in state) if(t == todo) todo else t
    // ];
      state[index] = todo;
      state = [...state];
  }


}