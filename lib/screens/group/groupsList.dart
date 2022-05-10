import 'package:flutter/material.dart';
import 'package:flutter_app/models/Group.dart';
import 'package:flutter_app/navpanel/navPanel.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
        drawer: const NavPanel(),
        body: SafeArea(
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
              const SizedBox(height: 30),
              Flexible(
                child: StoreConnector<AppState, List<Group>>(
                    converter: (store) => searchText != ''
                      ? store.state.groups.where((element) => element.name.toLowerCase().contains(searchText!)).toList()
                      : store.state.groups,
                    builder: (context, list) {
                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                              child: Card(
                                child: ListTile(
                                  title: Text(list[index].name),
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
              ),
            ],
          ),
        )
    );
  }
}
