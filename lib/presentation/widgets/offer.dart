import 'package:beeorder_bloc/logic/cubit/home_cubit.dart';
import 'package:beeorder_bloc/presentation/screens/product_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Offer extends StatefulWidget {
  final String prodId;
  final String restId;
  final String catName;
  final int index;
  final bool isLoading;
  const Offer({
    Key? key,
    required this.index,
    required this.prodId,
    required this.restId,
    required this.catName,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<Offer> createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  @override
  Widget build(BuildContext context) {
    final offerProd = BlocProvider.of<HomeCubit>(context)
        .homeRep
        .offerRestProducts[widget.index];
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.isLoading
          ? null
          : () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(offerProd, true),
                ),
              )
                  .whenComplete(() {
                print(
                    'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc');
                return BlocProvider.of<HomeCubit>(context).setProdFav(
                  offerProd.isFavorite,
                  widget.prodId,
                  widget.restId,
                  widget.catName,
                  'offer',
                  widget.index,
                  context,
                );
              });
            },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red,
        ),
        width: size.height > size.width ? size.width / 3 : size.height / 3,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(0),
          elevation: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              offerProd.imageUrl,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
