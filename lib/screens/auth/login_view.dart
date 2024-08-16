//import 'dart:ui';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/auth/auth_view_model.dart';
//import 'package:flutter/painting.dart';
//import 'package:flutter/rendering.dart';
//import 'package:flutter/widgets.dart';
//import 'package:flutter/widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginPageState();
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 20); // Yükseklikten biraz içeriye çekin
    path.quadraticBezierTo(size.width / 4, size.height - 40, size.width / 2,
        size.height - 20); // Dalga
    path.quadraticBezierTo(
        size.width * 3 / 4, size.height, size.width, size.height - 20); // Dalga
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _LoginPageState extends State<LoginView> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordEntered = false;

  @override
  void dispose() {
    _firstnameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 4,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("lib/assets/images/header.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "To Do",
                        style: TextStyle(
                            backgroundColor: Colors.white,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "Welcome",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextFormField(
                        controller: _usernameController,
                        decoration: customInputDecoration("Name"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username ';
                          }
                          return null;
                        },
                      ),
                      customSizedBox,
                      TextFormField(
                        controller: _emailController,
                        decoration: customInputDecoration("Email Address "),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter an email address";
                          }
                          String pattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(value)) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                      ),
                      customSizedBox,
                      TextFormField(
                        controller: _passwordController,
                        decoration: customInputDecoration("Password"),
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            _isPasswordEntered = value.isNotEmpty;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a password";
                          }
                          if (value.length < 8) {
                            return "Password must be at least 8 characters";
                          }
                          return null;
                        },
                      ),
                      customSizedBox,
                      if (_isPasswordEntered)
                        TextFormField(
                          controller: _confirmPasswordController,
                          decoration: customInputDecoration("Confirm Password"),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your password";
                            }
                            if (value != _passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),
                      customSizedBox,
                      Consumer<AuthViewModel>(
                        builder: (context, authViewModel, child) {
                          return Column(children: [
                            if (authViewModel.isLoading)
                              const CircularProgressIndicator(),
                            if (!authViewModel.isLoading)
                              TextButton(
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    await authViewModel.login(
                                      _usernameController.text,
                                      _passwordController.text,
                                    );
                                    if (authViewModel.isAuthenticated) {
                                      Navigator.pushNamed(
                                          context, "/homeScreen");
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Login failed. Please try again."),
                                        ),
                                      );
                                    }
                                  }
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 179, 7, 182),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40.0, vertical: 10.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  alignment: Alignment.center,
                                ),
                                child: const Text(
                                  "Log In",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ]);
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 50),
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/registerPage");
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 35, 154, 218),
                                ),
                              ),
                            ),
                            customSizedBox,
                            const Text("Forgot Password?",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 35, 154, 218),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get customSizedBox => const SizedBox(
        height: 10,
      );

  InputDecoration customInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
          color: Color.fromARGB(255, 105, 104, 104),
          fontWeight: FontWeight.normal),
      contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
      enabledBorder: const UnderlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromARGB(255, 231, 226, 226), width: 0.5),
      ),
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: Color.fromARGB(255, 231, 226, 226), width: 0.5)),
    );
  }
}
