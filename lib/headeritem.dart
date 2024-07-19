import 'package:flutter/material.dart';
//import 'package:todo_app/constants/tasktype.dart';
import 'package:todo_app/model/task.dart';

class HeaderItem extends StatefulWidget {
  const HeaderItem({super.key, required this.task});
  final Task task;

  @override
  State<HeaderItem> createState() => _HeaderItemState();
}

class _HeaderItemState extends State<HeaderItem> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Text(
          widget.task.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
