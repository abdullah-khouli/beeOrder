import 'package:beeorder_bloc/logic/cubit/restaurant_cubit.dart';
import 'package:beeorder_bloc/presentation/widgets/shimmer/big_shimmer.dart';
import 'package:beeorder_bloc/presentation/widgets/shimmer/shimmer_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../build_restaurant_list.dart';

class RestaurantBody extends StatefulWidget {
  const RestaurantBody({Key? key, required this.topPadding}) : super(key: key);
  final double topPadding;
  @override
  State<RestaurantBody> createState() => _RestaurantBodyState();
}

class _RestaurantBodyState extends State<RestaurantBody> {
  @override
  void initState() {
    print('rest body init');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('rest body build');
    final size = MediaQuery.of(context).size;
    //final toolBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      height: (size.height -
          ((size.height / 20 < 28 ? 28 : size.height / 20) +
              10 +
              (size.height / 13 < 35 ? 35 : size.height / 13) +
              56 +
              widget.topPadding)),
      child: BlocConsumer<RestaurantCubit, RestaurantState>(
        listener: (context, state) {
          if (state is RestInternetConnectionFailed) {
            const snackBar = SnackBar(
              content: Text('No internet connection'),
            );
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is RestaurantsLoadedFailed) {
            print('load restaurant failed');
            const snackBar = SnackBar(
              content: Text('Some thing went wrong ,try again later'),
            );
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is RestaurantsLoadedDone) {
            print('restaurant loaded successfuly');
          } else if (state is RestaurantsLoadingState) {
            print('loading');
          }
        },
        buildWhen: (previous, current) => (current is RestaurantsLoadedDone ||
            current is RestaurantsLoadingState ||
            current is RestaurantsLoadedFailed),
        builder: (context, state) {
          print('BuildRestaurantList ');
          print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
          return RefreshIndicator(
            onRefresh: (state is RestaurantsLoadingState)
                ? () async {}
                : () async => await BlocProvider.of<RestaurantCubit>(context)
                    .getRestaurantList(),
            child: ListView(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 20,
              ),
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                  child: Text(
                    'Restaurants',
                    style: TextStyle(
                      fontSize: size.height / 38 < 15 ? 15 : size.height / 38,
                      color: const Color(0XFFEF6C00),
                    ),
                  ),
                ),
                Shimmer(
                  linearGradient: shimmerGradient,
                  child: BuildRestaurantList(
                      isLoading: state is RestaurantsLoadedFailed
                          ? null
                          : (state is RestaurantsLoadingState)),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
