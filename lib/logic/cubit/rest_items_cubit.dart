import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'rest_items_state.dart';

class RestItemsCubit extends Cubit<RestItemsState> {
  RestItemsCubit() : super(RestItemsInitial());
}
