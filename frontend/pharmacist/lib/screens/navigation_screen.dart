import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import '../models/constants.dart';

class NavigationScreen extends StatefulWidget {
  static const String routeName = '/navigation-screen';
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: Constants.index == 0 ? appBar(): null,
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(
            vertical: mediaQuery.height / 60,
            horizontal: mediaQuery.width / 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: mediaQuery.width / 15,
              vertical: mediaQuery.height / 200),
          child: GNav(
            color: const Color.fromRGBO(50, 41, 16, 170),
            curve: Curves.easeInSine,
            activeColor: const Color.fromARGB(255, 50, 41, 16),
            tabBackgroundColor: const Color.fromRGBO(50, 41, 16, 220),
            gap: 8,
            padding: EdgeInsets.all(mediaQuery.height / 60),
            onTabChange: (value) {
              setState(
                    () {
                  Constants.index = value;
                },
              );
            },
            tabs: [
              GButton(
                icon: Constants.index == 0 ? Iconsax.home_2 : Iconsax.home, // Change the icon based on whether the tab is active
                text: tr('Home'),
                textColor: Colors.cyan.shade700,
                iconActiveColor: Colors.cyan.shade500,
              ),
              GButton(
                icon: Constants.index == 1 ? Iconsax.shopping_cart : Iconsax.shopping_cart, // Change the icon based on whether the tab is active
                text:  tr('Cart'),
                textColor: Colors.orange.shade500,
                iconActiveColor: Colors.orange.shade500,
              ),
              GButton(
                icon: Constants.index == 2 ? Iconsax.heart5 : Iconsax.heart, // Change the icon based on whether the tab is active
                text: tr('Favorite'),
                textColor: Colors.red.shade700,
                iconActiveColor: Colors.red,

              ),
            ],
          )


        ),
      ),
      body: Stack(
        children: [
          Constants.secreens[Constants.index],
        ],
      ),
    );
  }
}
