import 'dart:convert';

import 'package:beeorder_bloc/data/data_providers/market_and_restaurant.dart';
import 'package:beeorder_bloc/data/models/market_and_restaurant.dart';
import 'package:beeorder_bloc/data/models/product.dart';

class ProfileRep extends MarketsAndRestaurant {
  List<ProductModel> favRestProducts = [
    ProductModel(
      id: 'frp',
      catId: '',
      restId: '',
      title: '',
      description: '',
      price: '',
      imageUrl:
          'https://icon2.cleanpng.com/20180307/euw/kisspng-fast-food-chicken-nugget-french-fries-fried-chicke-fried-chicken-french-fries-with-tomato-and-vegeta-5aa0aa7322e509.7931334915204788351429.jpg',
    ),
  ];
  List<RestaurantAndMarktModel> favRestaurants = [];

  Future<bool> repGetfavList(String token, String userId) async {
    //here i saved the last value because we get the fav rest or prod one by one from the firebase
    //so maybe we get into connection problem in the middle after getting some of it
    //and in that case we shoould back to the start point of this method
    final favRestaurantsLastValue = favRestaurants;
    final favRestProductsLastValue = favRestProducts;
    try {
      final restResponse =
          await getRestOrProdFavList(token, userId, 'restaurants');
      final Map restData = jsonDecode(restResponse.body);
      final prodResponse =
          await getRestOrProdFavList(token, userId, 'products');
      final Map prodData = jsonDecode(prodResponse.body);
      print('here1');
      favRestProducts = [];
      favRestaurants = [];
      for (var mapData in restData.entries) {
        final isFav = mapData.value;
        final restId = mapData.key;
        if (isFav) {
          final response = await getRestOrProdById(token, restId);
          final resData = jsonDecode(response.body);

          favRestaurants.add(
            RestaurantAndMarktModel(
              id: restId,
              coverPhotoUrl: resData['imgurl'],
              timeToDeliver: resData['TimeToDeliver'].toString(),
              logoUrl: resData['logourl'],
              name: resData['name'],
              type: resData['type'],
              deliveryFee: resData['Delivery fee'].toString(),
              isOnline: resData['is online'].toString(),
              isFavorite: true,
            ),
          );
        }
      }
      print('here2');
      for (var mapData in prodData.entries) {
        final isFav = mapData.value;
        final prodId = mapData.key;
        print(prodId);
        if (isFav) {
          final prodResponse = await getProdDetailesById(token, prodId);
          final prodData = jsonDecode(prodResponse.body);
          print('ooooooooooooooooooooooooooooooooooooooooooooooooooo');
          print(prodData);
          final restId = prodData['restId'];
          final catName = prodData['catName'];

          final response = await getRestOrProdById(token, restId,
              prodId: prodId, catName: catName);
          final product = jsonDecode(response.body);
          favRestProducts.add(ProductModel(
              id: prodId,
              catId: product['catName'],
              restId: restId,
              title: product['name'],
              description: product['description'],
              price: product['price'].toString(),
              imageUrl: product['imgurl'],
              isFavorite: true));
        }
        print('object$prodId');
      }

      print('favrestList');
      print(favRestaurants);
      print('favproductList');
      print(favRestProducts);
      return true;
    } catch (e) {
      print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
      print(e);
      favRestProducts = favRestProductsLastValue;
      favRestaurants = favRestaurantsLastValue;
      return false;
    }
  }

  repSetFav(int index, String token, String userId, bool newIsFav,
      String restOrProd, String restOrProdId) async {
    try {
      if (restOrProd == 'products') {
        favRestProducts[index].isFavorite = newIsFav;
      } else {
        favRestaurants[index].isFavorite = newIsFav;
      }
      final response = await setRestOrProdfav(
          token, userId, restOrProd, restOrProdId, newIsFav);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (newIsFav == false) {
          if (restOrProd == 'products') {
            favRestProducts.removeAt(index);
          } else {
            favRestaurants.removeAt(index);
          }
        }
        return true;
      } else {
        if (restOrProd == 'products') {
          favRestProducts[index].isFavorite = newIsFav;
        } else {
          favRestaurants[index].isFavorite = newIsFav;
        }
        return false;
      }
    } catch (e) {
      print(e);
      if (restOrProd == 'products') {
        favRestProducts[index].isFavorite = !newIsFav;
      } else {
        favRestaurants[index].isFavorite = !newIsFav;
      }
      return false;
    }
  }
}
