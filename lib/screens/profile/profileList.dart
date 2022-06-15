import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/UserProfile.dart';
import 'package:flutter_app/navpanel/navPanel.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_app/routes/router.gr.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProfileList extends StatefulWidget {
  const ProfileList({Key? key}) : super(key: key);

  @override
  State<ProfileList> createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  String? searchText = '';

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
        drawer: const NavPanel(),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (String? value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search',
                  ),
                ),
                const TabBar(
                  labelStyle: TextStyle(color: Colors.black),
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  tabs: [
                    Tab(text: 'Friends'),
                    Tab(text: 'All'),
                  ],
                ),
                const SizedBox(height: 30),
                Flexible(
                  child: TabBarView(
                    children: [
                      StoreConnector<AppState, List<UserProfile>>(
                        converter: (store) => searchText != ''
                            ? store.state.users.where((element) =>
                                element.userId != MyApp.of(context).authService.userId
                                && element.friends.contains(MyApp.of(context).authService.userId)
                                && element.name.toLowerCase().contains(searchText!)
                              ).toList()
                            : store.state.users.where((element) =>
                                element.userId != MyApp.of(context).authService.userId
                                && element.friends.contains(MyApp.of(context).authService.userId)
                              ).toList(),
                        builder: (context, list) {
                          return ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                                child: Card(
                                  child: ListTile(
                                    onTap: () {
                                      context.router.push(ProfilePageRoute(userId: list[index].userId));
                                    },
                                    title: Text(list[index].name),
                                    leading: const CircleAvatar(
                                      backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      ),
                      StoreConnector<AppState, ProfileInteract>(
                          converter: (store) =>
                          ProfileInteract(
                              list: searchText != ''
                                ? store.state.users.where((element) =>
                                    element.userId != MyApp.of(context).authService.userId
                                    && element.name.toLowerCase().contains(searchText!)
                                  ).toList()
                                : store.state.users.where((element) =>
                                    element.userId != MyApp.of(context).authService.userId
                                  ).toList(),
                              requestFriendshipCallback: (String userId) {
                                store.dispatch(RequestFriendshipAction(
                                  fromUserId: MyApp.of(context).authService.userId,
                                  toUserId: userId
                                ));
                              }
                          ),
                          builder: (context, profileInteract) {
                            return ListView.builder(
                              itemCount: profileInteract.list.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                                  child: Card(
                                    child: ListTile(
                                      title: Row(
                                        children: [
                                          InkWell(
                                            child:  Text(profileInteract.list[index].name),
                                            onTap: () {
                                              context.router.push(ProfilePageRoute(userId: profileInteract.list[index].userId));
                                            },
                                          ),
                                          if (
                                            !profileInteract.list[index].friends.contains(MyApp.of(context).authService.userId)
                                            && !profileInteract.list[index].friendshipRequests.contains(MyApp.of(context).authService.userId)
                                          )
                                            TextButton(
                                              onPressed: () {
                                                profileInteract.requestFriendshipCallback(profileInteract.list[index].userId);
                                              },
                                              child: const Text('Request friendship'),
                                            )
                                        ],
                                      ),
                                      leading: const CircleAvatar(
                                        backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileInteract {
  List<UserProfile> list;
  Function(String userId) requestFriendshipCallback;

  ProfileInteract({required this.list, required this.requestFriendshipCallback});
}
