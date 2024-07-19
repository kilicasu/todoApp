//import 'dart:ui';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/constants/color.dart';
import 'package:todo_app/constants/tasktype.dart';
import 'package:todo_app/model/task.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key, required this.addNewTask});
  final void Function(Task newTask) addNewTask;

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTaskScreen> {
  //TEXTFİELD İÇİNE YAZDIKLARIMIZI ALABİLMEMİZ İÇİN DEĞİŞKEN OLUŞTURDUK.
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TaskType taskType = TaskType.note;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor(backgroundColor),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 10,
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    image: DecorationImage(
                      image: AssetImage("lib/assets/images/header.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 40.0,
                            color: Colors.white,
                          )),
                      const Expanded(
                        child: Text(
                          "Add New Task",
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )),
              const Padding(
                  padding: EdgeInsets.only(top: 10), child: Text("Task Title")),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 20.0),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      filled: true, fillColor: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Category"),
                    //bu widget dokunuşları kontrol eder/
                    //tek tıklamada  uzun tıklamada napıcağını söyler
                    GestureDetector(
                      onTap: () {
                        //ikona tıkladığımızı belirtsin diye tıkladıktan sonra uyarı mesajı yazdırmak için kullanırız
                        //
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 300),
                            content: Text("Category Selected"),
                          ),
                        );
                        setState(() {
                          taskType = TaskType.note;
                        });
                      },
                      child: Image.asset("lib/assets/images/category_1.png"),
                    ),
                    GestureDetector(
                      onTap: () {
                        //ikona tıkladığımızı belirtsin diye tıkladıktan sonra uyarı mesajı yazdırmak için kullanırız
                        //
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 300),
                            content: Text("Category Selected"),
                          ),
                        );
                        setState(() {
                          taskType = TaskType.calendar;
                        });
                      },
                      child: Image.asset("lib/assets/images/category_2.png"),
                    ),
                    GestureDetector(
                      onTap: () {
                        //ikona tıkladığımızı belirtsin diye tıkladıktan sonra uyarı mesajı yazdırmak için kullanırız
                        //
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 300),
                            content: Text("Category Selected"),
                          ),
                        );
                        taskType = TaskType.contest;
                      },
                      child: Image.asset("lib/assets/images/category_3.png"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text("DATE"),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: dateController,
                              decoration: const InputDecoration(
                                  filled: true, fillColor: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text("TİME"),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            //textfielda paddimg vererek kutularını ayırdık
                            child: TextField(
                              controller: timeController,
                              decoration: const InputDecoration(
                                  filled: true, fillColor: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text("DESCRIPTION")),
              SizedBox(
                height: 300,
                child: TextField(
                  controller: descriptionController,
                  // controller: descriptionController,
                  expands: true,
                  //TextField widget'ının içinde bulunduğu kapsayıcıyı (parent) sizedbox kadar yani dolduracak şekilde genişlemesini sağlar.
                  maxLines: null,
                  //satır sayısını sınırlandırmaz
                  decoration: const InputDecoration(
                      filled: true, fillColor: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Task newTask = Task(
                    type: taskType,
                    title: titleController.text,
                    description: descriptionController.text,
                    isCompleted: false,
                  );
                  widget.addNewTask(newTask);
                  Navigator.pop(context);
                  //bunun ile bir önceki sayfaya attı.
                },
                child: const Text("SAVE"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
