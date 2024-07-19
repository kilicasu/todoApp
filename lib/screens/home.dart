import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/constants/color.dart';
import 'package:todo_app/constants/tasktype.dart';
//import 'package:todo_app/constants/tasktype.dart';
import 'package:todo_app/headeritem.dart';
import 'package:todo_app/model/task.dart';
//import 'package:todo_app/model/task.dart';
import 'package:todo_app/screens/add_new_task.dart';
import 'package:todo_app/service/todo_service.dart';
import 'package:todo_app/todoitem.dart';

//List<String> todo = ["Study Lesson", "Run5K", "GoTo Party"];
//List<String> completed = ["Game Meet up", "Take Out Trash"];

//todoitemdartta açık halleri
List<String> header = ["June ", "My To Do List"];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  void addNewTask(Task newTask) {
    setState(() {
      todo.add(newTask);
    });
    //todo.add(newTask);
  }

  @override
  Widget build(BuildContext context) {
    TodoService todoService = TodoService();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: HexColor(backgroundColor),
          body: Column(
            children: [
              //header
              Container(
                decoration: const BoxDecoration(
                    color: Colors.purple,
                    image: DecorationImage(
                      image: AssetImage("lib/assets/images/header.jpg"),
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
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child: SingleChildScrollView(
                          child: FutureBuilder(
                        future: todoService.getUncompletedTodos(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return const CircularProgressIndicator();
                          } else {
                            return ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return TodoItem(
                                  task: snapshot.data![index],
                                );
                              },
                            );
                          }
                        },
                      )))),

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
                      child: FutureBuilder(
                    future: todoService.getCompletedTodos(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const CircularProgressIndicator();
                      } else {
                        return ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return TodoItem(
                              task: snapshot.data![index],
                            );
                          },
                        );
                      }
                    },
                  )),
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
          ),
        ),
      ),
    );
  }
}
