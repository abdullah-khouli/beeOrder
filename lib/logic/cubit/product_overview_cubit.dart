import 'package:bloc/bloc.dart';

part 'product_overview_state.dart';

class ProductOverviewCubit extends Cubit<ProductOverviewState> {
  ProductOverviewCubit()
      : super(ProductOverviewState(currentIndex: 0, rebuild: true));
  changeCurrentIndex(int newIndex) {
    emit(ProductOverviewState(currentIndex: newIndex, rebuild: false));
  }
}
