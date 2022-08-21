part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchKeyChanged extends SearchEvent {
  final String word;
  final BuildContext context;
  SearchKeyChanged({
    required this.word,
    required this.context,
  });
}
