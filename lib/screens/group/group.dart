import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/Group.dart';
import 'package:flutter_app/models/NewsPost.dart';
import 'package:flutter_app/models/UserProfile.dart';
import 'package:flutter_app/navpanel/localeMenu.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_app/routes/router.gr.dart';
import 'package:flutter_app/screens/post/postForm.dart';
import 'package:flutter_app/screens/post/postItem.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../redux/actions.dart';

class GroupPage extends StatefulWidget {
  String groupId;
  GroupPage({Key? key, @PathParam('id') required this.groupId}) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    Group group = StoreProvider.of<AppState>(context).state.groups
        .firstWhere((element) => element.groupId == widget.groupId);
    List<UserProfile> members = StoreProvider.of<AppState>(context).state.users
        .where((element) => group.members.contains(element.userId)).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        elevation: 0,
        actions: [
          const LocaleMenu(),
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
          )
        ],
      ),
      body: Column(
        children: [
          ExpansionTile(
            title: Text('${members.length} ${AppLocalizations.of(context)!.members}'),
            children: <Widget>[
              ...members.map((UserProfile profile) {
                return ListTile(
                  title: Row(
                    children: [
                      InkWell(
                        child: Text(profile.name),
                        onTap: () {
                          context.router.push(ProfilePageRoute(userId: profile.userId));
                        },
                      ),
                      if (MyApp.of(context).authService.userId != profile.userId && group.admins.contains(MyApp.of(context).authService.userId)) ... [
                        if (!group.admins.contains(profile.userId))
                          TextButton(
                            onPressed: () {
                              setState(() {
                                StoreProvider.of<AppState>(context).dispatch(
                                    MakeAdminAction(
                                      groupId: widget.groupId,
                                      userId: profile.userId,
                                    )
                                );
                              });
                            },
                            child: Text(AppLocalizations.of(context)!.make_admin),
                          ),
                        if (!group.banned.contains(profile.userId)) ... [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                StoreProvider.of<AppState>(context).dispatch(
                                    BanFromGroupAction(
                                      groupId: widget.groupId,
                                      userId: profile.userId,
                                    )
                                );
                              });
                            },
                            child: Text(AppLocalizations.of(context)!.ban),
                          )
                        ]
                      ]
                    ],
                  ),
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
                  ),
                );
              })
            ],
          ),
          if (group.members.contains(MyApp.of(context).authService.userId)) TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostForm(groupId: widget.groupId))
                );
              },
              child: Text(AppLocalizations.of(context)!.add_post)
          ),
          Flexible(
            child: StoreConnector<AppState, List<NewsPost>>(
                converter: (store) => store.state.posts.where((element) => element.groupId == widget.groupId).toList(),
                builder: (context, list) {
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                          child: PostItem(item: list[index])
                      );
                    },
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}
