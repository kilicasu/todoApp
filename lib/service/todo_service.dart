import 'dart:convert';

import 'package:http/http.dart' as http;
//import 'package:flutter/material.dart';
//import 'package:http/http.dart';
//import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

class TodoService {
  final String url = 'https://dummyjson.com/todos';

  Future<List<Todo>> getUncompletedTodos() async {
    //backendin cevap verme süresi için future ekledik gecikmeyi engellemk için   yani asenkron bir işlemi tamamlayandır
    //future kullanımı zorunlu

    //http paketini eklemeliyim
    final response = await http.get(Uri.parse(url));
    //get isteği yaptık  işlem sonlanma kontrolu için "await" parametresi ekledim ve "async" fonksiyona ekledim
    List<dynamic> resp = jsonDecode(response.body)["todos"];
    //istekleri jsonkoda çevirdik
    List<Todo> todos = resp.map((element) => Todo.fromJson(element)).toList();
    // döndürmek istediklerim için boş liste oluşturdum

    todos.removeWhere((element) {
      if (element.completed == null) {
        return false;
      }

      return element.completed! == true;
    });

    return todos;
    //sonra home.darta gidip
    //TodoService todoService = TodoService();
    //todoService.getTodos();  kısımlarını buildcontext içine yazarız
  }

  Future<List<Todo>> getCompletedTodos() async {
    //backendin cevap verme süresi için future ekledik gecikmeyi engellemk için   yani asenkron bir işlemi tamamlayandır
    //future kullanımı zorunlu

    //http paketini eklemeliyim
    final response = await http.get(Uri.parse(url));
    //get isteği yaptık  işlem sonlanma kontrolu için "await" parametresi ekledim ve "async" fonksiyona ekledim
    List<dynamic> resp = jsonDecode(response.body)["todos"];
    //istekleri jsonkoda çevirdik
    List<Todo> todos = List.empty(growable: true);
    // döndürmek istediklerim için boş liste oluşturdum
    for (var element in resp) {
      Todo task = Todo.fromJson(element);
      if (task.completed! == true) {
        todos.add(task);
        //json elemanı todoya çevirerek ekledim
      }
    }

    return todos;
    //sonra home.darta gidip
    //TodoService todoService = TodoService();
    //todoService.getTodos();  kısımlarını buildcontext içine yazarız
  }

  Future<void> completedTask(Todo todo) async {
    //backendin cevap verme süresi için future ekledik gecikmeyi engellemk için   yani asenkron bir işlemi tamamlayandır
    //future kullanımı zorunlu

    //http paketini eklemeliyim
    final response = await http.put(Uri.parse('$url/${todo.id}'),
        body: jsonEncode({"completed": true}),
        headers: {"Content-Type": "application/json"});
    //put isteği yaptık  işlem sonlanma kontrolu için "await" parametresi ekledim ve "async" fonksiyona ekledim
    //jsonencode ile jsona çevirdik
    //content type json olduğu için headers ekledik
    print(response.body);
    //sonra home.darta gidip
    //TodoService todoService = TodoService();
    //todoService.getTodos();  kısımlarını buildcontext içine yazarız
  }
}
