part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

//class SearchLoading extends SearchState {}

class SearchDone extends SearchState {}

class SearchFailed extends SearchState {}
