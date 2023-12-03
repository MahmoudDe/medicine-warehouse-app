import 'package:medicine_warehouse/screens/Profile.dart';
import '../screens/HomePage.dart';
import '../screens/SearchPage.dart';

class Constants {
  // ignore: non_constant_identifier_names
  static bool DidSelectLanguage = false;
  static int index = 0;
  static List secreens = [
    HomeScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];
}
