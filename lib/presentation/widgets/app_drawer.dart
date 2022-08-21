/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/screens/orders_screen.dart';
import 'package:shopapp/screens/user_products_screen.dart';
import '../main.dart';
import '../providers/authRep.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'username',
              style: TextStyle(fontSize: 25),
            ),
            accountEmail: Text('accountEmail'),
            currentAccountPicture: const CircleAvatar(
              child: FlutterLogo(size: 42.0),
            ),
          ),
          ListTile(
            title: Text('Shop'),
            leading: const Icon(Icons.shop),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => MyApp()));
            },
          ),
          Divider(),
          ListTile(
            title: Text('Orders'),
            leading: const Icon(Icons.payment),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => OrdersScreen()));
            },
          ),
          Divider(),
          ListTile(
            title: Text('My  Products'),
            leading: const Icon(Icons.edit),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => UserProductsScreen()));
            },
          ),
          Divider(),
          ListTile(
            title: Text('Logout'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () async {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => MyApp(),
                ),
              );
              await Provider.of<Auth>(context, listen: false).signOut();
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}*/
