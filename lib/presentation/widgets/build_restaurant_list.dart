import 'package:beeorder_bloc/data/models/market_and_restaurant.dart';
import 'package:beeorder_bloc/logic/cubit/restaurant_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/restaurant_favorite_cubit.dart';
import 'package:beeorder_bloc/presentation/screens/restaurant_items_screen.dart';
import 'package:beeorder_bloc/presentation/widgets/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildRestaurantList extends StatefulWidget {
  const BuildRestaurantList({Key? key, required this.isLoading})
      : super(key: key);
  final bool? isLoading;

  @override
  State<BuildRestaurantList> createState() => _BuildRestaurantListState();
}

class _BuildRestaurantListState extends State<BuildRestaurantList> {
  @override
  void initState() {
    print('restaurant iniiiiit');
    //i call it in prod overview screen instead
    //BlocProvider.of<RestaurantCubit>(context).getRestaurantList();

    //}

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build restaurant list function');
    final Map<String, RestaurantAndMarktModel> restaurantList =
        BlocProvider.of<RestaurantCubit>(context).restaurantRep.restaurants;
    print('h$restaurantList');
    print('==================================================');
    print(widget.isLoading == false);
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: restaurantList.entries
          .map(
            (restaurant) => GestureDetector(
              onTap: widget.isLoading == false
                  ? () async {
                      print('hhhhhhhhhhhh');
                      print(restaurant.value.isFavorite);
                      /*  BlocProvider.of<RestaurantCubit>(context)
                          .localSetRestFav(isFav: restaurant.value.isFavorite);*/
                      /*  BlocProvider.of<RestaurantCubit>(context)
                          .getRestProducts(restaurant.key);*/
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (_) => RestaurantItems(
                              restaurant.key, restaurant.value.isFavorite),
                        ),
                      )
                          .whenComplete(() {
                        print(
                            'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc');
                        /*return BlocProvider.of<RestaurantFavoriteCubit>(context)
                            .setRestFav(restaurant.value.isFavorite,
                                restaurant.value.id, context);*/
                      });
                    }
                  : null,
              child: Restaurant(
                  restModel: restaurant.value, isloading: widget.isLoading),
            ),
          )
          .toList()
      /*.map(
            (restaurant) => GestureDetector(
              onTap: widget.isLoading == false
                  ? () {
                      BlocProvider.of<RestaurantCubit>(context)
                          .localSetRestFav(restaurant.isFavorite);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => RestaurantItems(
                            restaurant.id, restaurant.isFavorite),
                      ));
                    }
                  : null,
              child: Restaurant(
                  restModel: restaurant, isloading: widget.isLoading),
            ),
          )
          .toList()*/
      ,
    );
  }
}
