import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/NewsPost.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_app/routes/router.gr.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_quill/flutter_quill.dart' as quill;

class PostItem extends StatelessWidget {
  final NewsPost item;
  const PostItem({Key? key, required this.item}) : super(key: key);

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
              padding: EdgeInsets.all(18),
              child: quill.QuillEditor.basic(
                  controller: quill.QuillController(
                      document: quill.Document.fromJson(jsonDecode(item.content)),
                      selection: const TextSelection.collapsed(offset: 0)
                  ),
                  readOnly: true
              )
          ),
        ],
      ),
    );
  }
}
