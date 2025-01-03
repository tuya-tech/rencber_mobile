import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rencber_mobile/core/widget/navbar/navbar.dart';
import 'package:rencber_mobile/features/error.dart';
import 'package:rencber_mobile/features/login/view/login.dart';
import 'package:rencber_mobile/features/news/view/news_details.dart';
import 'package:rencber_mobile/features/profile/view/notification.dart';
import 'package:rencber_mobile/features/profile/view/profile_edit.dart';
import 'package:rencber_mobile/features/register/view/register.dart';
import 'package:rencber_mobile/features/splash/view/splash.dart';
import 'package:rencber_mobile/features/valide/view/valide_code.dart';
import 'package:rencber_mobile/product/models/user/user_response.dart';

class RouterManager {
  RouterManager._();
  static const root = '/';
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const phoneCode = '/phoneCode';
  static const newsDetails = '/newsDetails';
  static const profileEdit = '/profileEdit';
  static const notificationSetting = '/notificationSetting';

  static Widget _splashRoute(BuildContext context, GoRouterState state) => const SplashView();
  static Widget _homeRoute(BuildContext context, GoRouterState state) => const Navbar();
  static Widget _loginRoute(BuildContext context, GoRouterState state) => const LoginView();
  static Widget _registerRoute(BuildContext context, GoRouterState state) => const RegisterView();
  static Widget _phoneCodeRoute(BuildContext context, GoRouterState state) => ValideCodeView(phoneNumber: state.extra as String);
  static Widget _newsDetailsRoute(BuildContext context, GoRouterState state) => NewsDetailsView(id: state.extra as int);
  static Widget _profileEditRoute(BuildContext context, GoRouterState state) => ProfileEditView(userResponse: state.extra as UserResponseModel);
  static Widget _notificationRoute(BuildContext context, GoRouterState state) => NotificationSettingView(userResponse: state.extra as UserResponseModel);

  static Widget _errorRoute(BuildContext context, GoRouterState state) => const ErrorView();

  final GoRouter _router = GoRouter(
    errorBuilder: _errorRoute,
    routes: <RouteBase>[
      GoRoute(path: root, builder: _splashRoute),
      GoRoute(path: home, builder: _homeRoute),
      GoRoute(path: login, builder: _loginRoute),
      GoRoute(path: register, builder: _registerRoute),
      GoRoute(path: phoneCode, builder: _phoneCodeRoute),
      GoRoute(path: newsDetails, builder: _newsDetailsRoute),
      GoRoute(path: profileEdit, builder: _profileEditRoute),
      GoRoute(path: notificationSetting, builder: _notificationRoute),
    ],
  );

  static final RouterManager _instance = RouterManager._();
  static RouterManager get instance => _instance;
  GoRouter get router => _router;
}
