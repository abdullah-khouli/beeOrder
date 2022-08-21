part of 'cart_cubit.dart';

@immutable
abstract class CartState {
  final bool isChanged;
  const CartState({
    this.isChanged = false,
  });
}

class CartDetailsChanged extends CartState {
  final String prodId;
  final bool changed;
  const CartDetailsChanged({
    required this.prodId,
    required this.changed,
  }) : super(isChanged: changed);
}

class CartItemDeleted extends CartState {
  final int itemCount;
  const CartItemDeleted({required this.itemCount});
}
