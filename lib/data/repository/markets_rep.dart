import 'dart:convert';

import 'package:beeorder_bloc/data/data_providers/market_and_restaurant.dart';
import 'package:beeorder_bloc/data/models/market_and_restaurant.dart';
import 'package:beeorder_bloc/data/models/product.dart';

class MarketsRep extends MarketsAndRestaurant {
  List<RestaurantAndMarktModel> markets = List.generate(
    2,
    (index) => RestaurantAndMarktModel(
        id: '',
        coverPhotoUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0yiLchCuz2gY2t1vJ3LpyRSfsVL7okAAfAQ&usqp=CAU',
        timeToDeliver: '',
        logoUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0yiLchCuz2gY2t1vJ3LpyRSfsVL7okAAfAQ&usqp=CAU',
        name: '',
        type: '',
        deliveryFee: '',
        isOnline: ''),
  );
  Map<String, List<ProductModel>> marketProducts = {};
  List<String> marketProductCategories = [];
  List<ProductModel> trendMarketProducts = List.generate(
    2,
    (index) => ProductModel(
      id: 'i',
      catId: '',
      restId: '',
      title: 'title',
      description: 'description',
      price: 'price',
      imageUrl:
          'https://icon2.cleanpng.com/20180307/euw/kisspng-fast-food-chicken-nugget-french-fries-fried-chicke-fried-chicken-french-fries-with-tomato-and-vegeta-5aa0aa7322e509.7931334915204788351429.jpg',
    ),
  );
  List<ProductModel> newMarketProducts = List.generate(
      2,
      (index) => ProductModel(
            id: 'i',
            catId: '',
            restId: '',
            title: 'title',
            description: 'description',
            price: 'price',
            imageUrl:
                'https://icon2.cleanpng.com/20180307/euw/kisspng-fast-food-chicken-nugget-french-fries-fried-chicke-fried-chicken-french-fries-with-tomato-and-vegeta-5aa0aa7322e509.7931334915204788351429.jpg',
          ));

  Future<bool> repGetMarketsList(String token) async {
    try {
      final response = await getMarkets(token);
      final Map resData = jsonDecode(response.body);
      if (markets.isNotEmpty) {
        markets = [];
      }
      resData.forEach((key, value) {
        markets.add(RestaurantAndMarktModel(
            id: key,
            coverPhotoUrl: value['imgurl'],
            timeToDeliver: value['TimeToDeliver'].toString(),
            logoUrl: value['logourl'],
            name: value['name'],
            type: value['type'],
            deliveryFee: value['Delivery fee'].toString(),
            isOnline: value['is online'].toString()));
      });
      print('markets====$markets');
      //return restaurants;
      return true;
    } catch (e) {
      print('mmmmmmm');
      print(e);
      return false;
    }
  }

  getMarketById(String id) {
    return markets.firstWhere((element) => element.id == id);
  }

  repGetRestaurantProducts(String token) async {
    print('rep start');
    try {
      // add a product to show shimmer
      marketProducts = {
        '': [
          ProductModel(
            id: 'i',
            catId: '',
            restId: '',
            title: 'title',
            description: 'description',
            price: 'price',
            imageUrl:
                'https://icon2.cleanpng.com/20180307/euw/kisspng-fast-food-chicken-nugget-french-fries-fried-chicke-fried-chicken-french-fries-with-tomato-and-vegeta-5aa0aa7322e509.7931334915204788351429.jpg',
          )
        ]
      };
      marketProductCategories = [''];
      final response = await getMarketProducts(token);
      final Map resData = jsonDecode(response.body);
      print(marketProducts);
      print(resData);
      //remove the products we just added to show shimmer
      if (marketProducts.isNotEmpty) {
        print('restProducts not empty');
        marketProducts = {};
        marketProductCategories = [];
        print('here');
      }
      //add the products we have loaded from api
      resData.forEach((key, value) {
        print('=====================');
        marketProductCategories.add(key);
        marketProducts.addAll({key: []});
        print(marketProducts);
        final newKey = key;
        value.forEach((key, value) {
          marketProducts[newKey]!.add(ProductModel(
              id: key.toString(),
              catId: value['catName'],
              restId: '',
              title: value['name'],
              description: value['description'],
              price: value['price'],
              imageUrl: value['imgurl']));
          print('done');
        });
      });
      print('restProducts====$marketProducts');
      print('restProductCategories====$marketProductCategories');
      return true;
    } catch (e) {
      print('rrrrrrrrrr');
      print(e);
      return false;
    }
  }
}
