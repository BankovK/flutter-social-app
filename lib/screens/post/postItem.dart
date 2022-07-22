import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/NewsPost.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_app/routes/router.gr.dart';
import 'package:flutter_app/screens/loginForm.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_quill/flutter_quill.dart' as quill;

import '../../main.dart';

class PostItem extends StatelessWidget {
  final NewsPost item;
  const PostItem({Key? key, required this.item}) : super(key: key);

  Widget createLikeBtn(context) {
    return !item.likedBy.contains(MyApp.of(context).authService.userId) || !MyApp.of(context).authService.authenticated
        ? IconButton(
            onPressed: () {
              if (MyApp.of(context).authService.authenticated) {
                StoreProvider.of<AppState>(context).dispatch(
                    LikePostAction(
                      postId: item.postId,
                      userId: MyApp
                          .of(context)
                          .authService
                          .userId,
                    )
                );
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginForm(onLoginCallback: (bool loggedIn) => {if (loggedIn) {Navigator.pop(context)}},))
                );
              }
            },
            icon: const Icon(Icons.heart_broken_outlined)
          )
        : IconButton(
            onPressed: () {
              StoreProvider.of<AppState>(context).dispatch(
                  RemoveLikeFromPostAction(
                    postId: item.postId,
                    userId: MyApp
                        .of(context)
                        .authService
                        .userId,
                  )
              );
            },
            icon: const Icon(Icons.heart_broken_rounded)
          );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: item.groupId == null
                ? InkWell(
                    onTap: () => AutoRouter.of(context).push(ProfilePageRoute(userId: item.authorId)),
                    child: Text(StoreProvider.of<AppState>(context).state.users.firstWhere((user) => user.userId == item.authorId).name),
                  )
                : InkWell(
                    onTap: () => context.router.push(GroupPageRoute(groupId: item.groupId!)),
                    child: Text(StoreProvider.of<AppState>(context).state.groups.firstWhere((group) => group.groupId == item.groupId).name),
                  ),
            subtitle: Text(intl.DateFormat.yMEd().add_jms().format(item.dateTime)),
            leading: item.groupId == null
                ? const CircleAvatar(
                    backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
                  )
                : null,
          ),
          Padding(
              padding: const EdgeInsets.all(18),
              child: quill.QuillEditor.basic(
                  controller: quill.QuillController(
                      document: quill.Document.fromJson(jsonDecode(item.content)),
                      selection: const TextSelection.collapsed(offset: 0)
                  ),
                  readOnly: true
              )
          ),
          if (item.authorId != MyApp.of(context).authService.userId)
            Row(
              children: [
                createLikeBtn(context),
                Text('${item.likedBy.length}')
              ]
            )
        ],
      ),
    );
  }
}
