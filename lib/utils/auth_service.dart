import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  bool _authenticated = false;
  bool get authenticated => _authenticated;
  String _username = '';
  String get username => _username;
  set username(String value) {
    _username = value;
  }
  set authenticated(bool value) {
    _authenticated = value;
    notifyListeners();
  }
}