import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodapp/base/no_data_page.dart';
import 'package:foodapp/controllers/cart_controller.dart';
import 'package:foodapp/models/cart_model.dart';
import 'package:foodapp/routes/routes_helper.dart';
import 'package:foodapp/utils/app_constants.dart';
import 'package:foodapp/widgets/app_icon.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:foodapp/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    print('the length of the list is' + getCartHistoryList.length.toString());

    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartItemOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartItemTimeOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> orderTimes = cartItemOrderToList();
    var listCounter = 0;

    Widget timedWidget(int index) {
      var outPutDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outPutFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outPutFormat.format(inputDate);
      }
      return BigText(text: outPutDate);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            color: Colors.teal.shade700,
            width: double.maxFinite,
            padding: const EdgeInsets.only(top: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(
                  text: "Cart History",
                  color: Colors.white,
                ),
                const AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: Colors.teal,
                )
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cart) {
            return _cart.getCartHistoryList().length > 0
                ? Expanded(
                    child: Container(
                        margin:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView(
                            children: [
                              for (int i = 0; i < orderTimes.length; i++)
                                Container(
                                  height: 120,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      timedWidget(listCounter),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Wrap(
                                              direction: Axis.horizontal,
                                              children: List.generate(
                                                  orderTimes[i], (index) {
                                                if (listCounter <
                                                    getCartHistoryList.length) {
                                                  listCounter++;
                                                }
                                                return index <= 2
                                                    ? Container(
                                                        height: 70,
                                                        width: 70,
                                                        margin: const EdgeInsets
                                                            .only(right: 5),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(AppConstants
                                                                        .BASE_URL +
                                                                    "/uploads/" +
                                                                    getCartHistoryList[
                                                                            listCounter -
                                                                                1]
                                                                        .img!))),
                                                      )
                                                    : Container();
                                              }),
                                            ),
                                            Container(
                                              height: 80,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  SmallText(
                                                    text: "Total",
                                                    size: 14,
                                                  ),
                                                  BigText(
                                                    text: orderTimes[i]
                                                            .toString() +
                                                        " items",
                                                    color: Colors.black,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      var orderTime =
                                                          cartItemTimeOrderToList();
                                                      Map<int, CartModel>
                                                          moreItems = {};
                                                      for (int j = 0;
                                                          j <
                                                              getCartHistoryList
                                                                  .length;
                                                          j++) {
                                                        if (getCartHistoryList[
                                                                    j]
                                                                .time ==
                                                            orderTime[i]) {
                                                          moreItems.putIfAbsent(
                                                              getCartHistoryList[
                                                                      j]
                                                                  .id!,
                                                              () => CartModel.fromJson(
                                                                  jsonDecode(jsonEncode(
                                                                      getCartHistoryList[
                                                                          i]))));
                                                        }
                                                      }
                                                      var cartController =
                                                          Get.find<
                                                              CartController>();
                                                      cartController.setItems =
                                                          moreItems;

                                                      cartController
                                                          .addToCartList();
                                                      Get.toNamed(RouteHelper
                                                          .getCartPage());
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5,
                                                          horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              width: 1,
                                                              color:
                                                                  Colors.teal)),
                                                      child: SmallText(
                                                        text: "One more",
                                                        color: Colors.teal,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ])
                                    ],
                                  ),
                                )
                            ],
                          ),
                        )),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height / 1.75,
                    child: const NoDataPage(
                      text: "You have not ordered anything",
                      imgPath: "assets/image/empty_box.png",
                    ),
                  );
          })
        ],
      ),
    );
  }
}
