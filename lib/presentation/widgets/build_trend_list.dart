import 'package:beeorder_bloc/logic/cubit/home_cubit.dart';
import 'package:beeorder_bloc/presentation/widgets/trend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildTrenList extends StatefulWidget {
  const BuildTrenList({Key? key, required this.isLoading}) : super(key: key);
  final bool isLoading;

  @override
  State<BuildTrenList> createState() => _BuildTrenListState();
}

class _BuildTrenListState extends State<BuildTrenList> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final trendRestProd =
        BlocProvider.of<HomeCubit>(context).homeRep.trendRestProducts;
    return SizedBox(
      height: size.height / 6.4 < 60 ? 125 : (size.height / 6.4) + 65,
      child: ListView.separated(
          padding:
              const EdgeInsets.only(top: 10, bottom: 25, left: 5, right: 10),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => Trend(
                isLoading: widget.isLoading,
                index: index,
                catName: trendRestProd[index].catId,
                prodId: trendRestProd[index].id,
                restId: trendRestProd[index].restId,
              ),
          separatorBuilder: (_, __) => const SizedBox(
                width: 20,
              ),
          itemCount: trendRestProd.length),
    );
  }
}
