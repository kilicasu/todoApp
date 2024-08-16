import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/auth/auth_view_model.dart';
//import 'package:flutter/widgets.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordEntered = false;

  @override
  void dispose() {
    _firstnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

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
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage("lib/assets/images/profile_picture.jpg"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _firstnameController,
                        decoration: customInputDecoration("Name"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a firstname ';
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
                          return Column(
                            children: [
                              if (authViewModel.isLoading)
                                const CircularProgressIndicator(),
                              if (!authViewModel.isLoading)
                                TextButton(
                                  onPressed: () async {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      await authViewModel.register(
                                        _firstnameController.text,
                                        _emailController.text,
                                        _passwordController.text,
                                      );
                                      if (authViewModel.isAuthenticated) {
                                        Navigator.pushNamed(
                                            context, "/loginPage");
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "Registration failed. Please try again."),
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
                                    "Sign in",
                                    //kaydet
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/loginPage");
                              },
                              child: const Text(
                                "Log in",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 35, 154, 218),
                                ),
                              ),
                            ),
                            const Text("Forgot Password?",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 35, 154, 218),
                                )),
                            customSizedBox,
                            const Text("By using this account you agree to",
                                // "Bu hesap ile şunlari kabul etmiş olursunuz ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                )),
                            RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(children: <TextSpan>[
                                  TextSpan(
                                    text: " Terms of Service ",
                                    // Kullanim Şartlari
                                    style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline),
                                  ),
                                  TextSpan(
                                    text: " and ",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Privacy Policy.",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline),
                                  )
                                ])),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get customSizedBox => const SizedBox(
        height: 20,
      );

  InputDecoration customInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
          color: Color.fromARGB(
            255,
            105,
            104,
            104,
          ),
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
