part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

////////////////////////////////////////////////////////
//loading named list
class NamedListLoadingState extends HomeState {}

class NamedListLoadedSuccess extends HomeState {}

class NamedListLoadedFailed extends HomeState {}

class HomeInternetConnectionFailed extends HomeState {}
