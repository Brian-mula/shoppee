import 'package:foodapp/data/api/api_client.dart';
import 'package:foodapp/utils/app_constants.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCTS_URI);
  }
}
