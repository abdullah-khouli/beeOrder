/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/screens/edit_product_screen.dart';
import 'package:shopapp/widgets/user_product_item.dart';
import '../providers/products.dart';
import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .newFetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => EditProductScreen())),
              icon: Icon(Icons.add))
        ],
      ),
      body: Center(
        child: FutureBuilder(
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      child: Consumer<Products>(
                        builder: (ctx, productsData, _) {
                          if (productsData.items.isEmpty)
                            return Center(
                              child: Text('You do not have any products'),
                            );
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: ListView.builder(
                              itemBuilder: (ctx, index) => Column(
                                children: [
                                  UserProductItem(
                                      productsData.items[index].id,
                                      productsData.items[index].title,
                                      productsData.items[index].imageUrl),
                                  Divider(),
                                ],
                              ),
                              itemCount: productsData.items.length,
                            ),
                          );
                        },
                      ),
                      onRefresh: () => _refreshProducts(ctx)),
          future: _refreshProducts(context),
        ),
      ),
    );
  }
}*/
