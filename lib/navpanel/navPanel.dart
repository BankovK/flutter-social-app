import 'package:flutter/material.dart';
import 'package:flutter_app/navpanel/navItem.dart';
import 'package:flutter_app/routes/router.gr.dart';


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
      child: Column(children: const [
        NavItem(title: 'News', icon: Icons.newspaper, link: NewsListRoute()),
        NavItem(title: 'Create Post', icon: Icons.group, link: PostFormRoute()),
        NavItem(title: 'Friends', icon: Icons.group, link: ProfileListRoute())
      ])
    );
  }
}
