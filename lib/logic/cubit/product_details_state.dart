part of 'product_details_cubit.dart';

class ProductDetailsState {
  final int count;
  ProductDetailsState({
    this.count = 1,
  });
}

class ProductFavorite extends ProductDetailsState {
  final bool isFavorite;

  ProductFavorite(this.isFavorite);
}

class ProductFavoriteLoading extends ProductDetailsState {}

class ProductCounter extends ProductDetailsState {
  final int counter;
  ProductCounter({
    this.counter = 1,
  }) : super(count: counter);
}
