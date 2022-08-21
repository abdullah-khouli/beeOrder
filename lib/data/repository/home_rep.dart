import 'dart:convert';

import 'package:beeorder_bloc/data/data_providers/market_and_restaurant.dart';
import 'package:beeorder_bloc/data/models/product.dart';

class HomeRep extends MarketsAndRestaurant {
  List<ProductModel> trendRestProducts = List.generate(
    2,
    (index) => ProductModel(
      id: 'trp$index',
      catId: '',
      restId: '',
      title: 'title',
      description: 'description',
      price: 'price',
      imageUrl:
          'https://icon2.cleanpng.com/20180307/euw/kisspng-fast-food-chicken-nugget-french-fries-fried-chicke-fried-chicken-french-fries-with-tomato-and-vegeta-5aa0aa7322e509.7931334915204788351429.jpg',
    ),
  );
  List<ProductModel> newRestProducts = List.generate(
    2,
    (index) => ProductModel(
      id: 'nrp$index',
      catId: '',
      restId: '',
      title: 'title',
      description: 'description',
      price: 'price',
      imageUrl:
          'https://icon2.cleanpng.com/20180307/euw/kisspng-fast-food-chicken-nugget-french-fries-fried-chicke-fried-chicken-french-fries-with-tomato-and-vegeta-5aa0aa7322e509.7931334915204788351429.jpg',
    ),
  );

  List<ProductModel> offerRestProducts = List.generate(
    3,
    (index) => ProductModel(
      id: 'frp$index',
      catId: '',
      restId: '',
      title: 'title',
      description: 'description',
      price: 'price',
      imageUrl:
          'https://icon2.cleanpng.com/20180307/euw/kisspng-fast-food-chicken-nugget-french-fries-fried-chicke-fried-chicken-french-fries-with-tomato-and-vegeta-5aa0aa7322e509.7931334915204788351429.jpg',
    ),
  );

  Future<bool> repGetNamedLists(String token, String userId) async {
    try {
      final favProdResponse =
          await getRestOrProdFavList(token, userId, 'products');
      final Map? favProdData = jsonDecode(favProdResponse.body);
      print(
          'fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff');
      print('favProdData==$favProdData');
      List<String> listNames = ['trend', 'new', 'offers'];
      for (var name in listNames) {
        print(
            'ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo');
        print('name==$name');
        final response = await getNamedList(token, name);
        print(
            'hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
        final Map resData = jsonDecode(response.body);
        print(
            'nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
        print('Named List $resData');
        if (name == 'trend') {
          trendRestProducts = [];
        } else if (name == 'new') {
          newRestProducts = [];
        } else {
          offerRestProducts = [];
        }
        for (var prodMap in resData.entries) {
          final prodId = prodMap.key;
          final isNamed = prodMap.value;
          if (isNamed) {
            final prodResponse = await getProdDetailesById(token, prodId);
            final prodData = jsonDecode(prodResponse.body);
            print(
                'ppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp');
            print('prodData$prodData');
            print('ssssssssssssssssssssssssss');
            final restId = prodData['restId'];
            final catName = prodData['catName'];
            late ProductModel prod;

            final response = await getRestOrProdById(token, restId,
                prodId: prodId, catName: catName);
            final product = jsonDecode(response.body);

            print(product['imgurl']);
            print('iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
            prod = ProductModel(
                id: prodId,
                catId: product['catName'],
                restId: restId,
                title: product['name'],
                description: product['description'],
                price: product['price'].toString(),
                imageUrl: product['imgurl'],
                isFavorite:
                    (favProdData == null || !favProdData.containsKey(prodId))
                        ? false
                        : favProdData[prodId.toString()]);

            if (name == 'trend') {
              print('add to trend');
              trendRestProducts.add(prod);
            } else if (name == 'new') {
              print('add to new');
              newRestProducts.add(prod);
            } else {
              print('add to offer');
              offerRestProducts.add(prod);
            }
          }
        }
        //  await resData.forEach((prodId, isNamed) async {});
      }
      return true;
    } catch (e) {
      print('eeeeeeeeeeeeee');
      print(e);
      return false;
    }
  }

  repSetFav(int index, String token, String userId, bool newIsFav, String name,
      String prodId) async {
    try {
      if (name == 'trend') {
        trendRestProducts[index].isFavorite = newIsFav;
      } else if (name == 'new') {
        newRestProducts[index].isFavorite = newIsFav;
      } else {
        offerRestProducts[index].isFavorite = newIsFav;
      }
      final response =
          await setRestOrProdfav(token, userId, 'products', prodId, newIsFav);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        if (name == 'trend') {
          trendRestProducts[index].isFavorite = newIsFav;
        } else if (name == 'new') {
          newRestProducts[index].isFavorite = newIsFav;
        } else {
          offerRestProducts[index].isFavorite = newIsFav;
        }
        return false;
      }
    } catch (e) {
      print(e);
      if (name == 'trend') {
        trendRestProducts[index].isFavorite = newIsFav;
      } else if (name == 'new') {
        newRestProducts[index].isFavorite = newIsFav;
      } else {
        offerRestProducts[index].isFavorite = newIsFav;
      }
      return false;
    }
  }
}
