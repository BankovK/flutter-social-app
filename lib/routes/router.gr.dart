// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../screens/loginForm.dart' as _i5;
import '../screens/post/postForm.dart' as _i4;
import '../screens/post/postsList.dart' as _i3;
import '../screens/profile.dart' as _i2;
import '../screens/profileList.dart' as _i1;
import '../utils/route_guard.dart' as _i8;

class AppRouter extends _i6.RootStackRouter {
  AppRouter(
      {_i7.GlobalKey<_i7.NavigatorState>? navigatorKey,
      required this.routeGuard})
      : super(navigatorKey);

  final _i8.RouteGuard routeGuard;

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    ProfileListRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.ProfileList());
    },
    ProfilePageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.ProfilePage());
    },
    NewsListRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.NewsList());
    },
    PostFormRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.PostForm());
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.LoginForm(
              key: args.key, onLoginCallback: args.onLoginCallback));
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig('/#redirect',
            path: '/', redirectTo: '/profiles', fullMatch: true),
        _i6.RouteConfig(ProfileListRoute.name,
            path: '/profiles', guards: [routeGuard]),
        _i6.RouteConfig(ProfilePageRoute.name,
            path: '/details', guards: [routeGuard]),
        _i6.RouteConfig(NewsListRoute.name,
            path: '/news-list', guards: [routeGuard]),
        _i6.RouteConfig(PostFormRoute.name,
            path: '/create-post', guards: [routeGuard]),
        _i6.RouteConfig(LoginRoute.name, path: '/login')
      ];
}

/// generated route for
/// [_i1.ProfileList]
class ProfileListRoute extends _i6.PageRouteInfo<void> {
  const ProfileListRoute() : super(ProfileListRoute.name, path: '/profiles');

  static const String name = 'ProfileListRoute';
}

/// generated route for
/// [_i2.ProfilePage]
class ProfilePageRoute extends _i6.PageRouteInfo<void> {
  const ProfilePageRoute() : super(ProfilePageRoute.name, path: '/details');

  static const String name = 'ProfilePageRoute';
}

/// generated route for
/// [_i3.NewsList]
class NewsListRoute extends _i6.PageRouteInfo<void> {
  const NewsListRoute() : super(NewsListRoute.name, path: '/news-list');

  static const String name = 'NewsListRoute';
}

/// generated route for
/// [_i4.PostForm]
class PostFormRoute extends _i6.PageRouteInfo<void> {
  const PostFormRoute() : super(PostFormRoute.name, path: '/create-post');

  static const String name = 'PostFormRoute';
}

/// generated route for
/// [_i5.LoginForm]
class LoginRoute extends _i6.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i7.Key? key, required dynamic Function(bool) onLoginCallback})
      : super(LoginRoute.name,
            path: '/login',
            args: LoginRouteArgs(key: key, onLoginCallback: onLoginCallback));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, required this.onLoginCallback});

  final _i7.Key? key;

  final dynamic Function(bool) onLoginCallback;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLoginCallback: $onLoginCallback}';
  }
}
