import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/color.dart';
import 'package:todo_app/constants/tasktype.dart';
import 'package:todo_app/core/extensions/string_extensions.dart';
//import 'package:todo_app/constants/tasktype.dart';
import 'package:todo_app/headeritem.dart';
import 'package:todo_app/model/task.dart';
//import 'package:todo_app/model/task.dart';
import 'package:todo_app/screens/add_new_task.dart';
import 'package:todo_app/screens/home/home_view_model.dart';
import 'package:todo_app/todoitem.dart';

//List<String> todo = ["Study Lesson", "Run5K", "GoTo Party"];
//List<String> completed = ["Game Meet up", "Take Out Trash"];

List<String> header = ["June ", "My To Do List"];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeViewModel model;

  List<Task> todo = [
    Task(
        type: TaskType.note,
        title: "Study Lesson",
        description: "Study COMP117",
        isCompleted: false),
    Task(
        type: TaskType.calendar,
        title: "Go To Party",
        description: "Attend to party",
        isCompleted: false),
    Task(
        type: TaskType.contest,
        title: "Run 5K",
        description: "Run 5 kilometres",
        isCompleted: false),
  ];
  List<Task> completed = [
    Task(
        type: TaskType.note,
        title: "Study Lesson",
        description: "Study COMP117",
        isCompleted: false),
    Task(
        type: TaskType.calendar,
        title: "Go To Party",
        description: "Attend to party",
        isCompleted: false),
  ];

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<HomeViewModel>(context, listen: false).init();
    });
  }

  // Future<void> getTodos() async {
  //   await model.init();
  //   setState(() {});
  // }

  void addNewTask(Task newTask) {
    setState(() {
      //todo.add(newTask); provider için
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(backgroundColor),
      body: Consumer<HomeViewModel>(
        builder: (context, model, child) {
          return Column(
            children: [
              //header
              Container(
                decoration: BoxDecoration(
                    color: Colors.purple,
                    image: DecorationImage(
                      image: AssetImage("header".toJpg),
                      fit: BoxFit.cover,
                    )),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: header.length,
                        itemBuilder: (context, index) {
                          return HeaderItem(task: todo[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              //Top Column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: model.todoList.length,
                      itemBuilder: (context, index) {
                        final item = model.todoList[index];

                        return TodoItem(
                          task: item,
                          onChanged: (isCompleted) async {
                            if (isCompleted) {
                              await model.completedTodo(item);
                              setState(() {});
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),

              //completed text
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Completed",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              //bottom column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: model.completedList.length,
                      itemBuilder: (context, index) {
                        final item = model.completedList[index];
                        return TodoItem(
                          task: item,
                        );
                      },
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddNewTaskScreen(
                          addNewTask: (newTask) => addNewTask(newTask),
                        ),
                      ),
                    );
                  },
                  child: const Text("Add New Task"))
            ],
          );
        },
      ),
    );
  }
}
