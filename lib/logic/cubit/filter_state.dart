part of 'filter_cubit.dart';

@immutable
abstract class FilterState {}

class FilterInitial extends FilterState {}
class RestaurantFilterLoadingState extends FilterState {}

class RestaurantFilterLoadingDone extends FilterState {}

class RestaurantFilterLoadingFailed extends FilterState {
  final String exception;
  RestaurantFilterLoadingFailed({
    required this.exception,
  });
}