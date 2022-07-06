import 'package:flutter/material.dart';
import 'package:flutter_app/models/UserProfile.dart';
import 'package:flutter_app/navpanel/navItem.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_app/routes/router.gr.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../main.dart';


class NavPanel extends StatelessWidget {
  const NavPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 200,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.white12, blurRadius: 16)
          ],
        ),
        child: StoreConnector<AppState, UserProfile>(
          converter: (store) => store.state.users.firstWhere((user) => user.userId == MyApp.of(context).authService.userId),
          builder: (context, data) {
              return Column(children: [
                  NavItem(
                      title: 'My Page',
                      icon: Icons.home_rounded,
                      link: ProfilePageRoute(userId: MyApp.of(context).authService.userId),
                      mark: data.friendshipRequests.length
                  ),
                  const NavItem(
                      title: 'News',
                      icon: Icons.newspaper,
                      link: NewsListRoute(),
                      mark: 0
                  ),
                  const NavItem(
                      title: 'Profiles',
                      icon: Icons.emoji_people,
                      link: ProfileListRoute(),
                      mark: 0
                  ),
                  const NavItem(
                      title: 'Groups',
                      icon: Icons.group,
                      link: GroupsListRoute(),
                      mark: 0
                  )
              ]);
          }
        )
      ),
    );
  }
}
