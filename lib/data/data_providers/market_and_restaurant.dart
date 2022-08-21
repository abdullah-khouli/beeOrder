import 'dart:convert';

import 'package:http/http.dart' as http;

class MarketsAndRestaurant {
  Future<http.Response> getRestaurants(String token) async {
    Uri myUri = Uri.parse(
        "https://shopapp-1dd1c-default-rtdb.firebaseio.com/restaurant.json?auth=$token");
    try {
      final response = await http.get(myUri);
      if (response.statusCode == 200) {
        //  final resData = jsonDecode(response.body);
        // print(resData);
        return response;
      } else {
        print(jsonDecode(response.body));
        throw 'some thing went wrong';
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<http.Response> getRestProducts(String token, {String? restId}) async {
    late Uri myUri;
    if (restId != null) {
      myUri = Uri.parse(
          "https://shopapp-1dd1c-default-rtdb.firebaseio.com/products/$restId.json?auth=$token");
    } else {
      myUri = Uri.parse(
          "https://shopapp-1dd1c-default-rtdb.firebaseio.com/products.json?auth=$token");
    }
    try {
      final response = await http.get(myUri);
      if (response.statusCode == 200) {
        print('200000000000000000000');
        //  final resData = jsonDecode(response.body);
        // print(resData);
        return response;
      } else {
        print('eeeeeeeeeeeeeeeeeeeeee');
        print(jsonDecode(response.body));
        throw 'some thing went wrong';
      }
    } catch (e) {
      print('cccccccccccc');
      print(e);
      rethrow;
    }
  }

  getMarketProducts(String token) async {
    Uri myUri = Uri.parse(
        "https://shopapp-1dd1c-default-rtdb.firebaseio.com/products/res_id.json?auth=$token");
    try {
      final response = await http.get(myUri);
      if (response.statusCode == 200) {
        print('200000000000000000000');
        //  final resData = jsonDecode(response.body);
        // print(resData);
        return response;
      } else {
        print('eeeeeeeeeeeeeeeeeeeeee');
        print(jsonDecode(response.body));
        throw 'some thing went wrong';
      }
    } catch (e) {
      print('cccccccccccc');
      print(e);
      rethrow;
    }
  }

  getMarkets(String token) async {
    Uri myUri = Uri.parse(
        "https://shopapp-1dd1c-default-rtdb.firebaseio.com/markets.json?auth=$token");
    try {
      final response = await http.get(myUri);
      if (response.statusCode == 200) {
        return response;
      } else {
        throw 'some thing went wrong';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> setRestOrProdfav(String token, String userId,
      String restOrProd, String restOrProdId, bool newIsFav) async {
    Uri myUri = Uri.parse(
        "https://shopapp-1dd1c-default-rtdb.firebaseio.com/userFavorites/$userId/$restOrProd.json?auth=$token");
    try {
      final response =
          await http.patch(myUri, body: jsonEncode({restOrProdId: newIsFav}));
      return response;
    } catch (e) {
      print('cccccccccccc');
      print(e);
      rethrow;
    }
  }

  Future<http.Response> getRestOrProdFavList(
      String token, String userId, String restOrProd) async {
    Uri myUri = Uri.parse(
        "https://shopapp-1dd1c-default-rtdb.firebaseio.com/userFavorites/$userId/$restOrProd.json?auth=$token");
    try {
      final response = await http.get(myUri);
      return response;
    } catch (e) {
      print('cccccccccccc');
      print(e);
      rethrow;
    }
  }

  Future<http.Response> getRestOrProdById(String token, String restId,
      {String? prodId, String? catName}) async {
    late Uri myUri;
    if (prodId == null) {
      myUri = Uri.parse(
          "https://shopapp-1dd1c-default-rtdb.firebaseio.com/restaurant/$restId.json?auth=$token");
    } else {
      myUri = Uri.parse(
          "https://shopapp-1dd1c-default-rtdb.firebaseio.com/products/$restId/$catName/$prodId.json?auth=$token");
    }
    try {
      final response = await http.get(myUri);
      return response;
    } catch (e) {
      print('cccccccccccc');
      print(e);
      rethrow;
    }
  }

  Future<http.Response> getNamedList(String token, String name) async {
    Uri myUri = Uri.parse(
        "https://shopapp-1dd1c-default-rtdb.firebaseio.com/$name.json?auth=$token");
    try {
      final response = await http.get(myUri);
      print('getNamedList done');
      return response;
    } catch (e) {
      print('cccccccccccc');
      print(e);
      rethrow;
    }
  }

  getRestOrProdFavById(String token, String userId, String restOrProd,
      String resOrProdId) async {
    Uri myUri = Uri.parse(
        "https://shopapp-1dd1c-default-rtdb.firebaseio.com/userFavorites/$userId/$restOrProd/$resOrProdId.json?auth=$token");
    try {
      final response = await http.get(myUri);
      return response;
    } catch (e) {
      print('cccccccccccc');
      print(e);
      rethrow;
    }
  }

  getProdDetailesById(String token, String prodId) async {
    Uri myUri = Uri.parse(
        "https://shopapp-1dd1c-default-rtdb.firebaseio.com/productsData/$prodId.json?auth=$token");
    try {
      final response = await http.get(myUri);
      return response;
    } catch (e) {
      print('cccccccccccc');
      print(e);
      rethrow;
    }
  }

  test(String token) async {
    Uri myUri = Uri.parse(
        "https://shopapp-1dd1c-default-rtdb.firebaseio.com/products/res_1.json?auth=$token");
    Uri myUri1 = Uri.parse(
        "https://shopapp-1dd1c-default-rtdb.firebaseio.com/products/res_2.json?auth=$token");
    Uri myUri2 = Uri.parse(
        "https://shopapp-1dd1c-default-rtdb.firebaseio.com/products/restaurant_id.json?auth=$token");
    Uri myUri3 = Uri.parse(
        "https://shopapp-1dd1c-default-rtdb.firebaseio.com/products/res_id.json?auth=$token");
    try {
      print('test');
      final response = await http.get(myUri);
      final resData = jsonDecode(response.body);
      final data = jsonEncode(resData['cat_cat_1']['first']);
      print('test1');
      await http.put(myUri1, body: response.body);
      print('test2');
      await http.put(myUri2, body: response.body);
      print('test3');
      await http.put(myUri3, body: response.body);
      print('test4');
      if (response.statusCode == 200) {
        print('200000000000000000000');
        //  final resData = jsonDecode(response.body);
        // print(resData);
        return response;
      } else {
        print('eeeeeeeeeeeeeeeeeeeeee');
        print(jsonDecode(response.body));
        throw 'some thing went wrong';
      }
    } catch (e) {
      print('cccccccccccc');
      print(e);
      rethrow;
    }
  }
}
