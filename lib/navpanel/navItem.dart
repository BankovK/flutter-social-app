import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final dynamic link;
  const NavItem({ Key? key, required this.title, required this.icon, this.link }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 6),
      child: TextButton(
        onPressed: () => AutoRouter.of(context).push(link),
        child: Row(children: [
          Icon(icon),
          const SizedBox(height: 30),
          Text(title)
        ]),
      ),
    );
  }
}
