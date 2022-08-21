import 'package:beeorder_bloc/data/models/market_and_restaurant.dart';
import 'package:beeorder_bloc/logic/cubit/market_cubit.dart';
import 'package:beeorder_bloc/presentation/screens/market_items_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'markets.dart';

class BuildMarketList extends StatefulWidget {
  const BuildMarketList({Key? key, required this.isLoading}) : super(key: key);
  final bool? isLoading;
  @override
  State<BuildMarketList> createState() => _BuildMarketListState();
}

class _BuildMarketListState extends State<BuildMarketList> {
  @override
  void initState() {
    print('market inittttt');
    //i call it in prod overview screen instead
    //BlocProvider.of<MarketCubit>(context).getMarketList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<RestaurantAndMarktModel> marketList =
        BlocProvider.of<MarketCubit>(context).marketRep.markets;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: marketList
          .map(
            (market) => GestureDetector(
              onTap: widget.isLoading == false
                  ? () {
                      BlocProvider.of<MarketCubit>(context)
                          .emitLodingProducts();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                                value: BlocProvider.of<MarketCubit>(context),
                                child: MarketsItems(market.id),
                              )));
                    }
                  : null,
              child: Market(restModel: market, isloading: widget.isLoading),
            ),
          )
          .toList(),
    );
  }
}
