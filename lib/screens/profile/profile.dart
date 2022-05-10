import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/navpanel/navPanel.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_app/screens/profile/profileEdit.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart' as intl;

import '../../models/UserProfile.dart';

class ProfilePage extends StatelessWidget {
  String userId;

  ProfilePage({Key? key, @PathParam('id') required this.userId}) : super(key: key);

  Widget createLabel(text) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 3
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const NavPanel(),
        body: StoreConnector<AppState, UserProfile>(
          converter: (store) => store.state.users.firstWhere((user) => user.userId == userId),
          builder: (context, data) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.network('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            createLabel('Name:'),
                            Text(data.name),
                            const SizedBox(height: 10),
                            if (data.dateOfBirth != null) ... [
                              createLabel('Date of birth:'),
                              Text(intl.DateFormat.yMd().format(data.dateOfBirth!)),
                              const SizedBox(height: 10),
                            ],
                            if (data.location != null) ... [
                              createLabel('Location:'),
                              Text(data.location!),
                              const SizedBox(height: 10),
                            ],
                            if (data.phoneNumber != null) ... [
                              createLabel('Phone:'),
                              Text(data.phoneNumber!),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (data.userId == MyApp.of(context).authService.userId)
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEdit(profile: data)));
                      },
                      icon: const Icon(Icons.edit)
                  )
              ],
            );
          }
        ),
      ),
    );
  }
}
