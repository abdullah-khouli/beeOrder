import 'package:beeorder_bloc/data/models/product.dart';
import 'package:beeorder_bloc/logic/cubit/profile_cubit.dart';
import 'package:beeorder_bloc/presentation/screens/product_detail_screen.dart';
import 'package:beeorder_bloc/presentation/widgets/meal_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildProdFavList extends StatefulWidget {
  const BuildProdFavList({Key? key, required this.isLoading}) : super(key: key);
  final bool isLoading;
  @override
  State<BuildProdFavList> createState() => _BuildProdFavListState();
}

class _BuildProdFavListState extends State<BuildProdFavList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('build restaurant list function');
    final List<ProductModel> productFavList =
        BlocProvider.of<ProfileCubit>(context).profileRep.favRestProducts;
    // print('h$restaurantFavList');
    print('==================================================');
    print(widget.isLoading == false);
    print(productFavList);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
          children: List.generate(
        productFavList.length,
        (index) => MealItem(
          /* prodId: productFavList[index].id,
            catName: productFavList[index].catName,
            restId: productFavList[index].restId,*/
          index: index,
          isProfileScreen: true,
          prod: productFavList[index],
          isLoading: widget.isLoading,
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
