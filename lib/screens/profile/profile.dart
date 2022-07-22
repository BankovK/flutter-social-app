import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/Group.dart';
import 'package:flutter_app/models/NewsPost.dart';
import 'package:flutter_app/navpanel/header.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_app/routes/router.gr.dart';
import 'package:flutter_app/screens/post/postItem.dart';
import 'package:flutter_app/screens/profile/friendshipRequestCard.dart';
import 'package:flutter_app/screens/profile/profileEdit.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    bool authenticated = MyApp.of(context).authService.authenticated;
    String currentUserId = MyApp.of(context).authService.userId;
    List<Group> groups = StoreProvider.of<AppState>(context).state.groups
        .where((element) => element.members.contains(userId)).toList();
    return SafeArea(
      child: Scaffold(
        appBar: const Header(),
        body: StoreConnector<AppState, UserProfileData>(
          converter: (store) => UserProfileData(
            data: store.state.users.firstWhere((user) => user.userId == userId),
            isPotentialFriend: authenticated
                ? store.state.users.firstWhere((user) => user.userId == currentUserId).friendshipRequests.contains(userId)
                : false
          ),
          builder: (context, userProfileData) {
            return Column(
              children: [
                if (userProfileData.isPotentialFriend) Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text(AppLocalizations.of(context)!.accept_friendship),
                      IconButton(
                          onPressed: () {
                            StoreProvider.of<AppState>(context).dispatch(AddFriendAction(
                                toUserId: currentUserId,
                                friendUserId: userId
                            ));
                          },
                          icon: const Icon(Icons.done, color: Colors.green,)
                      ),
                      IconButton(
                          onPressed: () {
                            StoreProvider.of<AppState>(context).dispatch(DenyFriendshipAction(
                                toUserId: currentUserId,
                                friendUserId: userId
                            ));
                          },
                          icon: const Icon(Icons.remove, color: Colors.red,)
                      ),
                    ],
                  ),
                ),
                if (userId == currentUserId && userProfileData.data.friendshipRequests.isNotEmpty) ... [
                  ExpansionTile(
                    title: Text(
                      '${AppLocalizations.of(context)!.friendship_requests}: ${userProfileData.data.friendshipRequests.length}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3
                      ),
                    ),
                    children: <Widget>[
                      ...userProfileData.data.friendshipRequests.map((String friendId) =>
                          FriendshipRequestCard(userId: userProfileData.data.userId, friendId: friendId, )
                      )
                    ],
                  ),
                ],
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
                            createLabel('${AppLocalizations.of(context)!.name}:'),
                            Text(userProfileData.data.name),
                            const SizedBox(height: 10),
                            if (userProfileData.data.dateOfBirth != null) ... [
                              createLabel('${AppLocalizations.of(context)!.date_of_birth}:'),
                              Text(intl.DateFormat.yMd().format(userProfileData.data.dateOfBirth!)),
                              const SizedBox(height: 10),
                            ],
                            if (userProfileData.data.location != null) ... [
                              createLabel('${AppLocalizations.of(context)!.location}:'),
                              Text(userProfileData.data.location!),
                              const SizedBox(height: 10),
                            ],
                            if (userProfileData.data.phoneNumber != null) ... [
                              createLabel('${AppLocalizations.of(context)!.phone}:'),
                              Text(userProfileData.data.phoneNumber!),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (userProfileData.data.userId == currentUserId)
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEdit(profile: userProfileData.data)));
                      },
                      icon: const Icon(Icons.edit)
                  ),
                if (groups.isNotEmpty) ... [
                  ExpansionTile(
                    title: Text('Member in ${groups.length} groups:'),
                    children: <Widget>[
                      ...groups.map((Group group) {
                        return ListTile(
                          title: Row(
                            children: [
                              InkWell(
                                child: Text(group.name),
                                onTap: () {
                                  context.router.push(GroupPageRoute(groupId: group.groupId));
                                },
                              ),
                            ],
                          ),
                          leading: const CircleAvatar(
                            backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
                          ),
                        );
                      })
                    ],
                  ),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${AppLocalizations.of(context)!.posts}:', style: const TextStyle(fontSize: 20)),
                    if(userId == currentUserId)
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

class UserProfileData {
  UserProfile data;
  bool isPotentialFriend;

  UserProfileData({required this.data, required this.isPotentialFriend});
}
