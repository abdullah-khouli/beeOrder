import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_cubit.dart';
import 'restaurant_cubit.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this.auth) : super(ProductFavorite(false));
  AuthCubit auth;
  late bool pLastIsFavState;
  int counter = 1;
  localSetProdFav({bool? isFav}) {
    if (isFav != null) {
      //the initial value when we call this  fun from meal item widget
      pLastIsFavState = isFav;
    } else {
      //when we call this fun from rest items screen
      pLastIsFavState = !pLastIsFavState;
    }
    emit(ProductFavorite(pLastIsFavState));
    print('localSetProdFav finished');
  }

  getFavInitValue(String resOrProdId, BuildContext context) async {
    emit(ProductFavoriteLoading());
    pLastIsFavState = false;
    final isFav = await BlocProvider.of<RestaurantCubit>(context)
        .restaurantRep
        .repGetFavInitValue(
            'products', resOrProdId, auth.authRep.idToken, auth.authRep.userId);
    if (isFav != null) {
      pLastIsFavState = isFav;
      emit(ProductFavorite(isFav));
    }
  }

  setProdFav(
    bool oldIsFav,
    String prodId,
    String restId,
    String catName,
    BuildContext context,
  ) async {
    if (oldIsFav != pLastIsFavState) {
      //     emit(ProductFavoriteState(!oldIsFav));
      await BlocProvider.of<RestaurantCubit>(context).restaurantRep.repSetFav(
            auth.authRep.idToken,
            auth.authRep.userId,
            'products',
            restId,
            pLastIsFavState,
            catName: catName,
            prodId: prodId,
          );
      //  return isDone;
    }
    //  return false;
  }

  changeCounter(bool isAdd) {
    if (isAdd) {
      emit(ProductCounter(counter: state.count + 1));
    } else {
      if (state.count > 1) {
        emit(ProductCounter(counter: state.count - 1));
      }
    }
  }
}
