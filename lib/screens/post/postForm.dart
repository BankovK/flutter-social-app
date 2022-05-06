import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_app/models/NewsPost.dart';
import 'package:flutter_app/navpanel/navPanel.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_app/routes/router.gr.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../main.dart';

class PostForm extends StatefulWidget {
  const PostForm({Key? key}) : super(key: key);

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final quill.QuillController _controller = quill.QuillController.basic();

  String? text;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<List<NewsPost>, OnItemAddedCallback>(
          converter: (store) {
            return (content) =>
                store.dispatch(AddPostAction(
                    NewsPost(
                        author: MyApp.of(context).authService.username,
                        content: content,
                        dateTime: DateTime.now()
                    )
                ));
          }, builder: (context, callback) {
            return Scaffold(
              drawer: const NavPanel(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    quill.QuillToolbar.basic(controller: _controller),
                    Expanded(
                      child: quill.QuillEditor.basic(
                        controller: _controller,
                        readOnly: false,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          if (_controller.document.toPlainText().isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            callback(jsonEncode(_controller.document.toDelta().toJson()));
                            AutoRouter.of(context).push(const NewsListRoute());
                          }
                        },
                        child: const Text('Submit')
                    ),
                  ],
                ),
              ),
            );
      });
    }
} typedef OnItemAddedCallback = Function(String content);
