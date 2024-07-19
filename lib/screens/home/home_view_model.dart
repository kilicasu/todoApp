import 'package:todo_app/service/todo_service.dart';

import '../../model/todo.dart';

final class HomeViewModel {
  final TodoService _todoService = TodoService();

  List<Todo> todoList = [];
  List<Todo> completedList = [];

  Future<void> init() async {
    await Future.wait(
      [
        getUncompletedTodos(),
        getCompletedTodos(),
      ],
    );

    print('todo length: ${todoList.length}');
    print('completed length: ${completedList.length}');
  }

  Future<void> getUncompletedTodos() async {
    todoList = await _todoService.getUncompletedTodos();
  }

  Future<void> getCompletedTodos() async {
    completedList = await _todoService.getCompletedTodos();
  }

  Future<void> completedTodo(Todo todo) async {
    await _todoService.completedTask(todo);
    //await init();

    todoList.removeWhere((element) => element.id == todo.id);
    completedList.add(todo);
  }
}
