import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/controllers/popular_product_controller.dart';
import 'package:foodapp/controllers/recommended_product_controller.dart';
import 'package:foodapp/models/product_models.dart';
import 'package:foodapp/pages/food/popular_food_detail.dart';
import 'package:foodapp/pages/food/recommended_food_detail.dart';
import 'package:foodapp/routes/routes_helper.dart';
import 'package:foodapp/utils/app_constants.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:foodapp/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);

  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //! slider section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
                  height: 320,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, index) {
                        return _buildPageItem(
                            index, popularProducts.popularProductList[index]);
                      }),
                )
              : const CircularProgressIndicator(
                  color: Colors.pink,
                );
        }),
        //! dots section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
              dotsCount: popularProducts.popularProductList.isEmpty
                  ? 1
                  : popularProducts.popularProductList.length,
              position: _currPageValue);
        }),
        // popular text
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.only(left: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(
                text: "Recommended",
                color: Colors.black87,
              ),
              // !the dot indicator
              const SizedBox(
                width: 10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black45,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              //  !food pairing content
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: const Text(
                  "Food pairing",
                  style: TextStyle(fontSize: 12, color: Colors.black38),
                ),
              )
            ],
          ),
        ),
        // !list of images and their texts
        GetBuilder<RecommendedProductController>(
            builder: (recommendeProductList) {
          return recommendeProductList.isLoaded
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      recommendeProductList.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // ! navigate tp recommended product details
                        Get.toNamed(
                            RouteHelper.getRecommendedFood(index, 'home'));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white38,
                                  image: DecorationImage(
                                    image: NetworkImage(AppConstants.BASE_URL +
                                        "/uploads/" +
                                        recommendeProductList
                                            .recommendedProductList[index]
                                            .img!),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            //  !text section
                            Expanded(
                              child: Container(
                                height: 100,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(
                                          text: recommendeProductList
                                              .recommendedProductList[index]
                                              .name!),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        "With Kenyan taste",
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 14),
                                      ),
                                      // !icontext elements
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          textIcon(Icons.circle, 'Normal',
                                              Colors.yellow),
                                          textIcon(Icons.location_on, "1.7Km",
                                              Colors.teal.shade200),
                                          textIcon(Icons.timer_sharp, '32 mins',
                                              Colors.pink)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : const CircularProgressIndicator(
                  color: Colors.pink,
                );
        })
      ],
    );
  }

  Row textIcon(IconData icon, String text, Color iconColor) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: iconColor,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: Colors.black45),
        )
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix4 = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, 'home'));
            },
            child: Container(
              height: 220,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xFF69c5df),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URL +
                          "/uploads/" +
                          popularProduct.img!))),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 110,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: popularProduct.name!,
                      color: Colors.black54,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                              popularProduct.stars!,
                              (index) => const Icon(
                                    Icons.star_outline,
                                    color: Colors.teal,
                                    size: 15,
                                  )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "4.5",
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "1287",
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Comments",
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        iconText(Icons.circle, 'Normal', Colors.yellow),
                        const SizedBox(
                          width: 10,
                        ),
                        iconText(
                            Icons.location_on, '1.7 Km', Colors.teal.shade300),
                        const SizedBox(
                          width: 10,
                        ),
                        iconText(Icons.watch_later_sharp, "32 min", Colors.pink)
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Row iconText(IconData icon, String text, Color iconColor) {
  return Row(
    children: [
      Icon(
        icon,
        color: iconColor,
        size: 15,
      ),
      Text(
        text,
        style: const TextStyle(fontSize: 12, color: Colors.black38),
      )
    ],
  );
}
