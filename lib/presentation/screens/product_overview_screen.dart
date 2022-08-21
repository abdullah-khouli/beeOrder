//design finished

import 'package:beeorder_bloc/logic/cubit/home_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/market_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/product_overview_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/profile_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/restaurant_cubit.dart';
import 'package:beeorder_bloc/presentation/widgets/build_dishes_fav_list.dart';
import 'package:beeorder_bloc/presentation/widgets/build_rest_fav_list.dart';

import 'package:beeorder_bloc/presentation/widgets/custom_icon.dart';
import 'package:beeorder_bloc/presentation/widgets/product_overview_screen_bodies.dart/home_body.dart';
import 'package:beeorder_bloc/presentation/widgets/product_overview_screen_bodies.dart/markets_body.dart';
import 'package:beeorder_bloc/presentation/widgets/product_overview_screen_bodies.dart/profile_body.dart';
import 'package:beeorder_bloc/presentation/widgets/product_overview_screen_bodies.dart/restaurants_body.dart';
import 'package:beeorder_bloc/presentation/widgets/shimmer/big_shimmer.dart';
import 'package:beeorder_bloc/presentation/widgets/shimmer/shimmer_gradient.dart';
import 'package:beeorder_bloc/presentation/widgets/shimmer/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_screen.dart';
import 'restaurant_type_filter_screen.dart';
import 'search_screen.dart';
import 'settings.dart';

enum FilterOption { Favorites, All }

class ProductOverviewscreen extends StatefulWidget {
  const ProductOverviewscreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewscreen> createState() => _ProductOverviewscreenState();
}

class _ProductOverviewscreenState extends State<ProductOverviewscreen> {
//  int currentIndex = 0;
  @override
  void initState() {
    print('ProductOverviewscreen   iniiiiit');
    BlocProvider.of<HomeCubit>(context).getNamedList();
    BlocProvider.of<RestaurantCubit>(context).getRestaurantList();
    BlocProvider.of<MarketCubit>(context).getMarketList();
    //BlocProvider.of<ProfileCubit>(context).getFavList();
    // BlocProvider.of<RestaurantCubit>(context).getFavList();
    // BlocProvider.of<RestaurantCubit>(context).getRestProducts();
    // BlocProvider.of<RestaurantCubit>(context).getRestAndProdFavList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final myTopPadding = MediaQuery.of(context).padding.top;
    print(MediaQuery.of(context).padding.top);
    print(size.width);
    print(size.height);
    final List<BottomNavigationBarItem> itemsList = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.restaurant), label: 'Restaurants'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.shop_outlined), label: 'Markets'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.person_outline), label: 'Profile'),
    ];
    final List<Widget> list = [
      HomeBody(topPadding: myTopPadding),
      RestaurantBody(topPadding: myTopPadding),
      MarketsBody(topPadding: myTopPadding),
      const Center(
        child: Text('test'),
      ),
    ];

    return BlocBuilder<ProductOverviewCubit, ProductOverviewState>(
      // buildWhen: (previous, current) => current.rebuild,
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: Container(
            height: 56,
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              onTap: (index) {
                print('on taaaaaaaaaap');
                BlocProvider.of<ProductOverviewCubit>(context)
                    .changeCurrentIndex(index);
                /*setState(() {
                  currentIndex = index;
                });*/
              },
              items: itemsList,
              currentIndex: state.currentIndex,
              elevation: 5,
              selectedItemColor: const Color(0XFFEF6C00),
              type: BottomNavigationBarType.fixed,
            ),
          ),
          backgroundColor: Colors.white,
          appBar: state.currentIndex == 3
              ? AppBar(
                  elevation: 0,
                  toolbarHeight: 0,
                )
              : AppBar(
                  toolbarHeight: size.height / 13 < 35 ? 35 : size.height / 13,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  leadingWidth: 0,
                  title: Container(
                      // color: Colors.red,
                      height: size.height / 13 < 35 ? 35 : size.height / 13,
                      width: 240,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            'Deliver to:',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize:
                                    size.width / 25 < 12 ? 12 : size.width / 25,
                                letterSpacing: 0.01,
                                fontWeight: FontWeight.w400),
                          ),
                          TextButton.icon(
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {},
                            icon: Text(
                              'Current location',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size.width / 25 < 12
                                      ? 12
                                      : size.width / 25,
                                  letterSpacing: 0.01,
                                  fontWeight: FontWeight.w600),
                            ),
                            label: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                              size: size.width / 13 < 16 ? 16 : size.width / 13,
                            ),
                          )
                        ],
                      )),
                  actions: [
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.white),
                      ),
                      child: Text(
                        'Help',
                        style: TextStyle(
                          color: const Color(0XFFEF6C00),
                          fontSize:
                              size.height / 46 < 12 ? 12 : size.height / 46,
                        ),
                      ),
                    ),
                  ],
                ),
          body: state.currentIndex == 3
              ? ProfileBody(size: size, topPadding: myTopPadding)
              : Column(
                  children: [
                    Container(
                      height: size.height / 20 < 28 ? 28 : size.height / 20,
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 10),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height:
                                size.height / 20 < 28 ? 28 : size.height / 20,
                            width: (size.width - 30) * 0.85,
                            child: TextFormField(
                              readOnly: true,
                              onTap: () async {
                                await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => SearchScreen()));
                              },
                              textAlign: TextAlign.left,
                              cursorColor: Colors.grey[700],
                              decoration: InputDecoration(
                                fillColor: const Color(0xFFECEEF1),
                                filled: true,
                                contentPadding: const EdgeInsets.only(left: 10),
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey[800],
                                ),
                                hintText: 'Search by restaurant or item',
                                hintStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[800]),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) =>
                                      const RestaurantTypeFilter()));
                            },
                            child: Container(
                              color: Colors.white,
                              width: (size.width - 30) * 0.15,
                              padding: const EdgeInsets.only(
                                  bottom: 0, left: 10, right: 10),
                              alignment: Alignment.center,
                              child: const CustomIcon(),
                            ),
                          )
                        ],
                      ),
                    ),
                    /* IndexedStack(
                      index: state.currentIndex,
                      children: list,
                    )*/
                    list[state.currentIndex]
                  ],
                ),
        );
      },
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print(_tabBar.preferredSize.height.toString() + 'jjjjjjjjjjjj');
    return Material(
      elevation: 3,
      child: Container(color: const Color(0xFFECEEF1), child: _tabBar),
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
