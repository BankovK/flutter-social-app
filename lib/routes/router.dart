import 'package:auto_route/auto_route.dart';
import 'package:flutter_app/screens/group/groupsList.dart';
import 'package:flutter_app/screens/loginForm.dart';
import 'package:flutter_app/screens/post/postForm.dart';
import 'package:flutter_app/screens/post/postsList.dart';
import 'package:flutter_app/screens/profile/profile.dart';
import 'package:flutter_app/screens/profile/profileList.dart';
import 'package:flutter_app/utils/route_guard.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      page: ProfileList,
      name: 'ProfileListRoute',
      path: '/profiles',
      initial: true,
      guards: [RouteGuard],
    ),
    AutoRoute(
      page: ProfilePage,
      name: 'ProfilePageRoute',
      path: '/details/:id',
      guards: [RouteGuard],
    ),
    AutoRoute(
      page: NewsList,
      name: 'NewsListRoute',
      path: '/news-list',
      guards: [RouteGuard],
    ),
    AutoRoute(
      page: PostForm,
      name: 'PostFormRoute',
      path: '/create-post',
      guards: [RouteGuard],
    ),
    AutoRoute(
      page: GroupsList,
      name: 'GroupsListRoute',
      path: '/groups-list',
      guards: [RouteGuard],
    ),
    AutoRoute(page: LoginForm, name: 'LoginRoute', path: '/login')
  ],
)
class $AppRouter {}