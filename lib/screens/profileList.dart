import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/UserProfile.dart';
import 'package:flutter_app/routes/router.gr.dart';

class ProfileList extends StatefulWidget {
  const ProfileList({Key? key}) : super(key: key);

  @override
  State<ProfileList> createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {

  List<UserProfile> userProfiles = [
    UserProfile(name: 'User1'),
    UserProfile(name: 'User2'),
    UserProfile(name: 'User3'),
    UserProfile(name: 'User4'),
    UserProfile(name: 'User5'),
    UserProfile(name: 'User6'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: userProfiles.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
            child: Card(
              child: ListTile(
                onTap: () {
                  AutoRouter.of(context).push(const ProfilePageRoute());
                },
                title: Text(userProfiles[index].name),
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
