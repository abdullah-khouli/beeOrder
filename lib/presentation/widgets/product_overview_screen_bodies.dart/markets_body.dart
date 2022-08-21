import 'package:beeorder_bloc/logic/cubit/market_cubit.dart';
import 'package:beeorder_bloc/presentation/widgets/shimmer/big_shimmer.dart';
import 'package:beeorder_bloc/presentation/widgets/shimmer/shimmer_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../build_market_list.dart';

class MarketsBody extends StatelessWidget {
  const MarketsBody({Key? key, required this.topPadding}) : super(key: key);
  final double topPadding;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: (size.height -
          ((size.height / 20 < 28 ? 28 : size.height / 20) +
              10 +
              (size.height / 13 < 35 ? 35 : size.height / 13) +
              56 +
              topPadding)),
      child: BlocConsumer<MarketCubit, MarketState>(
        listener: (context, state) {
          if (state is MarketInternetConnectionFailed) {
            const snackBar = SnackBar(
              content: Text('No internet connection'),
            );
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is MarketLoadedFailed) {
            print('load market failed');
            const snackBar = SnackBar(
              content: Text('Some thing went wrong ,try again later'),
            );
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is MarketLoadedDone) {
            print('Market loaded successfuly');
          } else if (state is MarketLoadingState) {
            print('loading');
          }
        },
        buildWhen: (previous, current) => (current is MarketLoadedDone ||
            current is MarketLoadingState ||
            current is MarketLoadedFailed),
        builder: (context, state) {
          print('build market list');
          print('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
          return RefreshIndicator(
            onRefresh: (state is MarketLoadingState)
                ? () async {}
                : () async {
                    await BlocProvider.of<MarketCubit>(context).getMarketList();
                  },
            child: ListView(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 20,
              ),
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                  child: Text(
                    'BeeMarket',
                    style: TextStyle(
                      fontSize: size.height / 45 < 13 ? 13 : size.height / 45,
                      color: Colors.black,
                    ),
                  ),
                ),
                Shimmer(
                  linearGradient: shimmerGradient,
                  child: BuildMarketList(
                      isLoading: state is MarketLoadedFailed
                          ? null
                          : (state is MarketLoadingState)),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
