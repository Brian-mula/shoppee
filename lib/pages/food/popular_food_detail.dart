import 'package:flutter/material.dart';
import 'package:foodapp/controllers/cart_controller.dart';
import 'package:foodapp/controllers/popular_product_controller.dart';
import 'package:foodapp/pages/cart/cart_page.dart';
import 'package:foodapp/routes/routes_helper.dart';
import 'package:foodapp/utils/app_constants.dart';
import 'package:foodapp/widgets/app_icon.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:foodapp/widgets/expandable_text_widget.dart';
import "package:get/get.dart";

class PopularFoodDetails extends StatelessWidget {
  int pageId;
  PopularFoodDetails({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initialProduct(product, Get.find<CartController>());

    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 350,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(AppConstants.BASE_URL +
                              "/uploads/" +
                              product.img!))),
                )),
            Positioned(
                top: 45,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // !navigation section
                    InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelper.getIntial());
                        },
                        child: const AppIcon(icon: Icons.arrow_back_ios)),
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
                )),
            //  !content and description of the item
            Positioned(
                left: 0,
                right: 0,
                top: 330,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: product.name!),
                      const SizedBox(
                        height: 5,
                      ),

                      //  !row of ratings
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(
                                5,
                                (index) => const Icon(
                                      Icons.star_outline,
                                      size: 20,
                                      color: Colors.teal,
                                    )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            '4.2',
                            style:
                                TextStyle(fontSize: 13, color: Colors.black45),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "1281 comments",
                            style:
                                TextStyle(fontSize: 13, color: Colors.black38),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            rowIconText(Icons.circle, "Normal", Colors.yellow),
                            rowIconText(
                                Icons.location_on, '12 Km', Colors.teal),
                            rowIconText(
                                Icons.timer_outlined, '32 mins', Colors.pink)
                          ]),
                      const SizedBox(
                        height: 10,
                      ),

                      BigText(
                        text: "Description",
                        size: 20,
                      ),
                      // !text messages from db
                      Expanded(
                        child: SingleChildScrollView(
                          child:
                              ExpandebleTextWidget(text: product.description!),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (popularProduct) {
          return Container(
            height: 120,
            padding:
                const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Row(
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
                      InkWell(
                          onTap: () {
                            popularProduct.setQuantity(false);
                          },
                          child: const Icon(Icons.remove)),
                      const SizedBox(
                        width: 5,
                      ),
                      BigText(text: popularProduct.inCartItems.toString()),
                      const SizedBox(
                        width: 5,
                      ),
                      // !adding quantity increment functionality

                      InkWell(
                          onTap: () {
                            popularProduct.setQuantity(true);
                          },
                          child: const Icon(Icons.add))
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black12),
                  child: BigText(text: "Ksh. ${product.price}"),
                ),
                InkWell(
                  onTap: () {
                    popularProduct.addItem(product);
                  },
                  child: Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue.shade900),
                      child: const Icon(
                        Icons.add_shopping_cart_sharp,
                        color: Colors.white,
                      )),
                )
              ],
            ),
          );
        }));
  }

  Row rowIconText(IconData icon, String text, Color iconColor) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 20,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 13, color: Colors.black38),
        )
      ],
    );
  }
}
