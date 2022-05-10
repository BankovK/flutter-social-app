import 'package:flutter/material.dart';
import 'package:flutter_app/models/NewsPost.dart';
import 'package:flutter_app/navpanel/navPanel.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_app/screens/post/postItem.dart';
import 'package:flutter_redux/flutter_redux.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavPanel(),
      body: StoreConnector<AppState, List<NewsPost>>(
        converter: (store) => store.state.posts,
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
      )
    );
  }
}
