import 'package:beeorder_bloc/data/data_providers/internet_connection.dart';
import 'package:beeorder_bloc/data/repository/restaurant_rep.dart';
import 'package:beeorder_bloc/logic/cubit/auth_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  AuthCubit auth;
  InternetConnection connection = InternetConnection();
  RestaurantCubit(this.auth) : super(RestaurantsLoadingState());
  late bool rLastIsFavState;
  late bool pLastIsFavState;
  RestaurantRep restaurantRep = RestaurantRep();

  filterRestaurant(String filter) async {
    emit(RestaurantFilterLoadingState());

    final isDone = await restaurantRep.repFilterRestaurant(filter);
    if (isDone) {
      emit(RestaurantFilterLoadingDone());
    } else {
      emit(
        RestaurantFilterLoadingFailed(
            exception: 'some thing went wrong please try again later'),
      );
    }
    print('getRestInfoByIdddddddddddddddddddddddddddd done');
    return isDone;
  }

  Future<bool> getRestInfoById(String id) async {
    emit(RestaurantProductsLoadingState());
    final isConnected = await connection.hasNetwork();
    print(isConnected);
    if (isConnected) {
      final isDone = await restaurantRep.repGetRestInfoById(
          auth.authRep.idToken, auth.authRep.userId, id);
      if (isDone) {
        //emit(RestaurantProductsLoadedSuccess());
      } else {
        emit(RestaurantProductsLoadedFailed());
      }
      print('getRestInfoByIdddddddddddddddddddddddddddd done');
      return isDone;
    } else {
      emit(RestaurantProductsLoadedFailed());
      print('getRestInfoByIdddddddddddddddddddddddddddd done');
      return false;
    }
  }

  getRestProducts(String restId) async {
    print('??????????????????????????????????????????????');
    emit(RestaurantProductsLoadingState());
    final isConnected = await connection.hasNetwork();
    print(isConnected);
    if (isConnected) {
      final isGetResProdDone = await restaurantRep.repGetRestaurantProducts(
          auth.authRep.idToken, auth.authRep.myUserId, restId);
      if (isGetResProdDone) {
        emit(RestaurantProductsLoadedSuccess());
      } else {
        emit(RestaurantProductsLoadedFailed());
      }
    } else {
      emit(RestInternetConnectionFailed());
    }
  }

  getRestaurantList() async {
    print('RRccccccccccccccccccccccccccccccccccccccccccccccccccccc');
    emit(RestaurantsLoadingState());
    final isConnected = await connection.hasNetwork();
    if (isConnected) {
      print('ggggggggghh');

      final isGetRestDone = await restaurantRep.repGetRestaurantsList(
          auth.authRep.idToken, auth.authRep.myUserId);
      print('eg');

      if (!isGetRestDone) {
        print('failed');
        emit(RestaurantsLoadedFailed());
      } else {
        emit(RestaurantsLoadedDone());
      }
    } else {
      print('r not connected');
      emit(RestInternetConnectionFailed());
    }

    print('end');
  }

  getAllRestProds() async {
    emit(RestaurantProductsLoadingState());
    print('emitted');
    final isConnected = await connection.hasNetwork();
    print(isConnected);
    if (isConnected) {
      final isGetResProdDone = await restaurantRep.repGetAllRestaurantProducts(
          auth.authRep.idToken, auth.authRep.myUserId);
      if (isGetResProdDone) {
        emit(RestaurantProductsLoadedSuccess());
      } else {
        emit(RestaurantProductsLoadedFailed());
      }
    } else {
      emit(RestInternetConnectionFailed());
    }
  }

  test() async {
    await restaurantRep.repTest(auth.authRep.idToken);
  }

  @override
  Future<void> close() {
    print('restaurant cubit close function has been called');
    return super.close();
  }
}
/*getFavList() async {
    print('??????????????????????????????????????????????');
    emit(FavRestaurantsLoadingState());
    final isConnected = await connection.hasNetwork();
    print(isConnected);
    if (isConnected) {
      final isGetResProdDone = await restaurantRep.repGetfavList(
          auth.authRep.idToken, auth.authRep.myUserId);
      if (isGetResProdDone) {
        emit(FavRestaurantsLoadedSuccess());
      } else {
        emit(FavRestaurantsLoadedFailed());
      }
    } else {
      emit(RestInternetConnectionFailed());
    }
  }*/

  /*setProdFav(bool oldIsFav, String prodId, String restId, String catName,
      {bool? isNamed}) async {
    if (oldIsFav != pLastIsFavState) {
      //     emit(ProductFavoriteState(!oldIsFav));
      final isDone = await restaurantRep.repSetFav(auth.authRep.idToken,
          auth.authRep.userId, 'products', restId, pLastIsFavState,
          catName: catName, prodId: prodId, isNamed: isNamed);
      //  return isDone;
    }
    //  return false;
  }*/

  /* setRestFav(bool oldIsFav, String restId) async {
    print('calllllllllllllled');
    print('object');
    print(oldIsFav); //from rep restaurants
    print(rLastIsFavState);
    if (oldIsFav != rLastIsFavState) {
      await restaurantRep.repSetFav(auth.authRep.idToken, auth.authRep.userId,
          'restaurants', restId, rLastIsFavState);
    }
  }*/

  /*localSetProdFav({bool? isFav}) {
    if (isFav != null) {
      //the initial value when we call this  fun from meal item widget
      pLastIsFavState = isFav;
    } else {
      //when we call this fun from rest items screen
      pLastIsFavState = !pLastIsFavState;
    }
    emit(ProductFavoriteState(pLastIsFavState));
    print('localSetProdFav finished');
  }*/

  /* localSetRestFav({bool? isFav}) {
    print(
        'llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll');
    if (isFav != null) {
      //the initial value when we call this  fun from build rest list widget
      rLastIsFavState = isFav;
    } else {
      //when we call this fun from rest items screen
      rLastIsFavState = !rLastIsFavState;
    }
    emit(RestaurantFavoriteState(rLastIsFavState));
    print('localSetRestFav finished');
  }*/

 /* getNamedList() async {
    print('getNamedList');
    emit(NamedListLoadingState());
    final isConnected = await connection.hasNetwork();
    if (isConnected) {
      print('connected to the internet');

      final isGetRestDone = await restaurantRep.repGetNamedLists(
          auth.authRep.idToken, auth.authRep.myUserId);

      if (!isGetRestDone) {
        print('getNamedList failed');
        emit(NamedListLoadedFailed());
      } else {
        print('getNamedList success');
        emit(NamedListLoadedSuccess());
      }
    } else {
      print('internet not connected');
      emit(RestInternetConnectionFailed());
    }

    print('getNamedList End');
  }*/