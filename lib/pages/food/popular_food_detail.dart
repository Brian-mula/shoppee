import 'package:flutter/material.dart';
import 'package:foodapp/widgets/app_icon.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:foodapp/widgets/expandable_text_widget.dart';

class PopularFoodDetails extends StatelessWidget {
  const PopularFoodDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 350,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2020/04/29/03/30/pizza-5107039__340.jpg'))),
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
                        Navigator.pop(context);
                      },
                      child: const AppIcon(icon: Icons.arrow_back_ios)),
                  const AppIcon(icon: Icons.shopping_cart_outlined)
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
                    BigText(text: "BIRIANI"),
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
                          style: TextStyle(fontSize: 13, color: Colors.black45),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "1281 comments",
                          style: TextStyle(fontSize: 13, color: Colors.black38),
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
                          rowIconText(Icons.location_on, '12 Km', Colors.teal),
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
                    const Expanded(
                      child: SingleChildScrollView(
                        child: ExpandebleTextWidget(
                          text:
                              'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using , making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for  will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsu',
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
      bottomNavigationBar: Container(
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
                  const Icon(Icons.remove),
                  const SizedBox(
                    width: 5,
                  ),
                  BigText(text: "0"),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(Icons.add)
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black12),
              child: BigText(text: "Ksh. 0"),
            ),
            Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade900),
                child: const Icon(
                  Icons.add_shopping_cart_sharp,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
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
