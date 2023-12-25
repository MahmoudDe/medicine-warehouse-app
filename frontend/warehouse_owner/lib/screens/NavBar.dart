import 'package:flutter/material.dart';
import '../Server/server.dart';

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
              'Admin',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              'admin@example.com',
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
            leading: const Icon(Icons.shopping_basket),
            title: const Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/orders');
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
