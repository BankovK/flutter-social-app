import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/UserProfile.dart';
import 'package:collection/collection.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_redux/flutter_redux.dart';

class RegistrationForm extends StatefulWidget {
  final Function(bool loggedIn) onLoginCallback;
  const RegistrationForm({Key? key, required this.onLoginCallback})
      : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  String? name;

  String? password;

  String? passwordCheck;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StoreConnector<AppState, OnRegisterUserCallback>(
          converter: (store) {
            return (String username, String password) =>
              store.dispatch(RegisterUserAction(
                UserProfile(
                  userId: '${store.state.users.length}',
                  name: username,
                  password: password
                )
              ));
          }, builder: (context, callback) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(child: Text('Register', style: TextStyle(fontSize: 20))),
                  const SizedBox(height: 20,),
                  TextFormField(
                    onSaved: (String? value) {
                      name = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    onSaved: (String? value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    onSaved: (String? value) {
                      passwordCheck = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password again',
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        _formKey.currentState!.save();
                        List<UserProfile> users = StoreProvider.of<AppState>(context).state.users;
                        UserProfile? user = users.firstWhereOrNull((user) => user.name == name);

                        if (user != null) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Username taken!'), backgroundColor: Colors.red)
                          );
                          return;
                        }
                        if (password != passwordCheck) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Passwords do not match!'), backgroundColor: Colors.red)
                          );
                          return;
                        }

                        callback(name!, password!);

                        MyApp
                            .of(context)
                            .authService
                            .authenticated = true;
                        MyApp
                            .of(context)
                            .authService
                            .userId = '${users.length}';
                        widget.onLoginCallback.call(true);
                      }
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
} typedef OnRegisterUserCallback = Function(String username, String password);
