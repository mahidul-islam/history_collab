import 'package:get/get.dart';

import '../modules/article/bindings/article_binding.dart';
import '../modules/article/views/article_view.dart';
import '../modules/entry/bindings/entry_binding.dart';
import '../modules/entry/views/entry_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/list/bindings/list_binding.dart';
import '../modules/list/views/list_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LIST;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ARTICLE,
      page: () => const ArticleView(),
      binding: ArticleBinding(),
    ),
    GetPage(
      name: _Paths.ENTRY,
      page: () => const EntryView(),
      binding: EntryBinding(),
    ),
    GetPage(
      name: _Paths.LIST,
      page: () => const ListView(),
      binding: ListBinding(),
    ),
  ];
}
