import 'package:medicine_warehouse/screens/Profile.dart';

import 'package:medicine_warehouse/screens/cart_page.dart';
import '../data/dummy_data.dart';

import 'package:medicine_warehouse/screens/favorite.dart';

import '../screens/home_page.dart';

import '../screens/search_page.dart';

class Constants {
  // ignore: non_constant_identifier_names
  static bool DidSelectLanguage = false;
  static int index = 0;
  static List secreens = [
    HomeScreen(),
    CartPage(cartItem:[]),
    ProfileScreen(),
    SearchScreen(),
    FavoriteScreen(),
  ];
}
