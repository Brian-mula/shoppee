import 'package:foodapp/pages/food/popular_food_detail.dart';
import 'package:foodapp/pages/food/recommended_food_detail.dart';
import 'package:foodapp/pages/home/main_home_page.dart';

import 'package:get/get.dart';

class RouteHelper {
  // ?routes initialization
  static const String initial = "/";
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';

  // ?section for route functions
  static String getIntial() => "$initial";
  static String getPopularFood(int pageId) => "$popularFood?pageId=$pageId";
  static String getRecommendedFood(int pageId) =>
      "$recommendedFood?pageId=$pageId";

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const MainHomePage()),
    // !popular product route
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          return PopularFoodDetails(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn),
    // !recommended product route
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          return RecommendedFoodDetails(
            pageId: int.parse(pageId!),
          );
        },
        transition: Transition.fadeIn)
  ];
}
