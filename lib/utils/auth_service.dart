import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  bool _authenticated = false;
  bool get authenticated => _authenticated;
  String _userId = '';
  String get userId => _userId;
  set userId(String value) {
    _userId = value;
  }
  set authenticated(bool value) {
    _authenticated = value;
    notifyListeners();
  }
}