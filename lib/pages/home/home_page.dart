import 'package:flutter/material.dart';
import 'package:foodapp/pages/accounts/account_page.dart';
import 'package:foodapp/pages/auth/sign_up_page.dart';
import 'package:foodapp/pages/cart/cart_history.dart';
import 'package:foodapp/pages/home/main_home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selected = 0;
  List pages = [
    const MainHomePage(),
    Container(
      child: Center(
        child: Text("History page"),
      ),
    ),
    const CartHistory(),
    const AccountsPage()
  ];
  void onTapNav(int index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selected],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.teal.shade900,
          unselectedItemColor: Colors.teal.shade200,
          onTap: onTapNav,
          currentIndex: _selected,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.archive,
                ),
                label: "History"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                label: "Cart"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "Me")
          ]),
    );
  }
}
