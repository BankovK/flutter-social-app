// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../screens/loginForm.dart' as _i3;
import '../screens/profile.dart' as _i2;
import '../screens/profileList.dart' as _i1;
import '../utils/route_guard.dart' as _i6;

class AppRouter extends _i4.RootStackRouter {
  AppRouter(
      {_i5.GlobalKey<_i5.NavigatorState>? navigatorKey,
      required this.routeGuard})
      : super(navigatorKey);

  final _i6.RouteGuard routeGuard;

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    ProfileListRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.ProfileList());
    },
    ProfilePageRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.ProfilePage());
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.LoginForm(
              key: args.key, onLoginCallback: args.onLoginCallback));
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig('/#redirect',
            path: '/', redirectTo: '/profiles', fullMatch: true),
        _i4.RouteConfig(ProfileListRoute.name,
            path: '/profiles', guards: [routeGuard]),
        _i4.RouteConfig(ProfilePageRoute.name,
            path: 'details', guards: [routeGuard]),
        _i4.RouteConfig(LoginRoute.name, path: '/login')
      ];
}

/// generated route for
/// [_i1.ProfileList]
class ProfileListRoute extends _i4.PageRouteInfo<void> {
  const ProfileListRoute() : super(ProfileListRoute.name, path: '/profiles');

  static const String name = 'ProfileListRoute';
}

/// generated route for
/// [_i2.ProfilePage]
class ProfilePageRoute extends _i4.PageRouteInfo<void> {
  const ProfilePageRoute() : super(ProfilePageRoute.name, path: 'details');

  static const String name = 'ProfilePageRoute';
}

/// generated route for
/// [_i3.LoginForm]
class LoginRoute extends _i4.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i5.Key? key, required dynamic Function(bool) onLoginCallback})
      : super(LoginRoute.name,
            path: '/login',
            args: LoginRouteArgs(key: key, onLoginCallback: onLoginCallback));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, required this.onLoginCallback});

  final _i5.Key? key;

  final dynamic Function(bool) onLoginCallback;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLoginCallback: $onLoginCallback}';
  }
}
