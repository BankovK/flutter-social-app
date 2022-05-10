import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/UserProfile.dart';
import 'package:flutter_app/navpanel/navPanel.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_app/routes/router.gr.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProfileList extends StatefulWidget {
  const ProfileList({Key? key}) : super(key: key);

  @override
  State<ProfileList> createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const NavPanel(),
        body: StoreConnector<AppState, List<UserProfile>>(
          converter: (store) => store.state.users,
          builder: (context, list) {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        context.router.push(ProfilePageRoute(userId: list[index].userId));
                      },
                      title: Text(list[index].name),
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        ),
      ),
    );
  }
}
