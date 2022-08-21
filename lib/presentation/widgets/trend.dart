import 'package:beeorder_bloc/logic/cubit/home_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/restaurant_cubit.dart';
import 'package:beeorder_bloc/presentation/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Trend extends StatefulWidget {
  final String prodId;
  final String restId;
  final String catName;
  final int index;
  final bool isLoading;
  const Trend({
    Key? key,
    required this.index,
    required this.prodId,
    required this.restId,
    required this.catName,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<Trend> createState() => _TrendState();
}

class _TrendState extends State<Trend> {
  @override
  Widget build(BuildContext context) {
    final trendProd = BlocProvider.of<HomeCubit>(context)
        .homeRep
        .trendRestProducts[widget.index];
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: widget.isLoading
                  ? null
                  : () {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(trendProd, true),
                        ),
                      )
                          .whenComplete(() async {
                        print(
                            'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc');
                        await BlocProvider.of<HomeCubit>(context).setProdFav(
                            trendProd.isFavorite,
                            widget.prodId,
                            widget.restId,
                            widget.catName,
                            'trend',
                            widget.index,
                            context);
                      });
                      print(
                          'dddddddddddddddddddddddddddddddddddddddddddddddddddd');
                    },
              child: Container(
                height: size.height / 6.4 < 60 ? 60 : size.height / 6.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                width: size.width / 2,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(0),
                  elevation: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      trendProd
                          .imageUrl, //'https://png.pngtree.com/png-clipart/20190515/original/pngtree-vector-cartoon-illustration-of-a-traditional-set-of-fast-food-me-png-image_3565698.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  //  height: size.height / 4 < 80 ? 80 : size.height / 4,
                  /* 
                             */
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 7, left: 7),
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(
                    'https://banner2.cleanpng.com/20180323/obq/kisspng-t-shirt-polo-shirt-lacoste-clothing-sizes-polo-shirt-5ab57a46dad160.5622717315218427588963.jpg',
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 20,
          child: const Text(
            ' Meal Name',
            // textAlign: TextAlign.left,
          ),
        )
      ],
    );
  }
}
