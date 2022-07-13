import 'package:flutter/material.dart';
import 'package:flutter_app/models/UserProfile.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordEditForm extends StatefulWidget {
  final String userId;
  const PasswordEditForm({Key? key, required this.userId}) : super(key: key);

  @override
  _PasswordEditFormState createState() => _PasswordEditFormState();
}

class _PasswordEditFormState extends State<PasswordEditForm> {
  final _formKey = GlobalKey<FormState>();

  String? oldPassword;
  String? password;
  String? passwordCheck;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StoreConnector<AppState, Function(String password)>(
            converter: (store) {
              return (String password) => store.dispatch(ChangeUserPasswordAction(
                userId: widget.userId,
                password: password
              ));

            }, builder: (context, callback) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: Text(AppLocalizations.of(context)!.change_password, style: const TextStyle(fontSize: 20))),
                  const SizedBox(height: 20,),
                  TextFormField(
                    onSaved: (String? value) {
                      oldPassword = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.please_enter_some_text;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.old_password,
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
                      labelText: AppLocalizations.of(context)!.new_password,
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
                      labelText: AppLocalizations.of(context)!.new_password_again,
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
                        UserProfile user = StoreProvider.of<AppState>(context).state.users.firstWhere((user) => user.userId == widget.userId);

                        if (user.password != oldPassword) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(AppLocalizations.of(context)!.old_password_incorrect), backgroundColor: Colors.red)
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

                        callback(password!);

                        Navigator.pop(context);
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.submit),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
