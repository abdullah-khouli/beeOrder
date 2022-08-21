//design finished
import 'package:beeorder_bloc/data/models/product.dart';
import 'package:beeorder_bloc/logic/cubit/market_cubit.dart';
import 'package:beeorder_bloc/presentation/widgets/meal_item.dart';
import 'package:beeorder_bloc/presentation/widgets/restaurant_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_screen.dart';

class MarketsItems extends StatelessWidget {
  MarketsItems(this.id, {Key? key}) : super(key: key);
  static const route = '/ProductDetailScreen';
  final condition = true;
  final List<String> tabs = [
    '1111111111111111111111111',
    '222222',
    '111111',
    '222222',
    '111111',
    '222222',
    '111111',
    '222222'
  ];
  final String id;
  // final Product product;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final market = BlocProvider.of<MarketCubit>(context)
        .marketRep
        .markets
        .firstWhere((element) => element.id == id);
    print('height${size.height}');
    /*final authData = Provider.of<Auth>(context, listen: false);
    //final productId = ModalRoute.of(context).settings.arguments as String;

    final cart = Provider.of<Cart>(context, listen: false);
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(product.id);*/
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        bottomSheet: condition
            ? GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => CartScreen()));
                },
                child: Material(
                  elevation: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: size.height / 12.8 > 40 ? size.height / 12.8 : 40,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius:
                              size.height / 35.5 > 15 ? size.height / 35.5 : 15,
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
                          radius:
                              size.height / 35.5 > 15 ? size.height / 35.5 : 15,
                          backgroundColor: const Color(0XFFEF6C00),
                          child: Text(
                            '32',
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
        backgroundColor: Colors.white,
        body: NestedScrollView(
          //  physics: s,
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverAppBar(
              elevation: 0,
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
                        backgroundImage: NetworkImage(market.logoUrl),
                        radius:
                            size.height / 25.6 < 18 ? 18 : size.height / 25.6,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  market.name,
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
                                      market.isOnline,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  'Delivery Fee : ${market.deliveryFee!} SYP',
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
                      child: const Icon(
                        Icons.favorite_border,
                        color: Color(0XFFEF6C00),
                        size: 25,
                      ),
                      onPressed: () {}),
                ),
                Container(
                  width: 30,
                  //  margin: EdgeInsets.only(right: 10),
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
                      onPressed: () {}),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
              expandedHeight: (size.height / 3.368) + (size.height * 0.11),
              pinned: true,
              // forceElevated: true,
              //  elevation: Theme.of(context).appBarTheme.elevation,
              flexibleSpace: FlexibleSpaceBar(
                /* title: Container(color: Colors.blue, child: Text('tttttt')),
                titlePadding: EdgeInsets.only(bottom: 120),
                centerTitle: true,*/
                background: SafeArea(
                  child: RestaurantAppBar(
                    //height 335
                    id: '1',
                    coverPhotoUrl: market.coverPhotoUrl,
                    deliveryFee: '50 SYP',
                    logoUrl: market.logoUrl,
                    restaurantName: 'restaurant name',
                    restaurantType: 'restaurant type',
                    timeToDeliver: '63 - 73 min',
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
                    for (String tab in tabs)
                      Tab(
                        text: tab,
                      ),
                  ],
                  isScrollable: true,
                ),
              ),
            ),
          ],
          body: Container(
            //  padding: EdgeInsets.only(top: 15, bottom: 25),
            //   margin: EdgeInsets.symmetric(horizontal: 15),
            //height: size.height - 315,
            child: TabBarView(
              children: [
                for (final tab in tabs)
                  ListView.builder(
                      padding: EdgeInsets.only(
                          top: 12,
                          bottom:
                              size.height / 12.8 > 40 ? size.height / 12.8 : 40,
                          left: 15,
                          right: 15),
                      itemCount: 3,
                      itemBuilder: (_, index) {
                        return MealItem(
                          /*prodId: 'id',
                          restId: id,
                          catName: tab,*/
                          prod: ProductModel(
                            id: '',
                            catId: '',
                            restId: '',
                            title: '',
                            description: '',
                            price: '',
                            imageUrl:
                                'https://icon2.cleanpng.com/20180307/euw/kisspng-fast-food-chicken-nugget-french-fries-fried-chicke-fried-chicken-french-fries-with-tomato-and-vegeta-5aa0aa7322e509.7931334915204788351429.jpg',
                          ),
                          isLoading: false,
                          //  catName: tab,
                        );
                      } //[MealItem(), MealItem()],
                      ),
                /* SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(3, (index) {
                        if (index == 2)
                          return SizedBox(
                            height: 20,
                          );
                        return MealItem();
                      }),
                    ),
                  ),*/
                // Center(child: Text(tab)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print(_tabBar.preferredSize.height.toString() + 'jjjjjjjjjjjj');
    return new Material(
      elevation: 3,
      child: Container(color: Color(0xFFECEEF1), child: _tabBar),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

/*class ColoredTabBar extends Container implements PreferredSizeWidget {
  ColoredTabBar(this.color, this.tabBar);

  final Color color;
  final TabBar tabBar;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: 120,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 10),
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                    'https://banner2.cleanpng.com/20180323/obq/kisspng-t-shirt-polo-shirt-lacoste-clothing-sizes-polo-shirt-5ab57a46dad160.5622717315218427588963.jpg',
                  ),
                  radius: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: (size.width - 65),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hello',
                              style: TextStyle(
                                fontSize: size.height / 40,
                                color: Color(0XFFEF6C00),
                              ),
                            ),
                            Text(
                              '63 - 73 min',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: size.width / 22,
                                color: Color(0XFFEF6C00),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'restaurantType',
                              style: TextStyle(
                                fontSize: size.width / 25,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Delivery Fee : 50 SYP',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: size.width / 25,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 50,
            color: color,
            child: tabBar,
          ),
        ],
      ),
    );
  }
}*/
