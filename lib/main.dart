//import 'package:flutter/cupertino.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/auth/auth_view_model.dart';
import 'package:todo_app/screens/auth/login_view.dart';
import 'package:todo_app/screens/auth/register_view.dart';
import 'package:todo_app/screens/home/home_view.dart';

import 'screens/home/home_view_model.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter/widgets.dart';
//import 'package:hexcolor/hexcolor.dart';
//import 'package:todo_app/constants/color.dart';
//import 'package:todo_app/headeritem.dart';
//import 'package:todo_app/todoitem.dart';
//import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/loginPage": (context) => const LoginView(),
          "/registerPage": (context) => const RegisterView(),
          "/homeScreen": (context) => const HomeScreen(),
        },
        home: const LoginView(),
      ),
    );
  }
}
