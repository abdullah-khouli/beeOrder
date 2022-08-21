import 'package:beeorder_bloc/data/data_providers/internet_connection.dart';
import 'package:beeorder_bloc/data/models/market_and_restaurant.dart';
import 'package:beeorder_bloc/data/repository/markets_rep.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'auth_cubit.dart';

part 'market_state.dart';

class MarketCubit extends Cubit<MarketState> {
  MarketCubit(this.auth) : super(MarketLoadedDone());
  final MarketsRep marketRep = MarketsRep();
  AuthCubit auth;
  InternetConnection connection = InternetConnection();

  RestaurantAndMarktModel getResaurantFromRepById(String id) {
    return marketRep.getMarketById(id);
  }

  getMarketList() async {
    print('MMMccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc');
    emit(MarketLoadingState());
    final isConnected = await connection.hasNetwork();
    if (isConnected) {
      final isGetMarketDone =
          await marketRep.repGetMarketsList(auth.authRep.idToken);
      print('eg');

      if (!isGetMarketDone) {
        emit(MarketLoadedFailed());
      } else {
        emit(MarketLoadedDone());
      }
    } else {
      emit(MarketInternetConnectionFailed());
    }

    print('end');
  }

  emitLodingProducts() {
    emit(MarketProductsLoadingState());
  }
}
