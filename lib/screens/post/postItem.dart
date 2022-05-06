import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/NewsPost.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_app/routes/router.gr.dart';

class PostItem extends StatelessWidget {
  final NewsPost item;
  const PostItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: InkWell(
              onTap: () => AutoRouter.of(context).push(const ProfilePageRoute()),
              child: Text(item.author),
            ),
            subtitle: Text(intl.DateFormat.yMEd().add_jms().format(item.dateTime)),
            leading: const CircleAvatar(
              backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
            ),
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
