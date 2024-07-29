import 'package:flutter/material.dart';
import 'package:todo_app/service/todo_service.dart';

import '../../model/todo.dart';

final class HomeViewModel with ChangeNotifier {
  final TodoService _todoService = TodoService();

  List<Todo> _todoList = [];
  List<Todo> _completedList = [];

  List<Todo> get todoList => _todoList;
  List<Todo> get completedList => _completedList;

  Future<void> init() async {
    await Future.wait(
      [
        getUncompletedTodos(),
        getCompletedTodos(),
      ],
    );

    notifyListeners();
    //print('todo length: ${todoList.length}');
    //print('completed length: ${completedList.length}');
  }

  Future<void> getUncompletedTodos() async {
    _todoList = await _todoService.getUncompletedTodos();
  }

  Future<void> getCompletedTodos() async {
    _completedList = await _todoService.getCompletedTodos();
  }

  Future<void> completedTodo(Todo todo) async {
    await _todoService.completedTask(todo);
    //await init();

    todoList.removeWhere((element) => element.id == todo.id);
    completedList.add(todo);
    notifyListeners();
  }

  Future<bool> saveTodo(String todoText, String userId) async {
    Todo newTodo = Todo(
      id: -1,
      todo: todoText,
      completed: false,
      userId: int.tryParse(userId),
    );
    final result = await _todoService.addTodo(newTodo);

    _todoList.add(result);
    notifyListeners();
    return true;
  }
}
