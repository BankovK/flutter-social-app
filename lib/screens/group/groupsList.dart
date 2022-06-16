import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/Group.dart';
import 'package:flutter_app/navpanel/navPanel.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../routes/router.gr.dart';

class GroupsList extends StatefulWidget {
  const GroupsList({Key? key}) : super(key: key);

  @override
  State<GroupsList> createState() => _GroupsListState();
}

class _GroupsListState extends State<GroupsList> {
  String? searchText = '';

  @override
  Widget build(BuildContext context) {
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
                    Tab(text: 'My Groups'),
                    Tab(text: 'All Groups'),
                  ],
                ),
                const SizedBox(height: 30),
                Flexible(
                  child: TabBarView(
                    children: [
                      StoreConnector<AppState, List<Group>>(
                          converter: (store) => searchText != ''
                              ? store.state.groups.where((element) =>
                                  element.members.contains(MyApp.of(context).authService.userId)
                                  && element.name.toLowerCase().contains(searchText!)
                                ).toList()
                              : store.state.groups.where((element) =>
                                  element.members.contains(MyApp.of(context).authService.userId)
                                ).toList(),
                          builder: (context, list) {
                            return ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                                    child: Card(
                                      child: ListTile(
                                        title: InkWell(
                                          child: Text(list[index].name),
                                          onTap: () {
                                            context.router.push(GroupPageRoute(groupId: list[index].groupId));
                                          },
                                        ),
                                        subtitle: Text('${list[index].members.length} members'),
                                        leading: const CircleAvatar(
                                          backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
                                        ),
                                      ),
                                    )
                                );
                              },
                            );
                          }
                      ),
                      StoreConnector<AppState, GroupInteract>(
                          converter: (store) => GroupInteract(
                              list: searchText != ''
                                ? store.state.groups.where((element) => element.name.toLowerCase().contains(searchText!)).toList()
                                : store.state.groups,
                              joinCallback: (String groupId) {
                                store.dispatch(JoinGroupAction(
                                    userId: MyApp.of(context).authService.userId,
                                    groupId: groupId
                                ));
                              }
                          ),
                          builder: (context, groupInteract) {
                            return ListView.builder(
                              itemCount: groupInteract.list.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                                    child: Card(
                                      child: ListTile(
                                        title: Row(
                                          children: [
                                            InkWell(
                                              child: Text(groupInteract.list[index].name),
                                              onTap: () {
                                                context.router.push(GroupPageRoute(groupId: groupInteract.list[index].groupId));
                                              },
                                            ),
                                            if (!groupInteract.list[index].members.contains(MyApp.of(context).authService.userId))
                                              !groupInteract.list[index].banned.contains(MyApp.of(context).authService.userId)
                                              ? TextButton(
                                                  onPressed: () {
                                                    groupInteract.joinCallback(groupInteract.list[index].groupId);
                                                  },
                                                  child: const Text('Join'),
                                                )
                                              : const Text('Banned', style: TextStyle(color: Colors.red),)
                                          ],
                                        ),
                                        subtitle: Text('${groupInteract.list[index].members.length} members'),
                                        leading: const CircleAvatar(
                                          backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
                                        ),
                                      ),
                                    )
                                );
                              },
                            );
                          }
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}

class GroupInteract {
  List<Group> list;
  Function(String groupId) joinCallback;

  GroupInteract({required this.list, required this.joinCallback});
}
