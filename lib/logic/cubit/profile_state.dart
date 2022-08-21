part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class FavInternetConnectionFailed extends ProfileState {}

class FavListsLoadingState extends ProfileState {}

class FavListsLoadedSuccess extends ProfileState {}

class FavListsLoadedFailed extends ProfileState {}
