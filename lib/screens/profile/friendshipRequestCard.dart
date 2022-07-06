import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/UserProfile.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_app/routes/router.gr.dart';
import 'package:flutter_redux/flutter_redux.dart';

class FriendshipRequestCard extends StatelessWidget {
  final String userId;
  final String friendId;

  const FriendshipRequestCard({Key? key, required this.userId, required this.friendId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserProfile>(
        converter: (store) => store.state.users.firstWhere((element) => friendId == element.userId),
        builder: (context, data) {
            return Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
                  ),
                  title: Row(
                    children: [
                      InkWell(
                        child: Text(data.name),
                        onTap: () {
                          context.router.push(ProfilePageRoute(userId: data.userId));
                        },
                      ),
                      IconButton(
                          onPressed: () {
                            StoreProvider.of<AppState>(context).dispatch(AddFriendAction(
                                toUserId: userId,
                                friendUserId: friendId
                            ));
                          },
                          icon: const Icon(Icons.done, color: Colors.green,)
                      ),
                      IconButton(
                          onPressed: () {
                            StoreProvider.of<AppState>(context).dispatch(DenyFriendshipAction(
                                toUserId: userId,
                                friendUserId: friendId
                            ));
                          },
                          icon: const Icon(Icons.remove, color: Colors.red,)
                      ),
                    ],
                  ),
                )
            );
        }
    );
  }
}

