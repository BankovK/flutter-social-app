import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/NewsPost.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_app/screens/post/postItem.dart';
import 'package:flutter_app/screens/profile/profileEdit.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart' as intl;

import '../../models/UserProfile.dart';
import '../post/postForm.dart';

class ProfilePage extends StatelessWidget {
  String userId;

  ProfilePage({Key? key, @PathParam('id') required this.userId}) : super(key: key);

  Widget createLabel(text) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 3
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: StoreConnector<AppState, UserProfile>(
          converter: (store) => store.state.users.firstWhere((user) => user.userId == userId),
          builder: (context, data) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.network('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            createLabel('Name:'),
                            Text(data.name),
                            const SizedBox(height: 10),
                            if (data.dateOfBirth != null) ... [
                              createLabel('Date of birth:'),
                              Text(intl.DateFormat.yMd().format(data.dateOfBirth!)),
                              const SizedBox(height: 10),
                            ],
                            if (data.location != null) ... [
                              createLabel('Location:'),
                              Text(data.location!),
                              const SizedBox(height: 10),
                            ],
                            if (data.phoneNumber != null) ... [
                              createLabel('Phone:'),
                              Text(data.phoneNumber!),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (data.userId == MyApp.of(context).authService.userId)
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEdit(profile: data)));
                      },
                      icon: const Icon(Icons.edit)
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Posts:', style: TextStyle(fontSize: 20)),
                    if(userId == MyApp.of(context).authService.userId)
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const PostForm())
                            );
                          },
                          icon: const Icon(Icons.plus_one, color: Colors.blue)
                      ),
                  ],
                ),
                Flexible(
                  child: StoreConnector<AppState, List<NewsPost>>(
                      converter: (store) => store.state.posts.where((element) => element.authorId == userId && element.groupId == null).toList(),
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
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
