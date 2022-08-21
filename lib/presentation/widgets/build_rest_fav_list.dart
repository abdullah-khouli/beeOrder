import 'package:beeorder_bloc/data/models/market_and_restaurant.dart';
import 'package:beeorder_bloc/logic/cubit/profile_cubit.dart';
import 'package:beeorder_bloc/presentation/screens/restaurant_items_screen.dart';
import 'package:beeorder_bloc/presentation/widgets/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildRestFavList extends StatefulWidget {
  const BuildRestFavList({
    Key? key,
    required this.isLoading,
  }) : super(key: key);
  final bool? isLoading;

  @override
  State<BuildRestFavList> createState() => _BuildRestFavListState();
}

class _BuildRestFavListState extends State<BuildRestFavList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('build restaurant list function');
    final List<RestaurantAndMarktModel> restaurantFavList =
        BlocProvider.of<ProfileCubit>(context).profileRep.favRestaurants;
    // print('h$restaurantFavList');
    print('==================================================');
    print(widget.isLoading == false);
    print(restaurantFavList);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
          children: List.generate(
        restaurantFavList.length,
        (index) => GestureDetector(
          onTap: () => Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (_) => RestaurantItems(restaurantFavList[index].id,
                      restaurantFavList[index].isFavorite),
                ),
              )
              .whenComplete(
                () => BlocProvider.of<ProfileCubit>(context).setFav(
                    restaurantFavList[index].isFavorite,
                    restaurantFavList[index].id,
                    'restaurants',
                    index,
                    context),
              ),
          child: Restaurant(
            restModel: restaurantFavList[index],
            isloading: widget.isLoading,
          ),
        ),
      )

          /*[
                                GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const RestaurantItems('1'))),
                                  child: Restaurant(
                                    restModel: RestaurantAndMarktModel(
                                      id: '1',
                                      coverPhotoUrl:
                                          'https://png.pngtree.com/png-clipart/20201208/original/pngtree-wide-avenue-png-image_5609305.jpg',
                                      deliveryFee: '50 SYP',
                                      logoUrl:
                                          'https://banner2.cleanpng.com/20180323/obq/kisspng-t-shirt-polo-shirt-lacoste-clothing-sizes-polo-shirt-5ab57a46dad160.5622717315218427588963.jpg',
                                      name: 'restaurant name',
                                      type: 'restaurant type',
                                      timeToDeliver: '63 - 73 min',
                                      isOnline: 'Online',
                                    ),
                                    isloading: false,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const RestaurantItems('2'))),
                                  child: Restaurant(
                                    restModel: RestaurantAndMarktModel(
                                      id: '2',
                                      coverPhotoUrl:
                                          'https://png.pngtree.com/png-clipart/20201208/original/pngtree-wide-avenue-png-image_5609305.jpg',
                                      deliveryFee: '50 SYP',
                                      logoUrl:
                                          'https://banner2.cleanpng.com/20180323/obq/kisspng-t-shirt-polo-shirt-lacoste-clothing-sizes-polo-shirt-5ab57a46dad160.5622717315218427588963.jpg',
                                      name: 'restaurant name',
                                      type: 'restaurant type',
                                      timeToDeliver: '63 - 73 min',
                                      isOnline: 'Online',
                                    ),
                                    isloading: false,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const RestaurantItems('3'))),
                                  child: Restaurant(
                                    restModel: RestaurantAndMarktModel(
                                      id: '3',
                                      coverPhotoUrl:
                                          'https://png.pngtree.com/png-clipart/20201208/original/pngtree-wide-avenue-png-image_5609305.jpg',
                                      deliveryFee: '50 SYP',
                                      logoUrl:
                                          'https://banner2.cleanpng.com/20180323/obq/kisspng-t-shirt-polo-shirt-lacoste-clothing-sizes-polo-shirt-5ab57a46dad160.5622717315218427588963.jpg',
                                      name: 'Restaurant name',
                                      type: 'Restaurant type',
                                      timeToDeliver: '63 - 73 min',
                                      isOnline: 'Online',
                                    ),
                                    isloading: false,
                                  ),
                                ),
                              ],*/
          ),
    );
  }
}
