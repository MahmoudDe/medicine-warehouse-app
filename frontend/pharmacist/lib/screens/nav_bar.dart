import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../main.dart';
import '../server/server.dart';
import 'cart_page.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(context) {
    return Drawer(
      elevation: 0.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text(
              'Bader Awad',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              'bader33.awad@gmail.com',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/Profile.jpg"),
              radius: 50,
            ),
            decoration: BoxDecoration(
              color: Colors.black87,
              // image: DecorationImage(
              //     fit: BoxFit.cover,
              //     image: AssetImage("assets/images/R.jpg"))
            ),
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: Text(tr('email')),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.shopping_basket),
            title: Text(tr('orders')),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/order');
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
                    title: Text(tr('chooseLanguage')),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.language),
                          title: Text(tr('english'), style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
                          onTap: () {
                            context.setLocale(Locale('en', 'US'));
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.language),
                          title: Text(tr('arabic'), style: TextStyle(color: Colors.cyan.shade700, fontWeight: FontWeight.bold)),
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
}
