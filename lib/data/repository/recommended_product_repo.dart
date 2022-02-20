import 'package:foodapp/data/api/api_client.dart';
import 'package:foodapp/utils/app_constants.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});

  // !function that gets the recommended product list
  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCTS_URI);
  }
}
