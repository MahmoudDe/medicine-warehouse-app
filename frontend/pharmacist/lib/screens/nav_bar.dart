import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/dummy_data.dart';
import '../main.dart';
import '../server/server.dart';
import 'cart_page.dart';


class NavBar extends StatelessWidget {

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  @override
  Widget build(context) {
    return FutureBuilder<String?>(
        future: getEmail(),
        builder: (context, snapshot) {
          String? email = snapshot.data;

          return Drawer(
            backgroundColor: Colors.white,
            elevation: 0.0,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const UserAccountsDrawerHeader(
                  accountName: Text(
                    '',
                    style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text(
                    '',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/med.png"))
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: Text(tr('email')),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Email: $email', style: TextStyle(fontSize: 25),),
                                // Replace with the actual email variable
                                // Display other login information as needed
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.shopping_basket),
                  title: Text(tr('orders')),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/order');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.request_page_rounded),
                  title: Text(tr('Reports')),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/report');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.change_circle),
                  title: Text(tr('changeLanguage')),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text(tr('chooseLanguage')),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.language),
                                title: Text(tr('english'), style: TextStyle(
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.bold)),
                                onTap: () {
                                  context.setLocale(Locale('en', 'US'));
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.language),
                                title: Text(tr('arabic'), style: TextStyle(
                                    color: Colors.cyan.shade700,
                                    fontWeight: FontWeight.bold)),
                                onTap: () {
                                  context.setLocale(Locale('ar', ''));
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.delete),
                  title: Text(tr('deleteAccount')),
                  onTap: () async {
                    await Server().deleteUserAccount();
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text(tr('logOut')),
                  onTap: () async {
                    Server server = Server();
                    await server.logoutUser();
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                )
              ],
            ),
          );
        }
    );
  }
}