import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rencber_mobile/core/widget/navbar/navbar.dart';
import 'package:rencber_mobile/features/advice/view/advice_details.dart';
import 'package:rencber_mobile/features/advice/view/advices.dart';
import 'package:rencber_mobile/features/advice/view/brand_details.dart';
import 'package:rencber_mobile/features/advice/view/brands.dart';
import 'package:rencber_mobile/features/error.dart';
import 'package:rencber_mobile/features/fields/view/add_field.dart';
import 'package:rencber_mobile/features/fields/view/edit_field.dart';
import 'package:rencber_mobile/features/login/view/login.dart';
import 'package:rencber_mobile/features/news/view/news_details.dart';
import 'package:rencber_mobile/features/notification/view/notification_view.dart';
import 'package:rencber_mobile/features/profile/view/about.dart';
import 'package:rencber_mobile/features/profile/view/kvkk.dart';
import 'package:rencber_mobile/features/profile/view/notification.dart';
import 'package:rencber_mobile/features/profile/view/profile_edit.dart';
import 'package:rencber_mobile/features/register/view/register.dart';
import 'package:rencber_mobile/features/splash/view/splash.dart';
import 'package:rencber_mobile/features/valide/view/valide_code.dart';
import 'package:rencber_mobile/product/models/advice/advice_response.dart';
import 'package:rencber_mobile/product/models/field/field_response.dart';
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
  static const about = '/about';
  static const kvkk = '/kvkk';
  static const brandList = '/brandList';
  static const brandDetails = '/brandDetails';
  static const advices = '/advices';
  static const adviceDetails = '/adviceDetails';
  static const addField = '/addField';
  static const editField = '/editField';
  static const notification = '/notification';

  static Widget _splashRoute(BuildContext context, GoRouterState state) => const SplashView();
  static Widget _homeRoute(BuildContext context, GoRouterState state) => const Navbar();
  static Widget _loginRoute(BuildContext context, GoRouterState state) => const LoginView();
  static Widget _registerRoute(BuildContext context, GoRouterState state) => const RegisterView();
  static Widget _phoneCodeRoute(BuildContext context, GoRouterState state) => ValideCodeView(phoneNumber: state.extra as String);
  static Widget _newsDetailsRoute(BuildContext context, GoRouterState state) => NewsDetailsView(id: state.extra as int);
  static Widget _profileEditRoute(BuildContext context, GoRouterState state) => ProfileEditView(userResponse: state.extra as UserResponseModel);
  static Widget _notificationUserRoute(BuildContext context, GoRouterState state) => NotificationSettingView(userResponse: state.extra as UserResponseModel);
  static Widget _aboutRoute(BuildContext context, GoRouterState state) => const AboutSettingView();
  static Widget _kvkkRoute(BuildContext context, GoRouterState state) => const KvkkView();
  static Widget _brandListRoute(BuildContext context, GoRouterState state) => BrandListView(adviceList: state.extra as List<AdviceResponseModel>);
  static Widget _brandDetailsRoute(BuildContext context, GoRouterState state) => BrandDetailsView(brandId: state.extra as int);
  static Widget _advicesRoute(BuildContext context, GoRouterState state) => AdvicesView(adviceList: state.extra as List<AdviceResponseModel>);
  static Widget _adviceDetailsRoute(BuildContext context, GoRouterState state) => AdviceDetailsView(adviceId: state.extra as int);
  static Widget _addFieldRoute(BuildContext context, GoRouterState state) => const FieldAddView();
  static Widget _editFieldRoute(BuildContext context, GoRouterState state) => FieldEditView(fieldData: state.extra as FieldResponseModel);
  static Widget _notificationRoute(BuildContext context, GoRouterState state) => const NotificationView();


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
      GoRoute(path: notificationSetting, builder: _notificationUserRoute),
      GoRoute(path: about, builder: _aboutRoute),
      GoRoute(path: kvkk, builder: _kvkkRoute),
      GoRoute(path: brandList, builder: _brandListRoute),
      GoRoute(path: brandDetails, builder: _brandDetailsRoute),
      GoRoute(path: advices, builder: _advicesRoute),
      GoRoute(path: adviceDetails, builder: _adviceDetailsRoute),
      GoRoute(path: addField, builder: _addFieldRoute),
      GoRoute(path: editField, builder: _editFieldRoute),
      GoRoute(path: notification, builder: _notificationRoute),
    ],
  );

  static final RouterManager _instance = RouterManager._();
  static RouterManager get instance => _instance;
  GoRouter get router => _router;
}
