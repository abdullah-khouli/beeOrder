import 'package:beeorder_bloc/data/models/cart_item.dart';
import 'package:beeorder_bloc/logic/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import '../providers/cartRep.dart';

class CartItems extends StatelessWidget {
  final CartItem cartItem;
  // final String id;
  // final String productId;
  //final double price;
  //final int quantity;
  //final String title;

  const CartItems({
    Key? key,
    required this.cartItem,
    //  required this.id,
    //required this.productId,
    //   required this.price,
    // required this.quantity,
    // required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('hhehehe');
    return InkWell(
      onTap: () {},
      splashColor: const Color(0xFFECEEF1),
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 5),
        child: BlocBuilder<CartCubit, CartState>(
          buildWhen: (previous, current) =>
              current is CartDetailsChanged &&
              current.prodId == cartItem.prodId,
          builder: (context, state) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<CartCubit>(context)
                          .updateQuantity(cartItem.prodId, false);
                    },
                    child: Icon(
                      cartItem.quantity > 1 ? Icons.remove : Icons.delete,
                      size: size.height / 27 > 23 ? size.height / 27 : 23,
                      color: const Color(0XFFEF6C00),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    cartItem.quantity.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize:
                            size.height / 35.5 > 18 ? size.height / 35.5 : 18,
                        fontWeight: FontWeight.w500),
                  ),
                  flex: 1,
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<CartCubit>(context)
                          .updateQuantity(cartItem.prodId, true);
                    },
                    child: Icon(
                      Icons.add,
                      size: size.height / 27 > 23 ? size.height / 27 : 23,
                      color: const Color(0XFFEF6C00),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    cartItem.title,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize:
                            size.height / 45 > 14 ? size.height / 45 : 14),
                  ),
                  flex: 5,
                ),
                Expanded(
                  child: Text(
                    '${(cartItem.price) * (cartItem.quantity)}SYP',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize:
                            size.height / 45 > 14 ? size.height / 45 : 14),
                  ),
                  flex: 2,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
