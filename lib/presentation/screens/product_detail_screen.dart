import 'package:beeorder_bloc/data/models/product.dart';
import 'package:beeorder_bloc/logic/cubit/cart_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/product_details_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/restaurant_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/restaurant_favorite_cubit.dart';
import 'package:beeorder_bloc/presentation/screens/restaurant_items_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen(this.product, this.isNamed, {Key? key})
      : super(key: key);
  static const route = '/ProductDetailScreen';
  final ProductModel product;
  final bool isNamed;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductDetailsCubit>(context)
        .getFavInitValue(widget.product.id, context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    late int counter;
    RestaurantFavoriteCubit favBloc =
        BlocProvider.of<RestaurantFavoriteCubit>(context);
    return BlocConsumer<RestaurantCubit, RestaurantState>(
        listener: (context, state) {
          if (state is RestaurantProductsLoadedFailed) {
            print('load restaurant products failed');
            const snackBar = SnackBar(
              content: Text(
                  'Some thing went wrong ,please check your internet connection'),
              duration: Duration(seconds: 1),
            );
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is RestaurantProductsLoadingState) {
            print('Restaurant Products Loading State');
          }
        },
        buildWhen: (previous, current) =>
            current is RestaurantProductsLoadingState ||
            current is RestaurantProductsLoadedFailed,
        builder: (_, state) {
          return Stack(
            children: [
              Scaffold(
                bottomSheet: Container(
                    color: Colors.white,
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(size),
                          shadowColor: MaterialStateProperty.all(Colors.black),
                          overlayColor: MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)))),
                      onPressed: () async {
                        //cart.addItem(product.id, product.price, product.title);

                        BlocProvider.of<CartCubit>(context).addItem(
                            widget.product.id,
                            double.parse(widget.product.price),
                            widget.product.title,
                            counter);

                        if (widget.isNamed) {
                          final isDone =
                              await BlocProvider.of<RestaurantCubit>(context)
                                  .getRestInfoById(widget.product.restId);
                          print('heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeerw');

                          if (isDone) {
                            final restaurant =
                                BlocProvider.of<RestaurantCubit>(context)
                                    .restaurantRep
                                    .restaurants[widget.product.restId];
                            await Navigator.of(context)
                                .push(
                              MaterialPageRoute(
                                builder: (_) => RestaurantItems(
                                    restaurant!.id, restaurant.isFavorite),
                              ),
                            )
                                .whenComplete(() {
                              print(restaurant);
                              print(restaurant!.id);
                              print(restaurant.isFavorite);
                              print(
                                  'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc');

                              /*  favBloc.setRestFav(restaurant.isFavorite,
                                  restaurant.id, context);*/
                              Navigator.of(context).pop();
                            });
                          }
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      icon: const CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(0XFFEF6C00),
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                      ),
                      label: const Center(
                        child: Text(
                          'Add to cart',
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFFEF6C00)),
                        ),
                      ),
                    )),
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      snap: true,
                      floating: true,
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 30,
                            margin: const EdgeInsets.only(left: 10),
                            child: FloatingActionButton(
                              elevation: 0,
                              heroTag: widget.product.id + '1',
                              mini: true,
                              backgroundColor: Colors.white,
                              child: const Icon(
                                Icons.arrow_back,
                                color: Color(0XFFEF6C00),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        Container(
                          width: 30,
                          child: BlocBuilder<ProductDetailsCubit,
                              ProductDetailsState>(
                            buildWhen: (previous, current) =>
                                (current is ProductFavoriteLoading) ||
                                (current is ProductFavorite),
                            builder: (context, state) {
                              return FloatingActionButton(
                                elevation: 0,
                                heroTag: widget.product.id + '2',
                                backgroundColor: Colors.white,
                                mini: true,
                                child: BlocBuilder<ProductDetailsCubit,
                                    ProductDetailsState>(
                                  buildWhen: (previous, current) =>
                                      current is ProductFavorite,
                                  builder: (context, state) {
                                    return Icon(
                                      (state is ProductFavorite &&
                                              state.isFavorite)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: const Color(0XFFEF6C00),
                                      size: 25,
                                    );
                                  },
                                ),
                                onPressed: state is ProductFavoriteLoading
                                    ? () {
                                        print(null);
                                      }
                                    : () {
                                        BlocProvider.of<ProductDetailsCubit>(
                                                context)
                                            .localSetProdFav();
                                      },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                      expandedHeight: 190,
                      // pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        titlePadding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 2.5,
                            bottom: 20),
                        background: SafeArea(
                          child: Hero(
                            tag: widget.product.id, //loadedProduct.id,
                            child: Image.network(
                              widget
                                  .product.imageUrl, // loadedProduct.imageUrl,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  widget.product.title, // loadedProduct.title,
                                  softWrap: true,
                                  maxLines: null,
                                  style: const TextStyle(
                                      wordSpacing: 1,
                                      height: 1.5,
                                      fontSize: 20),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                //  color: Colors.red,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Text(
                                  '\$${widget.product.price} SYP',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 30),
                          // color: Colors.red,
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd', // loadedProduct.description,
                            softWrap: true,
                            maxLines: null,
                            textAlign: TextAlign.left,
                            style: TextStyle(wordSpacing: 1, fontSize: 20),
                          ),
                        ),
                        Container(
                          height: 0.5,
                          color: Colors.grey[600],
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: size.width / 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                splashRadius: 1,
                                onPressed: () {
                                  BlocProvider.of<ProductDetailsCubit>(context)
                                      .changeCounter(false);
                                  // return cart.updateQuantity(product.id, true);
                                },
                                color: const Color(0XFFEF6C00),
                                icon: const Icon(Icons.remove),
                              ),
                              BlocBuilder<ProductDetailsCubit,
                                      ProductDetailsState>(
                                  buildWhen: (previous, current) =>
                                      current is ProductCounter,
                                  builder: (context, state) {
                                    counter = state.count;
                                    return Text(
                                      state.count.toString(),
                                      style: const TextStyle(fontSize: 20),
                                    );
                                  }),
                              IconButton(
                                splashRadius: 1,
                                onPressed: () {
                                  BlocProvider.of<ProductDetailsCubit>(context)
                                      .changeCounter(true);
                                  // return cart.updateQuantity(product.id, true);
                                },
                                color: const Color(0XFFEF6C00),
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                          height: 80,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: 0.5,
                          color: Colors.grey[600],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: TextFormField(
                            scrollPadding:
                                const EdgeInsets.only(bottom: double.infinity),
                            maxLength: 30,
                            cursorColor: const Color(0XFFEF6C00),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.grey[500]!,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.grey[500]!,
                                ),
                              ),
                              hintText: 'Note: Special Request (Optional)',
                              hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[350],
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
              if (state is RestaurantProductsLoadingState)
                ModalBarrier(
                  color: Colors.black.withOpacity(0.3),
                  dismissible: false,
                  barrierSemanticsDismissible: false,
                ),
              if (state is RestaurantProductsLoadingState)
                const Center(child: CircularProgressIndicator()),
            ],
          );
        });
  }
}
