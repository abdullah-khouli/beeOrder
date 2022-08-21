import 'package:beeorder_bloc/data/models/cart_item.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartItemDeleted(itemCount: 0));
  Map<String, CartItem> items = {};
  // int counter = 1;
  //this map consist of String key which is product id
  //and CartItem value which has a unique ID equal to dateTime.now
  //and contains the title and price of a certain product and the amount of this product
  int get itemcount {
    return items.length;
  }

  double get totalAmount {
    var total = 0.0;
    items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  void addItem(String prodId, double price, String title, int quant) {
    if (items.containsKey(prodId)) {
      //هاد الشرط مشان شوف المنتج موجود ولا لا اذا موجود معناتا انا عم زيد الكمية اذا لا معناتا عم ضيف واحد جديد
      /* _items.update(
        prodId,
        (existingCardItem) => CartItem(
            id: existingCardItem.id,
            title: existingCardItem.title,
            quantity: existingCardItem.quantity + 1,
            price: existingCardItem.price),
      );*/
      items[prodId]!.quantity += quant;
    } else {
      items.putIfAbsent(
        prodId,
        () => CartItem(
          prodId: prodId,
          id: DateTime.now().toString(),
          title: title,
          quantity: quant,
          price: price,
        ),
      );
      emit(CartItemDeleted(itemCount: itemcount));
    }
    print(items);
    //notifyListeners();
  }

  bool removeItem(String prodId) {
    items.remove(prodId);
    // emit(CartDetailsChanged(prodId: prodId, changed: !state.isChanged));
    emit(CartItemDeleted(itemCount: itemcount));
    if (items.isEmpty) {
      return true;
    }
    return false;
    //notifyListeners();
  }

  /*void removeSingleItem(String prodId) {
    if (!items.containsKey(prodId)) {
      return;
    }
    if (items[prodId]!.quantity > 1) {
      items.update(
        prodId,
        (existingCardItem) => CartItem(
            prodId: prodId,
            id: existingCardItem.id,
            title: existingCardItem.title,
            quantity: existingCardItem.quantity - 1,
            price: existingCardItem.price),
      );
    } else {
      items.remove(prodId);
    }
//    notifyListeners();
  }*/

  bool updateQuantity(String prodId, bool isAdd) {
    if (isAdd) {
      items[prodId]!.quantity += 1;
      print(items[prodId]!.quantity);
      emit(CartDetailsChanged(prodId: prodId, changed: !state.isChanged));
    } else {
      if (items[prodId]!.quantity > 1) {
        items[prodId]!.quantity -= 1;
        emit(CartDetailsChanged(prodId: prodId, changed: !state.isChanged));
      } else {
        return removeItem(prodId);
      }
    }
    return false;

    //  notifyListeners();
  }
}
