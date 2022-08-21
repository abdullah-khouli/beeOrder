/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/authRep.dart';
import '../providers/cartRep.dart';
import '../providers/productRep.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('=========fav=========');
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    print('=========faf=========');
    return ClipRRect(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: GridTile(
            footer: GridTileBar(
              backgroundColor: Color(0xFFECEFF1),
              leading: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Text(
                  product.price.toString(),
                  textAlign: TextAlign.left,
                ),
              ),
              /*IconButton(
              // هون هو عمل وراب للايكون بوتن بكونسيومر نوعه برودكت لانو فوق عامل الليسن فولس وانا بدي ياه ترو
              //بس انا ماعملت هيك وانما كتبت نفس السطر فوق وعملت الليسن ترو واشتغل تمام
              onPressed: () {
                var x = authData.userId;
                print('userid is is ${authData.userId}');
                print('x is $x');
                product.toggleFavoriteStatus(authData.token, authData.userId);
              },
              icon: Icon(
                Provider.of<Product>(context).isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Theme.of(context).accentColor,
              ),
            ),*/
              trailing: Container(
                width: 89,
                alignment: Alignment.centerRight,
                child: Text(
                  product.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.right,
                ),
              ),

              /* IconButton(
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                Scaffold.of(context)
                    .hideCurrentSnackBar(); //هذا السطر حتى لانضيف اكثر من سناك بار فوق بعض
                // في حال قام اليوزر باضافة كذا منتج بسرعة حيث زمن السناك ثانيتين
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added to cart'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                        label: 'UNDO!',
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        }),
                  ),
                );
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).accentColor,
              ),
            ),*/
            ),
            child: ChangeNotifierProvider.value(
              value: product,
              builder: (ctx, widget) => widget,
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(product),
                )),
                child: Hero(
                  tag: product.id,
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder:
                        AssetImage('assets/images/product-placeholder.png'),
                    image: NetworkImage(product.imageUrl),
                  ),
                ),
              ),
            )),
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }
}*/
