import 'package:flutter/material.dart';

class UsernameProvider with ChangeNotifier {
  String _username = '';

  String get username => _username;

  setUsername(String newUsername) {
    _username = newUsername;
    notifyListeners();
  }
}
