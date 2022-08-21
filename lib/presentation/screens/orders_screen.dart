import 'package:flutter/material.dart';
/*import 'package:provider/provider.dart';
import 'package:shopapp/widgets/order_item.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static const route = '/OrdersScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text('an error occured'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) {
                  return orderData.orders.isEmpty
                      ? Center(
                          child: Text('There is no orders'),
                        )
                      : ListView.builder(
                          itemBuilder: (ctx, index) =>
                              OrderItem(orderData.orders[index]),
                          itemCount: orderData.orders.length,
                        );
                },
              );
            }
          }
        },
      ),
    );
  }
}*/
