import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/UserProfile.dart';
import 'package:collection/collection.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                  Center(child: Text(AppLocalizations.of(context)!.register, style: const TextStyle(fontSize: 20))),
                  const SizedBox(height: 20,),
                  TextFormField(
                    onSaved: (String? value) {
                      name = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.please_enter_some_text;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.name,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    obscureText: true,
                    onSaved: (String? value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.please_enter_some_text;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.password,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    obscureText: true,
                    onSaved: (String? value) {
                      passwordCheck = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.please_enter_some_text;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.password_again,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(AppLocalizations.of(context)!.processing_data)),
                        );
                        _formKey.currentState!.save();
                        List<UserProfile> users = StoreProvider.of<AppState>(context).state.users;
                        UserProfile? user = users.firstWhereOrNull((user) => user.name == name);

                        if (user != null) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(AppLocalizations.of(context)!.username_taken), backgroundColor: Colors.red)
                          );
                          return;
                        }
                        if (password != passwordCheck) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(AppLocalizations.of(context)!.passwords_do_not_match), backgroundColor: Colors.red)
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
                    child: Text(AppLocalizations.of(context)!.register),
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
