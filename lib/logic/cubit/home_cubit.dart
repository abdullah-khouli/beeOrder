import 'package:beeorder_bloc/data/data_providers/internet_connection.dart';
import 'package:beeorder_bloc/data/repository/home_rep.dart';
import 'package:beeorder_bloc/logic/cubit/auth_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/product_details_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.auth) : super(NamedListLoadingState());
  //RestaurantCubit restCubit;
  AuthCubit auth;
  InternetConnection connection = InternetConnection();
  HomeRep homeRep = HomeRep();
  getNamedList() async {
    print('getNamedList');
    emit(NamedListLoadingState());
    final isConnected = await connection.hasNetwork();
    if (isConnected) {
      print('connected to the internet');

      final isGetRestDone = await homeRep.repGetNamedLists(
          auth.authRep.idToken, auth.authRep.myUserId);

      if (!isGetRestDone) {
        print('getNamedList failed');
        emit(NamedListLoadedFailed());
      } else {
        print('sucesssssssssssssssssssssssssssssssssssssssssssssssssss');
        print('getNamedList success');
        emit(NamedListLoadedSuccess());
      }
    } else {
      print('internet not connected');
      emit(HomeInternetConnectionFailed());
    }

    print('getNamedList End');
  }

  setProdFav(bool oldIsFav, String prodId, String restId, String catName,
      String name, int index, BuildContext context) async {
    final newIsFav =
        BlocProvider.of<ProductDetailsCubit>(context).pLastIsFavState;
    if (oldIsFav != newIsFav) {
      await homeRep.repSetFav(index, auth.authRep.idToken, auth.authRep.userId,
          newIsFav, name, prodId);
    }
  }
}
