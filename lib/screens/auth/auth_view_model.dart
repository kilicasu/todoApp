import 'package:flutter/material.dart';

import '../../model/user.dart';

class AuthViewModel with ChangeNotifier {
  User? user;

  bool get isAuthenticated => user != null;

  Future<void> login() async {}

  Future<void> register() async {}
}
