import 'package:beeorder_bloc/data/data_providers/internet_connection.dart';
import 'package:beeorder_bloc/data/repository/profile_rep.dart';
import 'package:beeorder_bloc/logic/cubit/auth_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/product_details_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/restaurant_favorite_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.auth) : super(FavListsLoadingState());
  AuthCubit auth;
  InternetConnection connection = InternetConnection();
  ProfileRep profileRep = ProfileRep();
  getFavList() async {
    print('??????????????????????????????????????????????');
    emit(FavListsLoadingState());
    final isConnected = await connection.hasNetwork();
    print('lllllllllllllllllllllllllllll');
    print(isConnected);
    if (isConnected) {
      final isGetResProdDone = await profileRep.repGetfavList(
          auth.authRep.idToken, auth.authRep.myUserId);
      if (isGetResProdDone) {
        print(
            'doneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
        emit(FavListsLoadedSuccess());
      } else {
        print('failed');
        emit(FavListsLoadedFailed());
      }
    } else {
      emit(FavInternetConnectionFailed());
    }
  }

  setFav(bool oldIsFav, String restOrProdId, String restOrProd, int index,
      BuildContext context) async {
    final newIsFav = restOrProd == 'products'
        ? BlocProvider.of<ProductDetailsCubit>(context).pLastIsFavState
        : BlocProvider.of<RestaurantFavoriteCubit>(context).rLastIsFavState;
    if (oldIsFav != newIsFav) {
      emit(FavListsLoadingState());
      await profileRep.repSetFav(index, auth.authRep.idToken,
          auth.authRep.userId, newIsFav, restOrProd, restOrProdId);

      emit(FavListsLoadedSuccess());
    }
  }

  getProfileInfo() {}
}
