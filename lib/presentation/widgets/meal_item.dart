import 'package:beeorder_bloc/data/models/product.dart';
import 'package:beeorder_bloc/logic/cubit/product_details_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/profile_cubit.dart';
import 'package:beeorder_bloc/presentation/screens/product_detail_screen.dart';
import 'package:beeorder_bloc/presentation/widgets/shimmer/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:beeorder/providers/productRep.dart';
//import 'package:beeorder/screens/product_detail_screen.dart';

class MealItem extends StatefulWidget {
  final bool isLoading;
  final ProductModel prod;
  final bool? isProfileScreen;
  final int? index;
  const MealItem({
    Key? key,
    this.index,
    this.isProfileScreen,
    required this.prod,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<MealItem> createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> {
  @override
  Widget build(BuildContext context) {
    final product = widget.prod;
    final size = MediaQuery.of(context).size;
    print(size.width);
    return ShimmerLoading(
      isLoading: widget.isLoading,
      child: GestureDetector(
        onTap: widget.isLoading
            ? null
            : () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(product, false),
                  ),
                )
                    .whenComplete(() {
                  print(
                      'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc');
                  return widget.isProfileScreen == null
                      ? BlocProvider.of<ProductDetailsCubit>(context)
                          .setProdFav(product.isFavorite, widget.prod.id,
                              widget.prod.restId, widget.prod.catId, context)
                      : BlocProvider.of<ProfileCubit>(context).setFav(
                          product.isFavorite,
                          widget.prod.id,
                          'products',
                          widget.index!,
                          context,
                        );
                });
              },
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(vertical: 7),
              elevation: 2,
              child: Container(
                width: size.width,
                height: size.height / 4.26 < 125 ? 125 : size.height / 4.26,
                child: ClipRRect(
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: const AssetImage(
                        'assets/images/jewelryPlaceHolder.png'),
                    image: NetworkImage(
                      product.imageUrl,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  color: Colors.white,
                  height: 25,
                  width: ((size.width - 45) / 3) * 2,
                  child: Text(
                    product.title, //'meal name',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: size.height / 40 < 14 ? 14 : size.height / 40,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                  color: Colors.white,
                  child: Text(
                    product.price, // 'price',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: const Color(0XFFEF6C00),
                      fontSize: size.height / 40 < 14 ? 14 : size.height / 40,
                    ),
                  ),
                  width: (size.width - 45) / 3,
                  height: 25,
                )
              ],
            ),
            const SizedBox(height: 5),
            Container(
              color: Colors.white,
              width: size.width - 30,
              child: Text(
                product
                    .description, //'description kgkgkjgkj ljkgllhvv kjggkjgou uhlulhlh jhuho8hoi lihoihlijlijj9 ',
                style: TextStyle(
                    fontSize: size.height / 40 < 12 ? 12 : size.height / 40,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[850]),
              ),
            ),
            const SizedBox(height: 15)
          ],
        ),
      ),
    );
  }
}
