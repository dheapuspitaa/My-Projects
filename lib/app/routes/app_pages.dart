import 'package:get/get.dart';

import '../modules/add_recipe/bindings/add_recipe_binding.dart';
import '../modules/add_recipe/views/add_recipe_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_RECIPE,
      page: () => AddRecipeView(),
      binding: AddRecipeBinding(),
    ),
  ];
}
