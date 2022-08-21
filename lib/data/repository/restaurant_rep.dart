import 'dart:convert';

import 'package:beeorder_bloc/data/data_providers/market_and_restaurant.dart';
import 'package:beeorder_bloc/data/models/market_and_restaurant.dart';
import 'package:beeorder_bloc/data/models/product.dart';

class RestaurantRep extends MarketsAndRestaurant {
  Map<String, RestaurantAndMarktModel> restaurants = {
    'r': RestaurantAndMarktModel(
        id: 'r',
        coverPhotoUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0yiLchCuz2gY2t1vJ3LpyRSfsVL7okAAfAQ&usqp=CAU',
        timeToDeliver: '',
        logoUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0yiLchCuz2gY2t1vJ3LpyRSfsVL7okAAfAQ&usqp=CAU',
        name: '',
        type: '',
        deliveryFee: '',
        isOnline: ''),
    'r1': RestaurantAndMarktModel(
        id: 'r1',
        coverPhotoUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0yiLchCuz2gY2t1vJ3LpyRSfsVL7okAAfAQ&usqp=CAU',
        timeToDeliver: '',
        logoUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0yiLchCuz2gY2t1vJ3LpyRSfsVL7okAAfAQ&usqp=CAU',
        name: '',
        type: '',
        deliveryFee: '',
        isOnline: ''),
  };
  Map<String, RestaurantAndMarktModel> filteredRestaurants = {};

  //Map<RestId,Map<CatName,Map<ProdId,List<ProductModel>>>>
  Map<String, Map<String, Map<String, ProductModel>>> restProducts = {
    '': {
      '': {
        '': ProductModel(
          id: '',
          catId: '',
          restId: '',
          title: '',
          description: '',
          price: '',
          imageUrl:
              'https://icon2.cleanpng.com/20180307/euw/kisspng-fast-food-chicken-nugget-french-fries-fried-chicke-fried-chicken-french-fries-with-tomato-and-vegeta-5aa0aa7322e509.7931334915204788351429.jpg',
        ),
      }
    }
  };

//Map<''RestId,List<CatName,>>
  Map<String, List<String>> restProductCategories = {
    '': ['']
  };

  repFilterRestaurant(String filter) {
    restaurants.forEach((key, value) {
      if (value.type == filter) {
        filteredRestaurants.addAll({key: value});
      }
    });
  }

  repGetRestaurantProducts(String token, String userId, String restId) async {
    print('rep start');
    try {
      final response = await getRestProducts(token, restId: restId);
      final Map resData = jsonDecode(response.body);
      print(restProducts);
      print(resData);
      final favResponse = await getRestOrProdFavList(token, userId, 'products');
      final Map? favResData = jsonDecode(favResponse.body);
      //remove the products we just added to show shimmer
      //  if (!restProducts.containsKey(restId)) {
      restProducts.addAll({restId: {}});
      restProductCategories.addAll({restId: []});
      //  }
      if (restProducts[restId]!.isNotEmpty) {
        print('restProducts not empty');
        restProducts[restId] = {};
        print('here');
      }
      //add the products we have loaded from api

      resData.forEach((catName, mapOfProducts) {
        print('=====================');
        restProductCategories[restId]!.add(catName);
        restProducts[restId]!.addAll({catName: {}});
        print(restProducts);
        mapOfProducts.forEach((prodId, product) {
          restProducts[restId]![catName]!.addAll({
            prodId: ProductModel(
              id: prodId.toString(),
              catId: product['catName'],
              restId: restId,
              title: product['name'],
              description: product['description'],
              price: product['price'].toString(),
              imageUrl: product['imgurl'],
              isFavorite:
                  (favResData == null || !favResData.containsKey(prodId))
                      ? false
                      : favResData[prodId.toString()],
            )
          });
          print('done');
        });
      });
      print('restProducts====$restProducts');
      print('restProductCategories====$restProductCategories');
      return true;
    } catch (e) {
      print('rrrrrrrrrr');
      print(e);
      return false;
    }
  }

  repGetAllRestaurantProducts(String token, String userId) async {
    try {
      print('staaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaart');
      final response = await getRestProducts(token);
      final Map resData = jsonDecode(response.body);
      print(restProducts);
      print(resData);
      final favResponse = await getRestOrProdFavList(token, userId, 'products');
      final Map? favResData = jsonDecode(favResponse.body);
      //remove the products we just added to show shimmer
      //  if (!restProducts.containsKey(restId)) {
      restProducts = {};
      restProductCategories = {};
      resData.forEach((restId, mapOfCatName) {
        restProducts.addAll({restId: {}});
        restProductCategories.addAll({restId: []});
        //  }
        /*  if (restProducts[restId]!.isNotEmpty) {
          print('restProducts not empty');
          restProducts[restId] = {};
          print('here');
        }*/
        //add the products we have loaded from api

        mapOfCatName.forEach((catName, mapOfProducts) {
          print('=====================');
          restProductCategories[restId]!.add(catName);
          restProducts[restId]!.addAll({catName: {}});
          print(restProducts);
          mapOfProducts.forEach((prodId, product) {
            restProducts[restId]![catName]!.addAll({
              prodId: ProductModel(
                id: prodId.toString(),
                catId: product['catName'],
                restId: restId,
                title: product['name'],
                description: product['description'],
                price: product['price'].toString(),
                imageUrl: product['imgurl'],
                isFavorite:
                    (favResData == null || !favResData.containsKey(prodId))
                        ? false
                        : favResData[prodId.toString()],
              )
            });
            print('done');
          });
        });
        print('restProducts====$restProducts');
        print('restProductCategories====$restProductCategories');
      });
      print('doooooooooooooooooooooooooooone');
      return true;
    } catch (e) {
      print('rrrrrrrrrr');
      print(e);
      return false;
    }
  }

