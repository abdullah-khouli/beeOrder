part of 'restaurant_favorite_cubit.dart';

@immutable
abstract class RestaurantFavoriteState {}

class RestaurantFavorite extends RestaurantFavoriteState {
  final bool isFavorite;

  RestaurantFavorite(this.isFavorite);
}
