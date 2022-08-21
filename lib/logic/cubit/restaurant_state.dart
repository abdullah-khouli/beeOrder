part of 'restaurant_cubit.dart';

@immutable
abstract class RestaurantState {}

class RestInternetConnectionFailed extends RestaurantState {}

/////////////////////////////////////////////////////////
//loading restaurants
class RestaurantsLoadedDone extends RestaurantState {}

class RestaurantsLoadedFailed extends RestaurantState {}

class RestaurantsLoadingState extends RestaurantState {}

/*/////////////////////////////////////////////////////////
//RestaurantFavoriteState
class RestaurantFavoriteState extends RestaurantState {
  final bool isFavorite;

  RestaurantFavoriteState(this.isFavorite);
}
*/
/*
/////////////////////////////////////////////////////////
//loading restaurant favorites list
class FavRestaurantsLoadingState extends RestaurantState {}

class FavRestaurantsLoadedSuccess extends RestaurantState {}

class FavRestaurantsLoadedFailed extends RestaurantState {}*/

////////////////////////////////////////////////////////
//loading named list
/*class NamedListLoadingState extends RestaurantState {}

class NamedListLoadedSuccess extends RestaurantState {}

class NamedListLoadedFailed extends RestaurantState {}*/

//////////////////////////////////////////////////////////
/////loading products
class RestaurantProductsLoadedSuccess extends RestaurantState {}

class RestaurantProductsLoadedFailed extends RestaurantState {}

class RestaurantProductsLoadingState extends RestaurantState {}

/*class ProductFavoriteState extends RestaurantState {
  final bool isFavorite;

  ProductFavoriteState(this.isFavorite);
}*/

/*class SettingProdFavDone extends RestaurantState {
  final bool isDone;

  SettingProdFavDone(this.isDone);
}*/
class RestaurantFilterLoadingState extends RestaurantState {}

class RestaurantFilterLoadingDone extends RestaurantState {}

class RestaurantFilterLoadingFailed extends RestaurantState {
  final String exception;
  RestaurantFilterLoadingFailed({
    required this.exception,
  });
}
