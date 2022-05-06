import 'package:flutter/material.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_app/routes/router.gr.dart';
import 'package:flutter_app/utils/auth_service.dart';
import 'package:flutter_app/utils/route_guard.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'models/NewsPost.dart';


void main() {
  final store = Store<List<NewsPost>>(
    appReducers,
    initialState: [],
  );
  runApp(MyApp(store: store));
}

class MyApp extends StatefulWidget {
  final Store<List<NewsPost>> store;
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
    return StoreProvider<List<NewsPost>>(
      store: widget.store,
      child: MaterialApp.router(
          routeInformationParser: _appRouter.defaultRouteParser(),
          routerDelegate: _appRouter.delegate()
      ),
    );
  }
}
