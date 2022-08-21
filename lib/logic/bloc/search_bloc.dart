import 'package:beeorder_bloc/data/models/market_and_restaurant.dart';
import 'package:beeorder_bloc/data/models/product.dart';
import 'package:beeorder_bloc/logic/cubit/market_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/restaurant_cubit.dart';
import 'package:beeorder_bloc/presentation/widgets/markets.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {
      print('seeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeearch');
      print('serachsearch');
      if (event is SearchKeyChanged) {
        //emit(SearchLoading());
        rest = [];
        market = [];
        products = [];

        if (event.word.isNotEmpty) {
          // Future.delayed(const Duration(seconds: 5));
          final restaurants = BlocProvider.of<RestaurantCubit>(event.context)
              .restaurantRep
              .restaurants;

          final markets =
              BlocProvider.of<MarketCubit>(event.context).marketRep.markets;

          final restProducts = BlocProvider.of<RestaurantCubit>(event.context)
              .restaurantRep
              .restProducts;

          final marketProducts = BlocProvider.of<MarketCubit>(event.context)
              .marketRep
              .marketProducts;

          restaurants.forEach((key, value) {
            print('restName${value.name}');
            print(event.word);
            if (value.name.toLowerCase().contains(event.word)) {
              rest.add(value);
              print('restAdded');
            }
            print('resttested');
          });
          print('rest done');
          print(restProducts.length);
          restProducts.forEach((restId, mapOfcatNames) {
            print(restId);
            mapOfcatNames.forEach((catName, mapOfProducts) {
              mapOfProducts.forEach((prodID, product) {
                if (product.title.toLowerCase().contains(event.word) ||
                    product.description.toLowerCase().contains(event.word)) {
                  products.add([
                    product,
                    restaurants[product.restId]!.name,
                    restaurants[product.restId]!.isOnline
                  ]);
                  print('restProdAdded');
                  print(product.title);
                }
              });
              print('catid tested');
              print(catName);
              print(mapOfProducts.length);
            });
            print('restId tested');
          });
          print('restproddone');

          /* for (var element in products) {
          print(element[0].titile);
        }*/
        }
      }
      print('products is ${products}');
      /*for (var p in restProd){
      print(p.)
    }*/
      print(products.length);
      //Future.delayed(const Duration(seconds: 5));
      emit(SearchDone());
      // TODO: implement event handler
    });
  }

  List<RestaurantAndMarktModel> rest = [];
  List<Market> market = [];
  List<List<dynamic>> products = [];

  /* @override
  void onEvent(SearchEvent event) {
    print('serachsearch');
    if (event is SearchInitial) {
      print('iiiiniiiiiiiiit');
    } else if (event is SearchKeyChanged) {
      emit(SearchLoading());
      rest = [];
      market = [];
      products = [];

      if (event.word.isNotEmpty) {
        Future.delayed(const Duration(seconds: 5));
        final restaurants = BlocProvider.of<RestaurantCubit>(event.context)
            .restaurantRep
            .restaurants;

        final markets =
            BlocProvider.of<MarketCubit>(event.context).marketRep.markets;

        final restProducts = BlocProvider.of<RestaurantCubit>(event.context)
            .restaurantRep
            .restProducts;

        final marketProducts = BlocProvider.of<MarketCubit>(event.context)
            .marketRep
            .marketProducts;

        restaurants.forEach((key, value) {
          print('restName${value.name}');
          print(event.word);
          if (value.name.toLowerCase().contains(event.word)) {
            rest.add(value);
            print('restAdded');
          }
          print('resttested');
        });
        print('rest done');
        print(restProducts.length);
        restProducts.forEach((restId, mapOfcatNames) {
          print(restId);
          mapOfcatNames.forEach((catName, mapOfProducts) {
            mapOfProducts.forEach((prodID, product) {
              if (product.title.toLowerCase().contains(event.word) ||
                  product.description.toLowerCase().contains(event.word)) {
                products.add([
                  product,
                  restaurants[product.restId]!.name,
                  restaurants[product.restId]!.isOnline
                ]);
                print('restProdAdded');
                print(product.title);
              }
            });
            print('catid tested');
            print(catName);
            print(mapOfProducts.length);
          });
          print('restId tested');
        });
        print('restproddone');

        /* for (var element in products) {
          print(element[0].titile);
        }*/
      }
    }
    print('products is ${products}');
    /*for (var p in restProd){
      print(p.)
    }*/
    print(products.length);
    emit(SearchDone());

    super.onEvent(event);
  }*/
}
