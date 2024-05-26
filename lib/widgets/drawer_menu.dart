import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text('Electronics'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Games and Entertainment'),
            onTap: () {
              // Navigate to electronics category
            },
          ),
          ListTile(
            title: Text('Home Appliances'),
            onTap: () {
              // Navigate to games category
            },
          ),
          ListTile(
            title: Text('Gift Certificates and Coupons'),
            onTap: () {
              // Navigate to games category
            },
          ),
          ListTile(
            title: Text('Special Offers'),
            onTap: () {
              // Navigate to games category
            },
          ),
          ListTile(
            title: Text('About Us'),
            onTap: () {
              // Navigate to games category
            },
          ),
          ListTile(
            title: Text('Log Out'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
          // Add more items here
        ],
      ),
    );
  }
}
