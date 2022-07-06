import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final int mark;
  final dynamic link;
  const NavItem({ Key? key, required this.title, required this.icon, this.link, required this.mark }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isActive = ModalRoute.of(context)?.settings.name == link.routeName;
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 6),
      child: TextButton(
        style: isActive
            ? ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey)
              )
            : null,
        onPressed: () => AutoRouter.of(context).push(link),
        child: Row(children: [
          Icon(icon, color: Colors.black),
          const SizedBox(height: 30),
          Text(title, style: const TextStyle(color: Colors.black),),
          if (mark > 0) Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.all(4),
              child: Text(
                '$mark',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
          )
        ]),
      ),
    );
  }
}
