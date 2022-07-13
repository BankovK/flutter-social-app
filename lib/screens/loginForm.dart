import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/UserProfile.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_app/screens/registrationForm.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:collection/collection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginForm extends StatefulWidget {
  final Function(bool loggedIn) onLoginCallback;
  const LoginForm({Key? key, required this.onLoginCallback})
      : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String? name;

  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Text(AppLocalizations.of(context)!.login, style: const TextStyle(fontSize: 20))),
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
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistrationForm(onLoginCallback: widget.onLoginCallback))
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.register),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context)!.processing_data)),
                    );
                    _formKey.currentState!.save();
                    List<UserProfile> users = StoreProvider.of<AppState>(context).state.users;
                    UserProfile? user = users.firstWhereOrNull((user) => user.name == name && user.password == password);
                    if (user != null) {
                      MyApp
                          .of(context)
                          .authService
                          .authenticated = true;
                      MyApp
                          .of(context)
                          .authService
                          .userId = user.userId;
                      widget.onLoginCallback.call(true);
                    } else {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(AppLocalizations.of(context)!.incorrect_credentials), backgroundColor: Colors.red)
                      );
                    }
                  }
                },
                child: Text(AppLocalizations.of(context)!.submit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
