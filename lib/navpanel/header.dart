import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/navpanel/localeMenu.dart';
import 'package:flutter_app/navpanel/notificationIcon.dart';
import 'package:flutter_app/screens/loginForm.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue[900],
      centerTitle: true,
      elevation: 0,
      actions: [
        const LocaleMenu(),
        if (MyApp.of(context).authService.authenticated) ... [
          const NotificationIcon(),
          IconButton(
              onPressed: () {
                MyApp
                    .of(context)
                    .authService
                    .authenticated = false;
                MyApp
                    .of(context)
                    .authService
                    .userId = '';
              },
              icon: const Icon(Icons.exit_to_app)
          ),
        ] else ... [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginForm(onLoginCallback: (bool loggedIn) => {if (loggedIn) {Navigator.pop(context)}},))
                );
              },
              icon: const Icon(Icons.login)
          ),
        ],
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