  Future<bool> repGetRestaurantsList(String token, String userId) async {
    try {
      final response = await getRestaurants(token);
      final Map resData = jsonDecode(response.body);
      print(restaurants);
      final favResponse =
          await getRestOrProdFavList(token, userId, 'restaurants');
      final Map? favResData = jsonDecode(favResponse.body);
      //remove the restaurants we just added to show shimmer
      if (restaurants.isNotEmpty) {
        restaurants = {};
        //favRestaurants = [];
      }
      //add the elements we have loaded from api to restaurants List
      resData.forEach((key, value) {
        restaurants.addAll({
          key.toString(): RestaurantAndMarktModel(
            id: key,
            coverPhotoUrl: value['imgurl'],
            timeToDeliver: value['TimeToDeliver'].toString(),
            logoUrl: value['logourl'],
            name: value['name'],
            type: value['type'],
            deliveryFee: value['Delivery fee'].toString(),
            isOnline: value['is online'].toString(),
            isFavorite:
                (favResData == null || favResData[key.toString()] == null)
                    ? false
                    : favResData[key.toString()],
          ),
        });
      });
      print('restaurants====$restaurants');
      //return restaurants;
      return true;
    } catch (e) {
      print('rrrrrrrrrr');
      print(e);
      return false;
      // return e as Map;

    }
  }

  Future<bool> repGetRestInfoById(
      String token, String userId, String restId) async {
    if (restaurants.containsKey(restId)) {
      print(
          'truuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuue');
      return true;
    } else {
      try {
        final response = await getRestOrProdById(token, restId);
        final resData = jsonDecode(response.body);
        final favResponse =
            await getRestOrProdFavById(token, userId, 'restaurants', restId);
        final favResData = jsonDecode(response.body);
        restaurants.addAll({
          restId: RestaurantAndMarktModel(
            id: restId,
            coverPhotoUrl: resData['imgurl'],
            timeToDeliver: resData['TimeToDeliver'].toString(),
            logoUrl: resData['logourl'],
            name: resData['name'],
            type: resData['type'],
            deliveryFee: resData['Delivery fee'].toString(),
            isOnline: resData['is online'].toString(),
            isFavorite: (favResData == null || favResData[restId] == null)
                ? false
                : favResData[restId],
          ),
        });
        return true;
      } catch (e) {
        print(
            'ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo');
        print(e);
        return false;
      }
    }
  }

  Future<bool> repSetFav(String token, String userId, String restOrProd,
      String restId, bool newIsFav,
      {String? catName, String? prodId}) async {
    try {
      if (prodId == null) {
        print('prod==null');
        restaurants[restId]!.isFavorite = newIsFav;
        print(
            'restaurants[restId]!.isFavorite ${restaurants[restId]!.isFavorite}');
      } else {
        print('prod!=null');
        restProducts[restId]![catName]![prodId]!.isFavorite = newIsFav;
      }
      final response = await setRestOrProdfav(
          token, userId, restOrProd, prodId ?? restId, newIsFav);
      final resData = jsonDecode(response.body);
      print(resData);
      if (response.statusCode == 200) {
        return true;
      } else {
        //return the old value when an error happens
        if (prodId == null) {
          print('prod==null');
          restaurants[restId]!.isFavorite = !newIsFav;
          print(
              'restaurants[restId]!.isFavorite ${restaurants[restId]!.isFavorite}');
        } else {
          print('prod!=null');
          // if (isNamed == null) {
          restProducts[restId]![catName]![prodId]!.isFavorite = !newIsFav;
          // }
        }
        return false;
      }
    } catch (e) {
      //return the old value when an error happens
      if (prodId == null) {
        print('prod==null');
        restaurants[restId]!.isFavorite = newIsFav;
        print(
            'restaurants[restId]!.isFavorite ${restaurants[restId]!.isFavorite}');
      } else {
        print('prod!=null');
        // if (isNamed == null) {
        restProducts[restId]![catName]![prodId]!.isFavorite = !newIsFav;
        // }
      }
      return false;
    }
  }

  Future<bool?> repGetFavInitValue(String restOrProd, String resOrProdId,
      String token, String userId) async {
    try {
      final response =
          await getRestOrProdFavById(token, userId, restOrProd, resOrProdId);
      final resData = jsonDecode(response.body);
      print(resData);
      if (response.statusCode == 200) {
        return resData;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  repTest(String token) async {
    await test(token);
  }
}
