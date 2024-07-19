import 'dart:convert';

//import 'package:flutter/material.dart';
//import 'package:http/http.dart';
//import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:http/http.dart' as http;

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
    List<Todo> todos = List.empty(growable: true);
    // döndürmek istediklerim için boş liste oluşturdum
    resp.forEach((element) {
      Todo task = Todo.fromJson(element);
      if (task.completed! == false) {
        todos.add(task);
        //json elemanı todoya çevirerek ekledim
      }
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
    resp.forEach((element) {
      Todo task = Todo.fromJson(element);
      if (task.completed! == true) {
        todos.add(task);
        //json elemanı todoya çevirerek ekledim
      }
    });

    return todos;
    //sonra home.darta gidip
    //TodoService todoService = TodoService();
    //todoService.getTodos();  kısımlarını buildcontext içine yazarız
  }
}
