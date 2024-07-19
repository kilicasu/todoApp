import 'package:todo_app/constants/tasktype.dart';

class Task {
  Task({
    //constructor oluşturdum
    required this.type,
    required this.title,
    required this.description,
    required this.isCompleted,
    //bu parametreler aşağıdaki final değişkenlere bağlanmayı sağlicak
  });
  final TaskType type;
  //tasktype.dartta tiplerini belirledikten sonra bu değişkeni ekledim.
  final String title;
  final String description;
  bool isCompleted;
}
