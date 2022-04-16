import 'package:flutter/material.dart';
import 'package:foodapp/widgets/account_widget.dart';
import 'package:foodapp/widgets/app_icon.dart';
import 'package:foodapp/widgets/big_text.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: BigText(
          text: "Profile",
          size: 24,
        ),
        centerTitle: true,
      ),
      body: Container(
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
                        bigText: BigText(text: "Brian")),
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
                        bigText: BigText(text: "0718775512")),
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
                        bigText: BigText(text: "mulatijunior236@gmail.com")),
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
                        bigText: BigText(text: "Enter your address")),
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
                        bigText: BigText(text: "Brian")),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
