import 'package:beeorder_bloc/logic/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'offer.dart';

class BuildOffersList extends StatefulWidget {
  const BuildOffersList({Key? key, required this.isLoading}) : super(key: key);
  final bool isLoading;
  @override
  State<BuildOffersList> createState() => _BuildOffersListState();
}

class _BuildOffersListState extends State<BuildOffersList> {
  @override
  Widget build(BuildContext context) {
    final offerRestProd =
        BlocProvider.of<HomeCubit>(context).homeRep.offerRestProducts;
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height > size.width
          ? (size.height / 3.5 < 80 ? 80 : size.height / 3.5)
          : (size.width / 3.5 < 80 ? 80 : size.width / 3.5),
      child: ListView.separated(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 5,
            right: 10,
          ),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => Offer(
                isLoading: widget.isLoading,
                index: index,
                catName: offerRestProd[index].catId,
                prodId: offerRestProd[index].id,
                restId: offerRestProd[index].restId,
              ),
          separatorBuilder: (_, __) => const SizedBox(
                width: 10,
              ),
          itemCount: offerRestProd.length),
    );
  }
}
