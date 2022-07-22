import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/UserProfile.dart';
import 'package:flutter_app/navpanel/header.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_app/screens/profile/passwordEdit.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../routes/router.gr.dart';

class ProfileEdit extends StatefulWidget {
  final UserProfile profile;
  const ProfileEdit({Key? key, required this.profile}) : super(key: key);

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final initialDate = widget.profile.dateOfBirth ?? DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (picked != null && picked != initialDate) {
      setState(() {
        widget.profile.dateOfBirth = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _dateController.text = widget.profile.dateOfBirth != null
        ? intl.DateFormat.yMd().format(widget.profile.dateOfBirth!)
        : '';
    return SafeArea(
      child: Scaffold(
        appBar: const Header(),
        body: StoreConnector<AppState, OnProfileUpdatedCallback>(
            converter: (store) {
              return () =>
                store.dispatch(UpdateProfileAction(widget.profile));
            }, builder: (context, callback) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.network(
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png',
                      height: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            initialValue: widget.profile.name,
                            onSaved: (String? value) {
                              widget.profile.name = value!;
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
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _dateController,
                            onTap: () => _selectDate(context),
                            readOnly: true,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: '${AppLocalizations.of(context)!.date_of_birth} (${AppLocalizations.of(context)!.optional})',
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            initialValue: widget.profile.location ?? '',
                            onSaved: (String? value) {
                              widget.profile.location = value!;
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: '${AppLocalizations.of(context)!.location} (${AppLocalizations.of(context)!.optional})',
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            initialValue: widget.profile.phoneNumber ?? '',
                            onSaved: (String? value) {
                              widget.profile.phoneNumber = value!;
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: '${AppLocalizations.of(context)!.phone} (${AppLocalizations.of(context)!.optional})',
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PasswordEditForm(userId: widget.profile.userId))
                          );
                        },
                        child: Text(AppLocalizations.of(context)!.change_password)
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(AppLocalizations.of(context)!.processing_data)),
                                );
                                _formKey.currentState!.save();
                                widget.profile.location = widget.profile.location != ''
                                    ? widget.profile.location
                                    : null;
                                widget.profile.phoneNumber = widget.profile.phoneNumber != ''
                                    ? widget.profile.phoneNumber
                                    : null;
                                callback();
                                context.router.push(ProfilePageRoute(userId: widget.profile.userId));
                              }
                            },
                            icon: const Icon(Icons.done)
                        ),
                        IconButton(
                          onPressed: () {
                            context.router.push(ProfilePageRoute(userId: widget.profile.userId));
                          },
                          icon: const Icon(Icons.cancel),
                        )
                      ],
                    )
                  ],
                ),
              );
          }
        ),
      ),
    );
  }
} typedef OnProfileUpdatedCallback = Function();
