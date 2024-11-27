import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rencber_mobile/core/widget/navbar/navbar.dart';
import 'package:rencber_mobile/features/error.dart';
import 'package:rencber_mobile/features/login/view/login.dart';
import 'package:rencber_mobile/features/register/view/register.dart';
import 'package:rencber_mobile/features/splash/view/splash.dart';
import 'package:rencber_mobile/features/valide/view/valide_code.dart';

class RouterManager {
  RouterManager._();
  static const root = '/';
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const phoneCode = '/phoneCode';

  static Widget _splashRoute(BuildContext context, GoRouterState state) => const SplashView();
  static Widget _homeRoute(BuildContext context, GoRouterState state) => const Navbar();
  static Widget _loginRoute(BuildContext context, GoRouterState state) => const LoginView();
  static Widget _registerRoute(BuildContext context, GoRouterState state) => const RegisterView();
  static Widget _phoneCodeRoute(BuildContext context, GoRouterState state) => const ValideCodeView();
  static Widget _errorRoute(BuildContext context, GoRouterState state) => const ErrorView();

  final GoRouter _router = GoRouter(
    errorBuilder: _errorRoute,
    routes: <RouteBase>[
      GoRoute(path: root, builder: _splashRoute),
      GoRoute(path: home, builder: _homeRoute),
      GoRoute(path: login, builder: _loginRoute),
      GoRoute(path: register, builder: _registerRoute),
      GoRoute(path: phoneCode, builder: _phoneCodeRoute),
    ],
  );

  static final RouterManager _instance = RouterManager._();
  static RouterManager get instance => _instance;
  GoRouter get router => _router;
}
