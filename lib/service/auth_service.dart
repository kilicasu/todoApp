import 'dart:convert';

import 'package:http/http.dart' as http;
//import 'package:todo_app/model/user.dart';

class AuthService {
  final String logInurl = "https://dummyjson.com/auth/login";
  final String registerUrl = "https://dummyjson.com/users/add";

  Future<Map<String, dynamic>?> login(
    String username,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse(logInurl),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Failed to login: ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>?> register(
      String firstName, String email, String password) async {
    final response = await http.post(
      Uri.parse(registerUrl),
      headers: {"Content-Type": "application/json "},
      body: jsonEncode({
        "firstName": firstName,
        "email": email,
        "password": password,
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Failed to register : ${response.statusCode}");
    }
  }
}
