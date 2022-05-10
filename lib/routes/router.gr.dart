// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../screens/group/groupsList.dart' as _i5;
import '../screens/loginForm.dart' as _i6;
import '../screens/post/postForm.dart' as _i4;
import '../screens/post/postsList.dart' as _i3;
import '../screens/profile/profile.dart' as _i2;
import '../screens/profile/profileList.dart' as _i1;
import '../utils/route_guard.dart' as _i9;

class AppRouter extends _i7.RootStackRouter {
  AppRouter(
      {_i8.GlobalKey<_i8.NavigatorState>? navigatorKey,
      required this.routeGuard})
      : super(navigatorKey);

  final _i9.RouteGuard routeGuard;

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    ProfileListRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.ProfileList());
    },
    ProfilePageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfilePageRouteArgs>(
          orElse: () =>
              ProfilePageRouteArgs(userId: pathParams.getString('id')));
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.ProfilePage(key: args.key, userId: args.userId));
    },
    NewsListRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.NewsList());
    },
    PostFormRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.PostForm());
    },
    GroupsListRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.GroupsList());
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.LoginForm(
              key: args.key, onLoginCallback: args.onLoginCallback));
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig('/#redirect',
            path: '/', redirectTo: '/profiles', fullMatch: true),
        _i7.RouteConfig(ProfileListRoute.name,
            path: '/profiles', guards: [routeGuard]),
        _i7.RouteConfig(ProfilePageRoute.name,
            path: '/details/:id', guards: [routeGuard]),
        _i7.RouteConfig(NewsListRoute.name,
            path: '/news-list', guards: [routeGuard]),
        _i7.RouteConfig(PostFormRoute.name,
            path: '/create-post', guards: [routeGuard]),
        _i7.RouteConfig(GroupsListRoute.name,
            path: '/groups-list', guards: [routeGuard]),
        _i7.RouteConfig(LoginRoute.name, path: '/login')
      ];
}

/// generated route for
/// [_i1.ProfileList]
class ProfileListRoute extends _i7.PageRouteInfo<void> {
  const ProfileListRoute() : super(ProfileListRoute.name, path: '/profiles');

  static const String name = 'ProfileListRoute';
}

/// generated route for
/// [_i2.ProfilePage]
class ProfilePageRoute extends _i7.PageRouteInfo<ProfilePageRouteArgs> {
  ProfilePageRoute({_i8.Key? key, required String userId})
      : super(ProfilePageRoute.name,
            path: '/details/:id',
            args: ProfilePageRouteArgs(key: key, userId: userId),
            rawPathParams: {'id': userId});

  static const String name = 'ProfilePageRoute';
}

class ProfilePageRouteArgs {
  const ProfilePageRouteArgs({this.key, required this.userId});

  final _i8.Key? key;

  final String userId;

  @override
  String toString() {
    return 'ProfilePageRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i3.NewsList]
class NewsListRoute extends _i7.PageRouteInfo<void> {
  const NewsListRoute() : super(NewsListRoute.name, path: '/news-list');

  static const String name = 'NewsListRoute';
}

/// generated route for
/// [_i4.PostForm]
class PostFormRoute extends _i7.PageRouteInfo<void> {
  const PostFormRoute() : super(PostFormRoute.name, path: '/create-post');

  static const String name = 'PostFormRoute';
}

/// generated route for
/// [_i5.GroupsList]
class GroupsListRoute extends _i7.PageRouteInfo<void> {
  const GroupsListRoute() : super(GroupsListRoute.name, path: '/groups-list');

  static const String name = 'GroupsListRoute';
}

/// generated route for
/// [_i6.LoginForm]
class LoginRoute extends _i7.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i8.Key? key, required dynamic Function(bool) onLoginCallback})
      : super(LoginRoute.name,
            path: '/login',
            args: LoginRouteArgs(key: key, onLoginCallback: onLoginCallback));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, required this.onLoginCallback});

  final _i8.Key? key;

  final dynamic Function(bool) onLoginCallback;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLoginCallback: $onLoginCallback}';
  }
}
