import 'package:flutter/material.dart';
import 'package:foodapp/controllers/auth_controller.dart';
import 'package:foodapp/controllers/cart_controller.dart';
import 'package:foodapp/controllers/user_controller.dart';
import 'package:foodapp/routes/routes_helper.dart';
import 'package:foodapp/widgets/account_widget.dart';
import 'package:foodapp/widgets/app_icon.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userloggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userloggedIn) {
      Get.find<UserController>().getUserInfo();
      print("User has logged in");
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.tealAccent,
          title: BigText(
            text: "Profile",
            size: 24,
          ),
          centerTitle: true,
        ),
        body: GetBuilder<UserController>(
          builder: (userController) {
            return _userloggedIn
                ? (userController.isLoading
                    ? Container(
                        width: double.maxFinite,
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            // !profile icon
                            const AppIcon(
                              icon: Icons.person,
                              backgroundColor: Colors.tealAccent,
                              iconColor: Colors.white,
                              iconSize: 75,
                              size: 150,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    // !name
                                    AccountWidget(
                                        appIcon: const AppIcon(
                                          icon: Icons.person,
                                          backgroundColor: Colors.tealAccent,
                                          iconColor: Colors.white,
                                          iconSize: 25,
                                          size: 50,
                                        ),
                                        bigText: BigText(
                                            text:
                                                userController.userModel.name)),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // !phone
                                    AccountWidget(
                                        appIcon: const AppIcon(
                                          icon: Icons.phone,
                                          backgroundColor: Colors.yellow,
                                          iconColor: Colors.white,
                                          iconSize: 25,
                                          size: 50,
                                        ),
                                        bigText: BigText(
                                            text: userController
                                                .userModel.phone)),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // !email
                                    AccountWidget(
                                        appIcon: const AppIcon(
                                          icon: Icons.email,
                                          backgroundColor: Colors.yellow,
                                          iconColor: Colors.white,
                                          iconSize: 25,
                                          size: 50,
                                        ),
                                        bigText: BigText(
                                            text: userController
                                                .userModel.email)),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // !address
                                    AccountWidget(
                                        appIcon: const AppIcon(
                                          icon: Icons.location_on,
                                          backgroundColor: Colors.tealAccent,
                                          iconColor: Colors.white,
                                          iconSize: 25,
                                          size: 50,
                                        ),
                                        bigText: BigText(
                                            text: "Enter your address")),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // !messages
                                    AccountWidget(
                                        appIcon: const AppIcon(
                                          icon: Icons.message_outlined,
                                          backgroundColor: Colors.redAccent,
                                          iconColor: Colors.white,
                                          iconSize: 25,
                                          size: 50,
                                        ),
                                        bigText: BigText(text: "Messeges")),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (Get.find<AuthController>()
                                            .userLoggedIn()) {
                                          Get.find<AuthController>()
                                              .clearSharedData();
                                          Get.find<CartController>().clear();
                                          Get.find<CartController>()
                                              .clearCartHistory();
                                          Get.offNamed(
                                              RouteHelper.getSignInPage());
                                        }
                                      },
                                      child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.logout_outlined,
                                          backgroundColor: Colors.blue.shade900,
                                          iconColor: Colors.white,
                                          size: 50,
                                        ),
                                        bigText: BigText(
                                          text: "Logout",
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.blue.shade800,
                        )),
                      ))
                : Container(
                    child: Center(
                        child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: 160,
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/image/signintocontinue.png"))),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getSignInPage());
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: 160,
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: BigText(
                            text: "Sign in",
                            color: Colors.white,
                            size: 30,
                          )),
                        ),
                      )
                    ],
                  )));
          },
        ));
  }
}
