import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/base/show_custom_message.dart';
import 'package:foodapp/controllers/auth_controller.dart';
import 'package:foodapp/models/sign_up_model.dart';
import 'package:foodapp/pages/auth/sign_in_page.dart';
import 'package:foodapp/routes/routes_helper.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:foodapp/widgets/text_input_field.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = ["t.png", "f.png", "g.png"];

    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();

      if (name.isEmpty) {
        CustomSnackBar("Enter your name", title: "Name");
      } else if (phone.isEmpty) {
        CustomSnackBar("Enter your phone number", title: "Phone number");
      } else if (email.isEmpty) {
        CustomSnackBar("Enter your email address", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        CustomSnackBar("Enter a valid email address", title: "Email");
      } else if (password.isEmpty) {
        CustomSnackBar("Enter your password", title: "Password");
      } else if (password.length < 6) {
        CustomSnackBar("Enter atleast 6 characters", title: "Password");
      } else {
        SignUpBody signUpBody = SignUpBody(
            email: email, name: name, password: password, phone: phone);
        authController.registration(signUpBody).then((status) => {
              if (status.isSuccess)
                {
                  Get.offNamed(RouteHelper.getIntial()),
                  print("Successfully registered")
                }
              else
                {CustomSnackBar(status.message)}
            });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (_authController) {
            return !_authController.isLoading
                ? SingleChildScrollView(
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
                          height: 20,
                        ),
                        TextInputWidget(
                            hintText: "Name",
                            icon: Icons.person,
                            textEditingController: nameController),
                        const SizedBox(
                          height: 20,
                        ),
                        TextInputWidget(
                            hintText: "Phone",
                            icon: Icons.phone,
                            textEditingController: phoneController),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            _registration(_authController);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height / 13,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.tealAccent),
                            child: Center(
                                child: BigText(
                              text: "Sign Up",
                              size: 30,
                              color: Colors.white,
                            )),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                            text: TextSpan(
                                text: "Have an account",
                                style: const TextStyle(color: Colors.grey),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(const SignInPage(),
                                      transition: Transition.fade))),
                        Wrap(
                          children: List.generate(
                              3,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                          "assets/image/" +
                                              signUpImages[index]),
                                    ),
                                  )),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue),
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        )),
                  );
          },
        ));
  }
}
