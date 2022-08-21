//design finished
import 'package:beeorder_bloc/logic/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:beeorder/widgets/meal_item.dart';
//import '../providers/cartRep.dart'; //هنا لغيت Show Cart
import '../widgets/cart_items.dart';
//import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //  final cart = Provider.of<Cart>(context);
    return Scaffold(
      bottomSheet: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartItemDeleted && state.itemCount == 0) {
            Navigator.of(context).pop();
          }
        },
        buildWhen: (previous, current) =>
            current is CartItemDeleted || current is CartDetailsChanged,
        builder: (context, state) {
          return (state is CartItemDeleted && state.itemCount == 0)
              ? Container(
                  height: 0,
                )
              : Container(
                  height: size.height / 6.4 > 75 ? size.height / 6.4 : 75,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Text(
                                'Subtotal:',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.height / 38 < 15
                                        ? 15
                                        : size.height / 38),
                              ),
                              BlocBuilder<CartCubit, CartState>(
                                  buildWhen: (previous, current) =>
                                      current is CartDetailsChanged,
                                  builder: (context, state) {
                                    return Text(
                                      '${BlocProvider.of<CartCubit>(context).totalAmount} SYP',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: size.height / 42 < 15
                                              ? 15
                                              : size.height / 42),
                                    );
                                  })
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          elevation: 4,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => CartScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: size.height / 35.5 < 15
                                        ? 15
                                        : size.height / 35.5,
                                    backgroundColor: const Color(0XFFEF6C00),
                                    child: Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                      size: size.height / 29 < 16
                                          ? 16
                                          : size.height / 29,
                                    ),
                                  ),
                                  Text(
                                    'Continue',
                                    style: TextStyle(
                                        color: const Color(0XFFEF6C00),
                                        fontWeight: FontWeight.w500,
                                        fontSize: size.height / 37.6 < 15
                                            ? 15
                                            : size.height / 37.6),
                                  ),
                                  CircleAvatar(
                                    radius: size.height / 35.5 < 15
                                        ? 15
                                        : size.height / 35.5,
                                    backgroundColor: const Color(0XFFEF6C00),
                                    child: Text(
                                      BlocProvider.of<CartCubit>(context)
                                          .itemcount
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.height / 35.5 < 15
                                            ? 15
                                            : size.height / 35.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: size.height / 16 < 40 ? 40 : size.height / 16,
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: size.width * 0.35 > 150 ? 150 : size.width * 0.35,
        leading: Container(
          padding: EdgeInsets.only(left: size.width * 0.04),
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: size.height / 40 < 16 ? 16 : size.height / 40,
              color: Colors.black,
            ),
            label: Text(
              'Your Cart',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: size.height / 46 < 14 ? 14 : size.height / 46),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size.width * 0.92,
            height: 2,
            child: const Divider(
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: size.height -
                MediaQuery.of(context).padding.top -
                4 -
                (size.height / 16 < 40 ? 40 : size.height / 16) -
                ((size.height / 6.4 > 75 ? size.height / 6.4 : 75)),
            child: BlocBuilder<CartCubit, CartState>(
              buildWhen: (previous, current) => current is CartItemDeleted,
              builder: (context, state) {
                return ListView.separated(
                  padding: const EdgeInsets.only(bottom: 25),
                  itemBuilder: (_, index) {
                    print('ttttttttttttttttttttttttttttttttttttttt');
                    print(index);
                    final items = BlocProvider.of<CartCubit>(context)
                        .items
                        .values
                        .toList();
                    return index != items.length
                        ? CartItems(cartItem: items[index]
                            /*id: 'id',
                            title: 'title',
                            quantity: 15,
                            price: 5435354,
                            productId: '',*/
                            )
                        : InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            splashColor: const Color(0xFFECEEF1),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(),
                                      ),
                                      Expanded(
                                        child: Container(),
                                        flex: 1,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Icon(
                                            Icons.add,
                                            size: size.height / 27 > 23
                                                ? size.height / 27
                                                : 23,
                                            color: const Color(0XFFEF6C00),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          'Add more dishes',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: size.height / 45 > 14
                                                  ? size.height / 45
                                                  : 14),
                                        ),
                                        flex: 5,
                                      ),
                                      Expanded(
                                        child: Container(),
                                        flex: 2,
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 2,
                                  indent: size.width * 0.05,
                                  endIndent: size.width * 0.05,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          );
                  },
                  itemCount:
                      BlocProvider.of<CartCubit>(context).items.length + 1,
                  separatorBuilder: (_, index) => Divider(
                    height: 2,
                    indent: size.width * 0.05,
                    endIndent: size.width * 0.05,
                    color: Colors.black,
                  ),
                );
              },
            ),
          ),
          SizedBox(
            width: size.width * 0.92,
            height: 2,
            child: const Divider(
              color: Colors.black,
            ),
          ),
          SizedBox(height: size.height / 6.4 > 100 ? size.height / 6.4 : 100)
        ],
      ),
    );
  }
}
