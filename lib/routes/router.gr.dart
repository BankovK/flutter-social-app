// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../screens/group/group.dart' as _i6;
import '../screens/group/groupsList.dart' as _i5;
import '../screens/loginForm.dart' as _i7;
import '../screens/post/postForm.dart' as _i4;
import '../screens/post/postsList.dart' as _i3;
import '../screens/profile/profile.dart' as _i2;
import '../screens/profile/profileList.dart' as _i1;
import '../utils/route_guard.dart' as _i10;

class AppRouter extends _i8.RootStackRouter {
  AppRouter(
      {_i9.GlobalKey<_i9.NavigatorState>? navigatorKey,
      required this.routeGuard})
      : super(navigatorKey);

  final _i10.RouteGuard routeGuard;

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    ProfileListRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.ProfileList());
    },
    ProfilePageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfilePageRouteArgs>(
          orElse: () =>
              ProfilePageRouteArgs(userId: pathParams.getString('id')));
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.ProfilePage(key: args.key, userId: args.userId));
    },
    NewsListRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.NewsList());
    },
    PostFormRoute.name: (routeData) {
      final args = routeData.argsAs<PostFormRouteArgs>(
          orElse: () => const PostFormRouteArgs());
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.PostForm(key: args.key, groupId: args.groupId));
    },
    GroupsListRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.GroupsList());
    },
    GroupPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GroupPageRouteArgs>(
          orElse: () =>
              GroupPageRouteArgs(groupId: pathParams.getString('id')));
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.GroupPage(key: args.key, groupId: args.groupId));
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.LoginForm(
              key: args.key, onLoginCallback: args.onLoginCallback));
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig('/#redirect',
            path: '/', redirectTo: '/profiles', fullMatch: true),
        _i8.RouteConfig(ProfileListRoute.name, path: '/profiles'),
        _i8.RouteConfig(ProfilePageRoute.name, path: '/details/:id'),
        _i8.RouteConfig(NewsListRoute.name, path: '/news-list'),
        _i8.RouteConfig(PostFormRoute.name,
            path: '/create-post', guards: [routeGuard]),
        _i8.RouteConfig(GroupsListRoute.name, path: '/groups-list'),
        _i8.RouteConfig(GroupPageRoute.name, path: '/group/:id'),
        _i8.RouteConfig(LoginRoute.name, path: '/login')
      ];
}

/// generated route for
/// [_i1.ProfileList]
class ProfileListRoute extends _i8.PageRouteInfo<void> {
  const ProfileListRoute() : super(ProfileListRoute.name, path: '/profiles');

  static const String name = 'ProfileListRoute';
}

/// generated route for
/// [_i2.ProfilePage]
class ProfilePageRoute extends _i8.PageRouteInfo<ProfilePageRouteArgs> {
  ProfilePageRoute({_i9.Key? key, required String userId})
      : super(ProfilePageRoute.name,
            path: '/details/:id',
            args: ProfilePageRouteArgs(key: key, userId: userId),
            rawPathParams: {'id': userId});

  static const String name = 'ProfilePageRoute';
}

class ProfilePageRouteArgs {
  const ProfilePageRouteArgs({this.key, required this.userId});

  final _i9.Key? key;

  final String userId;

  @override
  String toString() {
    return 'ProfilePageRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i3.NewsList]
class NewsListRoute extends _i8.PageRouteInfo<void> {
  const NewsListRoute() : super(NewsListRoute.name, path: '/news-list');

  static const String name = 'NewsListRoute';
}

/// generated route for
/// [_i4.PostForm]
class PostFormRoute extends _i8.PageRouteInfo<PostFormRouteArgs> {
  PostFormRoute({_i9.Key? key, String? groupId})
      : super(PostFormRoute.name,
            path: '/create-post',
            args: PostFormRouteArgs(key: key, groupId: groupId));

  static const String name = 'PostFormRoute';
}

class PostFormRouteArgs {
  const PostFormRouteArgs({this.key, this.groupId});

  final _i9.Key? key;

  final String? groupId;

  @override
  String toString() {
    return 'PostFormRouteArgs{key: $key, groupId: $groupId}';
  }
}

/// generated route for
/// [_i5.GroupsList]
class GroupsListRoute extends _i8.PageRouteInfo<void> {
  const GroupsListRoute() : super(GroupsListRoute.name, path: '/groups-list');

  static const String name = 'GroupsListRoute';
}

/// generated route for
/// [_i6.GroupPage]
class GroupPageRoute extends _i8.PageRouteInfo<GroupPageRouteArgs> {
  GroupPageRoute({_i9.Key? key, required String groupId})
      : super(GroupPageRoute.name,
            path: '/group/:id',
            args: GroupPageRouteArgs(key: key, groupId: groupId),
            rawPathParams: {'id': groupId});

  static const String name = 'GroupPageRoute';
}

class GroupPageRouteArgs {
  const GroupPageRouteArgs({this.key, required this.groupId});

  final _i9.Key? key;

  final String groupId;

  @override
  String toString() {
    return 'GroupPageRouteArgs{key: $key, groupId: $groupId}';
  }
}

/// generated route for
/// [_i7.LoginForm]
class LoginRoute extends _i8.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i9.Key? key, required dynamic Function(bool) onLoginCallback})
      : super(LoginRoute.name,
            path: '/login',
            args: LoginRouteArgs(key: key, onLoginCallback: onLoginCallback));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, required this.onLoginCallback});

  final _i9.Key? key;

  final dynamic Function(bool) onLoginCallback;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLoginCallback: $onLoginCallback}';
  }
}
