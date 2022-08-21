/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/widgets/product_item.dart';
import '../providers/products.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  final String? filter;
  const ProductsGrid({Key? key, required this.showFavs, this.filter})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<Products>(context);
    final products =
        showFavs ? productProvider.favoritesItem : productProvider.items;
    return products.isEmpty
        ? Stack(
            children: [
              ListView(),
              Center(
                child: Text('There is no products'),
              ),
            ],
          )
        : GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (BuildContext ctx, int index) {
              return ChangeNotifierProvider.value(
                //س : هون ماعرفت ليش حط هاد البروفايدر وجربت قيمو قام عطاني ايرور
                //الجواب لانو بالتشايلد مستخدم بروفايدر نوع برودكت
                value: products[index],
                child: ProductItem(),
              );
            },
            itemCount: products.length,
          );
  }
}*/
