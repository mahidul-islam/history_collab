import 'package:get/get.dart';

import '../modules/article/bindings/article_binding.dart';
import '../modules/article/views/article_view.dart';
import '../modules/entry/bindings/entry_binding.dart';
import '../modules/entry/views/entry_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

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
  ];
}
