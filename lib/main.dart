import 'package:flutter/material.dart';
import 'package:flutter_app/models/Group.dart';
import 'package:flutter_app/models/UserProfile.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_app/routes/router.gr.dart';
import 'package:flutter_app/utils/auth_service.dart';
import 'package:flutter_app/utils/route_guard.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


void main() {
  final store = Store<AppState>(
    appReducers,
    initialState: AppState(
      users: [
        UserProfile(userId: '1', name: 'User1', password: '123', dateOfBirth: DateTime(1990, 10, 11), location: 'New York', phoneNumber: '111-111111'),
        UserProfile(userId: '2', name: 'User2', password: '123'),
        UserProfile(userId: '3', name: 'User3', password: '123', dateOfBirth: DateTime(1990, 10, 11), phoneNumber: '111-222222'),
        UserProfile(userId: '4', name: 'User4', password: '123'),
        UserProfile(userId: '5', name: 'User5', password: '123', location: 'Boston', phoneNumber: '222-222222'),
        UserProfile(userId: '6', name: 'User6', password: '123'),
      ],
      posts: [],
      groups: [
        Group(groupId: '1', name: 'Group1', admins: ['1'], members: ['1']),
        Group(groupId: '2', name: 'Group2', admins: ['3'], members: ['2', '3']),
        Group(groupId: '3', name: 'Group12', admins: ['1'], members: ['1', '2', '3']),
      ]
    )
  );
  runApp(MyApp(store: store));
}

class MyApp extends StatefulWidget {
  final Store<AppState> store;
  MyApp({Key? key, required this.store}) : super(key: key);

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authService = AuthService();
  late final _appRouter = AppRouter(routeGuard: RouteGuard(authService));

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp.router(
          routeInformationParser: _appRouter.defaultRouteParser(),
          routerDelegate: _appRouter.delegate()
      ),
    );
  }
}
