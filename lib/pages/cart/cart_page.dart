import 'package:flutter/material.dart';
import 'package:foodapp/base/no_data_page.dart';
import 'package:foodapp/controllers/cart_controller.dart';
import 'package:foodapp/controllers/popular_product_controller.dart';
import 'package:foodapp/controllers/recommended_product_controller.dart';
import 'package:foodapp/pages/home/main_home_page.dart';
import 'package:foodapp/routes/routes_helper.dart';
import 'package:foodapp/utils/app_constants.dart';
import 'package:foodapp/widgets/app_icon.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:foodapp/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: 60,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundColor: Colors.teal,
                      iconSize: 26,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouteHelper.getIntial());
                      },
                      child: const AppIcon(
                        icon: Icons.home,
                        iconColor: Colors.white,
                        backgroundColor: Colors.teal,
                        iconSize: 26,
                      ),
                    ),
                    const AppIcon(
                      icon: Icons.shopping_cart_outlined,
                      iconColor: Colors.white,
                      backgroundColor: Colors.teal,
                      iconSize: 26,
                    )
                  ],
                )),
            GetBuilder<CartController>(builder: (_cartController) {
              return _cartController.getItems.length > 0
                  ? Positioned(
                      top: 100,
                      left: 20,
                      right: 20,
                      bottom: 0,
                      child: Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: GetBuilder<CartController>(
                                builder: (cartContoller) {
                              var cartItems = cartContoller.getItems;
                              return ListView.builder(
                                  itemCount: cartItems.length,
                                  itemBuilder: (_, index) {
                                    return Container(
                                      width: double.maxFinite,
                                      height: 100,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              // !get the index of popular product
                                              var popularIndex = Get.find<
                                                      PopularProductController>()
                                                  .popularProductList
                                                  .indexOf(cartItems[index]
                                                      .product!);
                                              if (popularIndex >= 0) {
                                                // !navigate to popular product page
                                                Get.toNamed(
                                                    RouteHelper.getPopularFood(
                                                        popularIndex,
                                                        'cartPage'));
                                              } else {
                                                // !get the index of recommended product
                                                var recommendedIndex = Get.find<
                                                        RecommendedProductController>()
                                                    .recommendedProductList
                                                    .indexOf(cartItems[index]
                                                        .product!);

                                                // !navigate to recommended page
                                                if (recommendedIndex < 0) {
                                                  Get.snackbar("History List",
                                                      "No review for the history",
                                                      backgroundColor:
                                                          Colors.blue.shade900,
                                                      colorText: Colors.white);
                                                } else {
                                                  Get.toNamed(RouteHelper
                                                      .getRecommendedFood(
                                                          recommendedIndex,
                                                          "cartPage"));
                                                }
                                              }
                                            },
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          AppConstants
                                                                  .BASE_URL +
                                                              "/uploads/" +
                                                              cartContoller
                                                                  .getItems[
                                                                      index]
                                                                  .img!)),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                              child: Container(
                                            height: 100,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BigText(
                                                  text: cartContoller
                                                      .getItems[index].name!,
                                                  color: Colors.black54,
                                                ),
                                                SmallText(
                                                  text: "Spicy",
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    BigText(
                                                      text:
                                                          "Ksh. ${cartContoller.getItems[index].price!.toString()}",
                                                      color: Colors.redAccent,
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 10,
                                                              right: 1,
                                                              bottom: 10),
                                                      decoration: BoxDecoration(
                                                          color: Colors.black12,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Row(
                                                        children: [
                                                          // !adding decremental functionality
                                                          InkWell(
                                                              onTap: () {
                                                                cartContoller.addItem(
                                                                    cartItems[
                                                                            index]
                                                                        .product!,
                                                                    -1);
                                                              },
                                                              child: const Icon(
                                                                  Icons
                                                                      .remove)),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          BigText(
                                                              text: cartItems[
                                                                      index]
                                                                  .quantity
                                                                  .toString()), //popularProduct.inCartItems.toString()),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          // !adding quantity increment functionality

                                                          InkWell(
                                                              onTap: () {
                                                                // popularProduct.setQuantity(true);
                                                                cartContoller.addItem(
                                                                    cartItems[
                                                                            index]
                                                                        .product!,
                                                                    1);
                                                              },
                                                              child: const Icon(
                                                                  Icons.add))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    );
                                  });
                            })),
                      ))
                  : NoDataPage(text: "Your cart is empty");
            })
          ],
        ),
        // !bottom navigation
        bottomNavigationBar:
            GetBuilder<CartController>(builder: (cartController) {
          return Container(
            height: 120,
            padding:
                const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: cartController.getItems.length > 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, right: 20, bottom: 20),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            // !adding decremental functionality

                            const SizedBox(
                              width: 5,
                            ),
                            BigText(
                                text:
                                    "Ksh. ${cartController.totalAmount.toString()}"),
                            const SizedBox(
                              width: 5,
                            ),
                            // !adding quantity increment functionality
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          cartController.addToHistory();
                        },
                        child: Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20, bottom: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green.shade800),
                            child: const Text(
                              "Check out",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),
                      )
                    ],
                  )
                : Container(),
          );
        }));
  }
}
