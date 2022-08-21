import 'package:beeorder_bloc/logic/cubit/home_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/restaurant_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'new.dart';

class BuildNewList extends StatefulWidget {
  const BuildNewList({Key? key, required this.isLoading}) : super(key: key);
  final bool isLoading;

  @override
  State<BuildNewList> createState() => _BuildNewListState();
}

class _BuildNewListState extends State<BuildNewList> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final newRestProd =
        BlocProvider.of<HomeCubit>(context).homeRep.newRestProducts;
    return Container(
      height: size.height / 4.923 < 75 ? 130 : (size.height / 4.923) + 55,
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 10, bottom: 15, left: 5, right: 10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => New(
          isLoading: widget.isLoading,
          index: index,
          catName: newRestProd[index].catId,
          prodId: newRestProd[index].id,
          restId: newRestProd[index].restId,
        ),
        separatorBuilder: (_, __) => const SizedBox(
          width: 20,
        ),
        itemCount: newRestProd.length,
      ),
    );
  }
}
