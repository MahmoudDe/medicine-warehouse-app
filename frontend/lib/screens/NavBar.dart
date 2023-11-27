import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Bader Awad'),
            accountEmail: Text('bader33.awad@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile.jpg"),
              radius: 50,
            ),
            decoration: BoxDecoration(
                color: Colors.cyan,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/r.jpg"))),
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.shopping_basket),
            title: const Text('Orders'),
            onTap: () {},
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
            onTap: () {},
          )
        ],
      ),
    );
  }
}
