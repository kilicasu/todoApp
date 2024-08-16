import 'package:flutter/material.dart';
//import 'package:http/http.dart';
import 'package:todo_app/service/auth_service.dart';

import '../../model/user.dart';

class AuthViewModel with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? user;
  bool isLoading = false;

  bool get isAuthenticated => user != null;

  Future<void> login(String username, String password,
      {required BuildContext context}) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.login(username, password);
      if (response != null) {
        user = User.fromJson(response);
      } else {
        throw Exception("login failed");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> register(String firstname, String email, String password) async {
    return;
    isLoading = true;
    notifyListeners();

    final response = await _authService.register(firstname, email, password);
    if (response != null) {
      user = User.fromJson(response);
    } else {
      throw Exception("register filed");
    }
    isLoading = false;
    notifyListeners();
  }
}
