//design finished
import 'package:beeorder_bloc/logic/cubit/cart_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/restaurant_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/restaurant_favorite_cubit.dart';
import 'package:beeorder_bloc/presentation/widgets/meal_item.dart';
import 'package:beeorder_bloc/presentation/widgets/restaurant_appbar.dart';
import 'package:beeorder_bloc/presentation/widgets/shimmer/big_shimmer.dart';
import 'package:beeorder_bloc/presentation/widgets/shimmer/shimmer_gradient.dart';
import 'package:beeorder_bloc/presentation/widgets/shimmer/shimmer_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_screen.dart';

class RestaurantItems extends StatefulWidget {
  const RestaurantItems(this.id, this.isFav, {Key? key}) : super(key: key);
  static const route = '/ProductDetailScreen';
  final String id;
  final bool isFav;

  @override
  State<RestaurantItems> createState() => _RestaurantItemsState();
}

class _RestaurantItemsState extends State<RestaurantItems> {
  @override
  void initState() {
    BlocProvider.of<RestaurantFavoriteCubit>(context)
        .localSetRestFav(isFav: widget.isFav);
    BlocProvider.of<RestaurantCubit>(context).getRestProducts(widget.id);
    print('iiiiiiiiiiiiiiiiiiiiiiiiiiiinit finished');
    super.initState();
  }

