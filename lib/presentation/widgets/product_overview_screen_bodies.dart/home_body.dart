import 'package:beeorder_bloc/logic/cubit/home_cubit.dart';
import 'package:beeorder_bloc/presentation/widgets/build_trend_list.dart';
import 'package:beeorder_bloc/presentation/widgets/shimmer/big_shimmer.dart';
import 'package:beeorder_bloc/presentation/widgets/shimmer/shimmer_gradient.dart';
import 'package:beeorder_bloc/presentation/widgets/shimmer/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../build_new_list.dart';
import '../build_offers_list.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key, required this.topPadding}) : super(key: key);
  final double topPadding;
  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    print('home body intit function called');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(MediaQuery.of(context).padding.top);
    print('home body size = $size');
    return Container(
      height: (size.height -
          ((size.height / 20 < 28 ? 28 : size.height / 20) //serch textfield
              +
              10 +
              (size.height / 13 < 35 ? 35 : size.height / 13) //toolBarHeight
              +
              56 //bottom Navigation Bar
              +
              widget.topPadding)),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          print('llllllllllllllllllllllllllllllllllll');
          print(state);
          if (state is HomeInternetConnectionFailed) {
            const snackBar = SnackBar(
              content: Text('No internet connection'),
            );
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          // TODO: implement listener
        },
        buildWhen: (previous, current) => ((current is NamedListLoadingState) ||
            (current is NamedListLoadedSuccess)),
        builder: (context, state) {
          print('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');
          print(state);
          return Shimmer(
            linearGradient: shimmerGradient,
            child: RefreshIndicator(
              onRefresh: state is NamedListLoadingState
                  ? () async {}
                  : () async =>
                      BlocProvider.of<HomeCubit>(context).getNamedList(),
              child: ShimmerLoading(
                isLoading: state is NamedListLoadingState,
                child: ListView(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'BeeORDER Offers',
                            style: TextStyle(
                              fontSize:
                                  size.height / 38 < 15 ? 15 : size.height / 38,
                            ),
                          ),
                          TextButton.icon(
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    const Color(0xFFECEEF1))),
                            onPressed: () {},
                            icon: Text(
                              'View All',
                              style: TextStyle(
                                  fontSize: size.height / 42 < 13
                                      ? 13
                                      : size.height / 42,
                                  color: const Color(0XFFEF6C00)),
                            ),
                            label: const Icon(
                              Icons.fast_forward_outlined,
                              size: 18,
                              color: Color(0XFFEF6C00),
                            ),
                          )
                        ],
                      ),
                    ),
                    BuildOffersList(
                      isLoading: state is NamedListLoadingState,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        'BeeOrder',
                        style: TextStyle(
                          fontSize:
                              size.height / 38 < 15 ? 15 : size.height / 38,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          right: (size.width / 2.1) - 30, left: 5),
                      color: Colors.white,
                      width: size.width * 0.5,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0XFFEF6C00)),
                            elevation: MaterialStateProperty.all(2),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text(
                                'MY VOUCHERS',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            'Trending Dishes',
                            style: TextStyle(
                              fontSize:
                                  size.height / 38 < 15 ? 15 : size.height / 38,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.fireplace_outlined,
                            color: Color(0XFFEF6C00),
                          )
                        ],
                      ),
                    ),
                    BuildTrenList(isLoading: state is NamedListLoadingState),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            'New BeeORDER',
                            style: TextStyle(
                              fontSize:
                                  size.height / 38 < 15 ? 15 : size.height / 38,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.fireplace_outlined,
                            color: Color(0XFFEF6C00),
                          )
                        ],
                      ),
                    ),
                    BuildNewList(isLoading: state is NamedListLoadingState)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
