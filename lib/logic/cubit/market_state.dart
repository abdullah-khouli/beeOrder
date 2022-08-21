part of 'market_cubit.dart';

@immutable
abstract class MarketState {}

//class MarketInitial extends MarketState {}
class MarketInternetConnectionFailed extends MarketState {}

class MarketLoadedDone extends MarketState {}

class MarketLoadedFailed extends MarketState {}

class MarketLoadingState extends MarketState {}

class MarketProductsLoadedSuccess extends MarketState {}

class MarketProductsLoadedFailed extends MarketState {}

class MarketProductsLoadingState extends MarketState {}
