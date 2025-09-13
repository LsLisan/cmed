import 'package:get/get.dart';
import '../bindings/auth_bindings.dart';
import '../bindings/article_binding.dart';
import '../bindings/settings_binding.dart';
import '../middlewares/auth_middleware.dart';

import '../views/login_view.dart';
import '../views/article_list_view.dart';
import '../views/article_details_view.dart';
import '../views/settings_view.dart';

class AppRoutes {
  static const login = '/login';
  static const articles = '/articles';
  static const articleDetails = '/article-details';
  static const settings = '/settings';

  static final routes = [
    GetPage(
      name: login,
      page: () =>  LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: articles,
      page: () =>  ArticleListView(),
      binding: ArticleBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: articleDetails,
      page: () => const ArticleDetailsView(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: settings,
      page: () =>  SettingsView(),
      binding: SettingsBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
