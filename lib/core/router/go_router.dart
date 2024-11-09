import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rencber_mobile/features/error.dart';
import 'package:rencber_mobile/features/home/view/home.dart';
import 'package:rencber_mobile/features/login/view/login.dart';
import 'package:rencber_mobile/features/splash/view/splash.dart';

class RouterManager {
  RouterManager._();
  static const root = '/';
  static const home = '/home';
  static const login = '/login';

  static Widget _splashRoute(BuildContext context, GoRouterState state) => const SplashView();
  static Widget _homeRoute(BuildContext context, GoRouterState state) => const HomeView();
  static Widget _loginRoute(BuildContext context, GoRouterState state) => const LoginView();
  static Widget _errorRoute(BuildContext context, GoRouterState state) => const ErrorView();

  final GoRouter _router = GoRouter(
    errorBuilder: _errorRoute,
    routes: <RouteBase>[
      GoRoute(path: root, builder: _splashRoute),
      GoRoute(path: home, builder: _homeRoute),
      GoRoute(path: login, builder: _loginRoute),
    ],
  );

  static final RouterManager _instance = RouterManager._();
  static RouterManager get instance => _instance;
  GoRouter get router => _router;
}
