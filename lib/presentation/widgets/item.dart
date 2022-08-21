import 'package:beeorder_bloc/data/models/product.dart';
import 'package:beeorder_bloc/logic/bloc/search_bloc.dart';
import 'package:beeorder_bloc/logic/cubit/home_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/product_details_cubit.dart';
import 'package:beeorder_bloc/presentation/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Item extends StatelessWidget {
  const Item({
    Key? key,
    required this.product,
    // required this.itemName,
    required this.restaurantName,
    // required this.price,
    required this.isOpen,
    //required this.imgUrl,
  }) : super(key: key);
//  final String itemName;
  final ProductModel product;
  final String restaurantName;
  // final String price;
  final String isOpen;
  // final String imgUrl;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product, true),
          ),
        )
            .whenComplete(() {
          BlocProvider.of<ProductDetailsCubit>(context).setProdFav(
              product.isFavorite,
              product.id,
              product.restId,
              product.catId,
              context);
        });
        print('pressed');
      },
      splashColor: const Color(0xFFECEEF1),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
        //color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: (size.width * 0.65) - 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isOpen,
                    //    maxLines: null,
                  ),
                  const SizedBox(height: 5),
                  Text(product.title),
                  const SizedBox(height: 5),
                  Text(restaurantName),
                  const SizedBox(height: 5),
                  Text('price: $product.price SYP'),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Card(
              margin: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Container(
                height: 100,
                width: size.width * 0.35,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
