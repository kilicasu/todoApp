import 'package:flutter/material.dart';
//import 'package:todo_app/constants/tasktype.dart';
//import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/todo.dart';

//List<String> todo = ["Study Lesson", "Run5K", "GoTo Party"];
//BUNU EKLEMEDİM CTODO[İNDEX]  HATASINI GİDERMEK İÇN TODOITEM WİDGETINA PROP EKLEYEREK YAPICAM   title tanımladim statefulwidgetına ve  onu todo[index]  yerine widget.title ile çağırarak hatayı giderdim.final ile değiştirilmemesini sağladım. ""  ile diğer hatayı giderdim
//son olarak main darta gidip todoitem çağırıyorum return ile
class TodoItem extends StatefulWidget {
  const TodoItem({super.key, required this.task});
  final Todo task;
  //required kısmını silip task ı ekledim  yukarıyı task ile bağladım.
  //sonra widget.title kısmını widget.task.title olarak değiştirdim.
  //const TodoItem({super.key , required this.title}); ile study lesson yazısını yazdırdım.
  // final String title;
  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      //kenarları yuvarlatma
      color: widget.task.completed! ? Colors.grey : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /*//ternary operatıon   a==5 ? DOĞRU : YANLIŞ
            widget.task.type == TaskType.note
                ? Image.asset("lib/assets/images/category_1.png")
                : widget.task.type == TaskType.contest
                    ? Image.asset("lib/assets/images/category_3.png")
                    : Image.asset("lib/assets/images/category_2.png"),
            /*const Icon(
              Icons.notes_outlined,
              size: 40.0,
            ),*/*/
            Image.asset("lib/assets/images/category_1.png"),
            Expanded(
              child: Column(
                children: [
                  Text(
                    widget.task.todo!,
                    style: TextStyle(
                        decoration: widget.task.completed!
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                  Text("User: ${widget.task.userId!}"),
                ],
              ),
            ),

            // checkbox kullanımı
            Checkbox(
              value: isChecked,
              onChanged: (val) {
                setState(
                  () {
                    isChecked = val!;
                    widget.task.completed = !widget.task.completed!;
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
