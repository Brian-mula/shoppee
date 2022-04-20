import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/base/show_custom_message.dart';
import 'package:foodapp/controllers/auth_controller.dart';
import 'package:foodapp/pages/auth/sign_up_page.dart';
import 'package:foodapp/routes/routes_helper.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:foodapp/widgets/text_input_field.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      var email = emailController.text.trim();
      var password = passwordController.text.trim();

      if (email.isEmpty) {
        CustomSnackBar("Enter your email", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        CustomSnackBar("Enter a valid email", title: "Valid email");
      } else if (password.isEmpty) {
        CustomSnackBar("Enter a password", title: "password");
      } else if (password.length < 6) {
        CustomSnackBar("Enter atleast 6 charactes", title: "Password length");
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getIntial());
          } else {
            CustomSnackBar("Forbidden");
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (authcontroller) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 80,
                      backgroundImage:
                          AssetImage("assets/image/logo part 1.png"),
                    ),
                  ),
                  // !welcome text
                  Container(
                    width: double.maxFinite,
                    margin: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hello",
                          style: TextStyle(
                              fontSize: 70, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Sign Into your account",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[500]),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInputWidget(
                      hintText: "Email",
                      icon: Icons.email,
                      textEditingController: emailController),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInputWidget(
                      hintText: "password",
                      icon: Icons.lock,
                      textEditingController: passwordController),

                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      _login(authcontroller);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 13,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.tealAccent),
                      child: Center(
                          child: BigText(
                        text: "Sign In",
                        size: 30,
                        color: Colors.white,
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                      text: TextSpan(
                          text: " Dont Have an account",
                          style: const TextStyle(color: Colors.grey),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(const SignUpPage()))),
                ],
              ),
            );
          },
        ));
  }
}
