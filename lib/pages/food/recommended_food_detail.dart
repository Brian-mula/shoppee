import 'package:flutter/material.dart';
import 'package:foodapp/controllers/cart_controller.dart';
import 'package:foodapp/controllers/popular_product_controller.dart';
import 'package:foodapp/controllers/recommended_product_controller.dart';
import 'package:foodapp/pages/cart/cart_page.dart';
import 'package:foodapp/routes/routes_helper.dart';
import 'package:foodapp/utils/app_constants.dart';
import 'package:foodapp/widgets/app_icon.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:foodapp/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class RecommendedFoodDetails extends StatelessWidget {
  int pageId;
  RecommendedFoodDetails({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initialProduct(product, Get.find<CartController>());

    print(product.name);
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 70,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () => Get.toNamed(RouteHelper.getIntial()),
                      child: const AppIcon(icon: Icons.clear)),
                  //const AppIcon(icon: Icons.shopping_cart_outlined)
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return Stack(
                      children: [
                        const AppIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => const CartPage());
                                  },
                                  child: const AppIcon(
                                      icon: Icons.circle,
                                      iconColor: Colors.transparent,
                                      size: 20,
                                      backgroundColor: Colors.blue),
                                ),
                              )
                            : Container(),
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                right: 3,
                                top: 3,
                                child: BigText(
                                  text: Get.find<PopularProductController>()
                                      .totalItems
                                      .toString(),
                                  size: 12,
                                  color: Colors.white,
                                ),
                              )
                            : Container()
                      ],
                    );
                  })
                ],
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  // !product name goes here
                  child: Center(child: BigText(text: product.name!)),
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                ),
              ),
              pinned: true,
              backgroundColor: Colors.yellow,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  // !product image goes here
                  AppConstants.BASE_URL + "/uploads/" + product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: ExpandebleTextWidget(
                    // !product description goes here
                    text: product.description!,
                  ),
                )
              ],
            )),
          ],
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (recommendedFood) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        recommendedFood.setQuantity(false);
                      },
                      child: const AppIcon(
                        icon: Icons.remove,
                        backgroundColor: Colors.teal,
                        iconColor: Colors.white,
                        iconSize: 25,
                      ),
                    ),
                    BigText(
                        text:
                            "Ksh.${product.price!} X ${recommendedFood.inCartItems}"),
                    InkWell(
                      onTap: () {
                        recommendedFood.setQuantity(true);
                      },
                      child: const AppIcon(
                        icon: Icons.add,
                        backgroundColor: Colors.teal,
                        iconColor: Colors.white,
                        iconSize: 25,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, right: 20, left: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: const AppIcon(icon: Icons.favorite),
                    ),
                    Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, right: 10, left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: BigText(text: "Ksh. ${product.price}")),
                    InkWell(
                      onTap: () {
                        recommendedFood.addItem(product);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, right: 10, left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue.shade900),
                        child: const AppIcon(icon: Icons.add_shopping_cart),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }));
  }
}
