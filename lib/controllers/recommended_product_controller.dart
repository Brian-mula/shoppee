import 'package:foodapp/data/repository/recommended_product_repo.dart';
import 'package:foodapp/models/product_models.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;
  // !boolean to check if the products are loaded
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    print(response.statusCode);
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
    }
  }
}
