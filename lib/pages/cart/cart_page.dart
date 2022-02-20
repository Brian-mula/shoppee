import 'package:flutter/material.dart';
import 'package:foodapp/controllers/cart_controller.dart';
import 'package:foodapp/pages/home/main_home_page.dart';
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
                      Get.to(() => const MainHomePage());
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
          Positioned(
              top: 100,
              left: 20,
              right: 20,
              bottom: 0,
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder: (cartContoller) {
                      return ListView.builder(
                          itemCount: cartContoller.getItems.length,
                          itemBuilder: (_, index) {
                            return Container(
                              width: double.maxFinite,
                              height: 100,
                              child: Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                AppConstants.BASE_URL +
                                                    "/uploads/" +
                                                    cartContoller
                                                        .getItems[index].img!)),
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                              text:
                                                  "Ksh. ${cartContoller.getItems[index].price!.toString()}",
                                              color: Colors.redAccent,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  left: 10,
                                                  right: 1,
                                                  bottom: 10),
                                              decoration: BoxDecoration(
                                                  color: Colors.black12,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Row(
                                                children: [
                                                  // !adding decremental functionality
                                                  InkWell(
                                                      onTap: () {
                                                        //popularProduct.setQuantity(false);
                                                      },
                                                      child: const Icon(
                                                          Icons.remove)),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  BigText(
                                                      text:
                                                          '0'), //popularProduct.inCartItems.toString()),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  // !adding quantity increment functionality

                                                  InkWell(
                                                      onTap: () {
                                                        // popularProduct.setQuantity(true);
                                                      },
                                                      child:
                                                          const Icon(Icons.add))
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
        ],
      ),
    );
  }
}
