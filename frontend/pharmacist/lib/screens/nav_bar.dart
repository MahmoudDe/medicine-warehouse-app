import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
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
            title: const Text('Email'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.shopping_basket),
            title: const Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/order');
            },
          ),
          ListTile(
            leading: const Icon(Icons.change_circle),
            title: const Text('Change Language'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete Account'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
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
