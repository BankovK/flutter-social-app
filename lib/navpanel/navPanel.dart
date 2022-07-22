import 'package:flutter/material.dart';
import 'package:flutter_app/models/UserProfile.dart';
import 'package:flutter_app/navpanel/navItem.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_app/routes/router.gr.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        child: Column(children: [
            if (MyApp.of(context).authService.authenticated)
                  StoreConnector<AppState, UserProfile>(
                  converter: (store) => store.state.users.firstWhere((user) => user.userId == MyApp.of(context).authService.userId),
                  builder: (context, data) {
                    return NavItem(
                      title: AppLocalizations.of(context)!.my_page,
                      icon: Icons.home_rounded,
                      link: ProfilePageRoute(userId: MyApp.of(context).authService.userId),
                      mark: data.friendshipRequests.length
                    );
                  }),
            NavItem(
                title: AppLocalizations.of(context)!.news,
                icon: Icons.newspaper,
                link: const NewsListRoute(),
                mark: 0
            ),
            NavItem(
                title: AppLocalizations.of(context)!.profiles,
                icon: Icons.emoji_people,
                link: const ProfileListRoute(),
                mark: 0
            ),
            NavItem(
                title: AppLocalizations.of(context)!.groups,
                icon: Icons.group,
                link: const GroupsListRoute(),
                mark: 0
            )
        ])
      ),
    );
  }
}
