import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:foodapp/widgets/text_input_field.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                backgroundImage: AssetImage("assets/image/logo part 1.png"),
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
                    style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sign Into your account",
                    style: TextStyle(fontSize: 20, color: Colors.grey[500]),
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
            Container(
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
            const SizedBox(
              height: 20,
            ),
            RichText(
                text: TextSpan(
                    text: " Dont Have an account",
                    style: const TextStyle(color: Colors.grey),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.back())),
          ],
        ),
      ),
    );
  }
}
