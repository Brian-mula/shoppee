import 'package:flutter/material.dart';
import 'package:foodapp/controllers/cart_controller.dart';
import 'package:foodapp/data/repository/popular_product_repo.dart';
import 'package:foodapp/models/cart_model.dart';
import 'package:foodapp/models/product_models.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;
  late CartController _cart;

  // !set boolean to check if products have been loaded
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    print(response.statusCode);
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;

      update();
    } else {
      print("error getting products");
    }
  }

// ! increment and decrement of product

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Item count", "You can't reduce anymore",
          backgroundColor: Colors.blue.shade900,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if (_inCartItems + quantity > 20) {
      Get.snackbar("Item count", "You've reached maximum quantity",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return 20;
    } else {
      return quantity;
    }
  }

  void initialProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existsInCart(product);
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    // !check if the product exists in the local storage
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);

    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
