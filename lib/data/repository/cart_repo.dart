import 'dart:convert';

import 'package:foodapp/models/cart_model.dart';
import 'package:foodapp/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  // !list of items to be stored locally
  List<String> cart = [];
  List<String> cartHistory = [];
  void addToCartList(List<CartModel> cartList) {
    //sharedPreferences.remove(AppConstants.CART_LIST);
    //sharedPreferences.remove(AppConstants.CART_HISTORY);
    var time = DateTime.now().toString();
    cart = [];
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList("Cart-list", cart);
  }

  List<CartModel> getCartList() {
    List<CartModel> cartList = [];
    List<String> carts = [];
    if (sharedPreferences.containsKey("Cart-list")) {
      carts = sharedPreferences.getStringList("Cart-list")!;
    }
    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey("cart-history-list")) {
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList("cart-history-list")!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey("cart-history-list")) {
      cartHistory = sharedPreferences.getStringList("cart-history-list")!;
    }
    for (int i = 0; i < cart.length; i++) {
      print("History List" + cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList("cart-history-list", cartHistory);
    print("the length of the history list is" +
        getCartHistoryList().length.toString());
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove('Cart-list');
  }

//!to be added to the cart history code
  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    sharedPreferences.remove("cart-history-list");
  }
}