  BuildContext? ctx;
  RestaurantFavoriteCubit? favBloc;
  late RestaurantCubit resCubit;
  @override
  void dispose() {
    print('dispose');
    favBloc!.setRestFav(widget.isFav, widget.id, resCubit);

    print('dispose2');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii build');
    final size = MediaQuery.of(context).size;
    /*ctx = context;*/
    favBloc = BlocProvider.of<RestaurantFavoriteCubit>(context);
    resCubit = BlocProvider.of<RestaurantCubit>(context);
    final restaurant = resCubit.restaurantRep.restaurants[widget.id];
    print('height${size.height}');
    print(BlocProvider.of<RestaurantFavoriteCubit>(context));
    print('main build');
    return BlocConsumer<RestaurantCubit, RestaurantState>(
      listener: (context, state) {
        /*   if (state is RestaurantFavoriteState) {
          print('listener');
          print(state.isFavorite);
        }
        if (state is SettingRestFavDone) {
          late SnackBar snackBar;
          if (state.isDone) {
            print('set fav success');
            snackBar = const SnackBar(
              content: Text('Done'),
              duration: Duration(seconds: 1),
            );
          } else {
            print('set fav failed');
            snackBar = const SnackBar(
              content: Text('Some thing went wrong ,Try again later'),
              duration: Duration(seconds: 1),
            );
          }
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }*/
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
          ((current is RestaurantProductsLoadingState) ||
              (current is RestaurantProductsLoadedSuccess)),
      builder: (context, state) {
        //   final isLoading = state is RestaurantProductsLoadingState;
        return DefaultTabController(
          length: resCubit.restaurantRep.restProductCategories[widget.id] ==
                  null
              ? 1
              : resCubit.restaurantRep.restProductCategories[widget.id]!.length,
          child: Scaffold(
            bottomSheet: BlocBuilder<CartCubit, CartState>(
              buildWhen: (previous, current) => current is CartItemDeleted,
              builder: (context, state) => BlocProvider.of<CartCubit>(context)
                      .items
                      .isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => CartScreen(),
                          ),
                        );
                      },
                      child: Material(
                        elevation: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height:
                              size.height / 12.8 > 40 ? size.height / 12.8 : 40,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: size.height / 35.5 > 15
                                    ? size.height / 35.5
                                    : 15,
                                backgroundColor: const Color(0XFFEF6C00),
                                child: const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              Text(
                                'View Cart',
                                style: TextStyle(
                                    color: const Color(0XFFEF6C00),
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.height / 37.6 < 15
                                        ? 15
                                        : size.height / 37.6),
                              ),
                              CircleAvatar(
                                radius: size.height / 35.5 > 15
                                    ? size.height / 35.5
                                    : 15,
                                backgroundColor: const Color(0XFFEF6C00),
                                child: Text(
                                  BlocProvider.of<CartCubit>(context)
                                      .itemcount
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height / 35.5 > 15
                                        ? size.height / 35.5
                                        : 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: 0,
                    ),
            ),
            backgroundColor: Colors.white,
            body: NestedScrollView(
              //  physics: s,
              headerSliverBuilder:
                  (BuildContext context, bool innersBoxIsScrolled) {
                print('header builder');
                print(resCubit.restaurantRep.restProductCategories);
                return [
                  SliverAppBar(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          width: 30,
                          child: FloatingActionButton(
                            elevation: 0,
                            heroTag: '11',
                            mini: true,
                            backgroundColor: Colors.white,
                            child: const Icon(
                              Icons.arrow_back,
                              color: Color(0XFFEF6C00),
                            ),
                            onPressed: () {
                              /* BlocProvider.of<RestaurantCubit>(context)
                                    .setRestFav(widget.isFav, widget.id);*/
                              /* BlocProvider.of<RestaurantFavoriteCubit>(context)
                                  .setRestFav(widget.isFav, widget.id, context);*/
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      Container(
                        width: 30,
                        margin: const EdgeInsets.only(right: 10),
                        child: FloatingActionButton(
                          elevation: 0,
                          heroTag: '22',
                          backgroundColor: Colors.white,
                          mini: true,
                          child: BlocBuilder<RestaurantFavoriteCubit,
                              RestaurantFavoriteState>(
                            buildWhen: (previous, current) =>
                                current is RestaurantFavorite,
                            builder: (context, state) {
                              return Icon(
                                (state is RestaurantFavorite &&
                                        state.isFavorite)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: const Color(0XFFEF6C00),
                                size: 25,
                              );
                            },
                          ),
                          onPressed: state is RestaurantProductsLoadingState
                              ? null
                              : () {
                                  BlocProvider.of<RestaurantFavoriteCubit>(
                                          context)
                                      .localSetRestFav();
                                },
                        ),
                      ),
                      Container(
                        width: 30,
                        child: FloatingActionButton(
                            elevation: 0,
                            heroTag: '33',
                            backgroundColor: Colors.white,
                            mini: true,
                            child: const Icon(
                              Icons.location_on_outlined,
                              color: Color(0XFFEF6C00),
                              size: 27,
                            ),
                            onPressed: () async {}),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                    expandedHeight:
                        (size.height / 3.368) + (size.height * 0.11),
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: SafeArea(
                        child: RestaurantAppBar(
                          id: widget.id,
                          coverPhotoUrl: restaurant!.coverPhotoUrl,
                          deliveryFee:
                              'Delivery Fee : ${restaurant.deliveryFee} SYP',
                          logoUrl: restaurant.logoUrl,
                          restaurantName: restaurant.name,
                          restaurantType: restaurant.type!,
                          timeToDeliver: '${restaurant.timeToDeliver} min',
                        ),
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: size * 0.11,
                      child: Container(
                        height: size.height * 0.11,
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 5),
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(restaurant.logoUrl),
                              radius: size.height / 25.6 < 18
                                  ? 18
                                  : size.height / 25.6,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: (size.height * 0.11 / 2) - 1,
                                  width: (size.width -
                                      20 -
                                      ((size.height / 25.6 < 20
                                              ? 20
                                              : size.height / 25.6) *
                                          2)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        restaurant.name,
                                        style: TextStyle(
                                          fontSize: size.height / 40 < 12
                                              ? 12
                                              : size.height / 40,
                                          color: const Color(0XFFEF6C00),
                                        ),
                                      ),
                                      Row(
                                        // mainAxisSize: MainAxisSize.min,

                                        children: [
                                          Text(
                                            restaurant.isOnline,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: size.height / 45 < 12
                                                  ? 12
                                                  : size.height / 45,
                                              color: Colors.teal,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          const Icon(
                                            Icons.circle,
                                            color: Colors.teal,
                                            size: 10,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  height: (size.height * 0.11 / 2) - 1,
                                  width: (size.width -
                                      20 -
                                      ((size.height / 25.6 < 20
                                              ? 20
                                              : size.height / 25.6) *
                                          2)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '',
                                        style: TextStyle(
                                          fontSize: size.height / 55 < 10
                                              ? 10
                                              : size.height / 55,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey[900],
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        'Delivery Fee : 50 SYP',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: size.height / 55 < 10
                                              ? 10
                                              : size.height / 55,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey[900],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(width: 5)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        indicatorColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          for (String tab in (resCubit.restaurantRep
                                      .restProductCategories[widget.id] ==
                                  null
                              ? ['']
                              : resCubit.restaurantRep
                                  .restProductCategories[widget.id]!))
                            Builder(builder: (context) {
                              print('tab build $tab');
                              return Tab(
                                text: tab,
                              );
                            }),
                        ],
                        isScrollable: true,
                      ),
                      state is RestaurantProductsLoadingState,
                    ),
                  ),
                ];
              },
              body: Builder(builder: (context) {
                print(widget.id);
                print(
                    'wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
                print(resCubit.restaurantRep.restProductCategories);
                return Container(
                  color: Colors.white,
                  child: TabBarView(
                    children: [
                      for (final tab in (resCubit.restaurantRep
                                  .restProductCategories[widget.id] ==
                              null
                          ? ['']
                          : resCubit
                              .restaurantRep.restProductCategories[widget.id]!))
                        Shimmer(
                          linearGradient: shimmerGradient,
                          child: RefreshIndicator(
                            onRefresh: state is RestaurantProductsLoadingState
                                ? () async {}
                                : () async =>
                                    BlocProvider.of<RestaurantCubit>(context)
                                        .getRestProducts(widget.id),
                            child: ListView(
                              padding: EdgeInsets.only(
                                  top: 12,
                                  bottom: size.height / 12.8 > 40
                                      ? size.height / 12.8
                                      : 40,
                                  left: 15,
                                  right: 15),
                              children: (resCubit.restaurantRep
                                              .restProducts[widget.id] ==
                                          null
                                      ? resCubit.restaurantRep
                                          .restProducts['']!['']!.entries
                                      : resCubit
                                          .restaurantRep
                                          .restProducts[widget.id]![tab]!
                                          .entries)
                                  .map<Widget>(
                                    (product) => MealItem(
                                      /* catName: tab,
                                      restId: widget.id,
                                      prodId: product.key,*/
                                      prod: product.value,
                                      isLoading: state
                                          is RestaurantProductsLoadingState,
                                      //  catName: tab,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar, this.isLoading);
  final bool isLoading;
  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print(_tabBar.preferredSize.height.toString() + 'jjjjjjjjjjjj');
    print(isLoading);
    return Material(
      elevation: 3,
      child: Shimmer(
          linearGradient: shimmerGradient,
          child: Container(
              width: 200,
              height: 48,
              color: const Color(0xFFECEEF1),
              child: ShimmerLoading(isLoading: isLoading, child: _tabBar))),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
