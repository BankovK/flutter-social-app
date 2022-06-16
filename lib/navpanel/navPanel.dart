import 'package:flutter/material.dart';
import 'package:flutter_app/navpanel/navItem.dart';
import 'package:flutter_app/routes/router.gr.dart';

import '../main.dart';


class NavPanel extends StatelessWidget {
  const NavPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.white12, blurRadius: 16)
        ],
      ),
      child: Column(children: [
        NavItem(title: 'My Page', icon: Icons.home_rounded, link: ProfilePageRoute(userId: MyApp.of(context).authService.userId)),
        const NavItem(title: 'News', icon: Icons.newspaper, link: NewsListRoute()),
        const NavItem(title: 'Profiles', icon: Icons.emoji_people, link: ProfileListRoute()),
        const NavItem(title: 'Groups', icon: Icons.group, link: GroupsListRoute())
      ])
    );
  }
}
