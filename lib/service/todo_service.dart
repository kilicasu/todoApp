import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_app/model/todo.dart';

class TodoService {
  final String url = 'https://dummyjson.com/todos';
  final String addUrl = 'https://dummyjson.com/todos/add';

  Future<List<Todo>> getUncompletedTodos() async {
    final response = await http.get(Uri.parse(url));

    List<dynamic> resp = jsonDecode(response.body)["todos"];

    List<Todo> todos = resp.map((element) => Todo.fromJson(element)).toList();

    todos.removeWhere((element) {
      if (element.completed == null) {
        return false;
      }

      return element.completed! == true;
    });

    return todos;
  }

  Future<List<Todo>> getCompletedTodos() async {
    final response = await http.get(Uri.parse(url));

    List<dynamic> resp = jsonDecode(response.body)["todos"];

    List<Todo> todos = List.empty(growable: true);

    for (var element in resp) {
      Todo task = Todo.fromJson(element);
      if (task.completed! == true) {
        todos.add(task);
        //json elemanı todoya çevirerek ekledim
      }
    }

    return todos;
  }

  Future<void> completedTask(Todo todo) async {
    final response = await http.put(Uri.parse('$url/${todo.id}'),
        body: jsonEncode({"completed": true}),
        headers: {"Content-Type": "application/json"});

    print(response.body);
  }

  Future<Todo> addTodo(Todo newTodo) async {
    final response = await http.post(
      Uri.parse(addUrl),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: json.encode(newTodo.toJson()),
    );
    print(response.body);

    return Todo.fromJson(jsonDecode(response.body));
  }
}
