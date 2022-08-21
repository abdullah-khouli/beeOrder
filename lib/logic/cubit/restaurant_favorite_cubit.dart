import 'dart:convert';

import 'package:beeorder_bloc/data/data_providers/market_and_restaurant.dart';
import 'package:beeorder_bloc/logic/cubit/auth_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/restaurant_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'restaurant_favorite_state.dart';

class RestaurantFavoriteCubit extends Cubit<RestaurantFavoriteState> {
  RestaurantFavoriteCubit(this.auth) : super(RestaurantFavorite(false));
  AuthCubit auth;
  late bool rLastIsFavState;
  localSetRestFav({bool? isFav}) {
    print(
        'llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll');
    if (isFav != null) {
      //the initial value when we call this  fun from build rest list widget
      rLastIsFavState = isFav;
    } else {
      //when we call this fun from rest items screen
      rLastIsFavState = !rLastIsFavState;
    }
    emit(RestaurantFavorite(rLastIsFavState));
    print('localSetRestFav finished');
  }

  setRestFav(bool oldIsFav, String restId, RestaurantCubit restCubit) async {
    print('calllllllllllllled');
    print('object');
    print(oldIsFav); //from rep restaurants
    print(rLastIsFavState);
    if (oldIsFav != rLastIsFavState) {
      // try {
      await restCubit.restaurantRep.repSetFav(auth.authRep.idToken,
          auth.authRep.userId, 'restaurants', restId, rLastIsFavState);
      /* final response = await dataProvider.setRestOrProdfav(
            auth.authRep.idToken,
            auth.authRep.userId,
            'restaurants',
            restId,
            rLastIsFavState);
        final resData = jsonDecode(response.body);
        if (response.statusCode == 200) {
          
        }
      } catch (e) {}*/
    }
  }

  @override
  Future<void> close() {
    print('clooooooooooooooose');
    return super.close();
  }
}
