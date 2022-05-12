import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/NewsPost.dart';
import 'package:flutter_app/models/UserProfile.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_app/routes/router.gr.dart';
import 'package:flutter_app/screens/post/postForm.dart';
import 'package:flutter_app/screens/post/postItem.dart';
import 'package:flutter_redux/flutter_redux.dart';

class GroupPage extends StatelessWidget {
  String groupId;
  GroupPage({Key? key, @PathParam('id') required this.groupId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<UserProfile> members = StoreProvider.of<AppState>(context).state.users
        .where((element) => StoreProvider.of<AppState>(context).state.groups.firstWhere((element) => element.groupId == groupId).members.contains(element.userId)).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        elevation: 0,
        actions: [
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
            title: Text('${members.length} Members'),
            children: <Widget>[
              ...members.map((UserProfile profile) {
                return ListTile(
                  onTap: () {
                    context.router.push(ProfilePageRoute(userId: profile.userId));
                  },
                  title: Text(profile.name),
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
                  ),
                );
              })
            ],
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostForm(groupId: groupId))
                );
              },
              child: const Text('Add post')
          ),
          Flexible(
            child: StoreConnector<AppState, List<NewsPost>>(
                converter: (store) => store.state.posts.where((element) => element.groupId == groupId).toList(),
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
