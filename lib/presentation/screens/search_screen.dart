//import 'package:beeorder/widgets/item.dart';
import 'package:beeorder_bloc/data/models/market_and_restaurant.dart';
import 'package:beeorder_bloc/data/models/product.dart';
import 'package:beeorder_bloc/logic/bloc/search_bloc.dart';
import 'package:beeorder_bloc/logic/cubit/restaurant_cubit.dart';
import 'package:beeorder_bloc/presentation/widgets/item.dart';
import 'package:beeorder_bloc/presentation/widgets/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:textfield_search/textfield_search.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> tabs = const ['Restaurant', 'Market', 'Items'];

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    print('iniiiiiiiiiiiiiiiiiiiiiiiiiiit');
    BlocProvider.of<RestaurantCubit>(context).getRestaurantList();
    BlocProvider.of<RestaurantCubit>(context).getAllRestProds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(),
      child: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is SearchInitial) {
            print('SearchInitial state');
          }
          if (state is SearchDone) {
            print('SearchDone state');
          }
          if (state is SearchFailed) {
            print('SearchFailed state');
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<SearchBloc>(context);
          final list = [bloc.rest, bloc.market, bloc.products];
          print('build');
          print(list[0]);
          print(list[1]);
          print(list[2]);
          return DefaultTabController(
            length: 3, //tabs.length,
            child: BlocConsumer<RestaurantCubit, RestaurantState>(
              listener: (context, state) {
                if (state is RestaurantProductsLoadedFailed) {
                  print('load restaurant products failed');
                  const snackBar = SnackBar(
                    content: Text(
                        'Some thing went wrong ,please check your internet connection'),
                    duration: Duration(seconds: 1),
                  );
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (state is RestaurantProductsLoadingState) {
                  print('Restaurant Products Loading State');
                }
              },
              buildWhen: (previous, current) =>
                  current is RestaurantProductsLoadingState ||
                  current is RestaurantProductsLoadedSuccess,
              builder: (context, loadState) {
                print(
                    'buildScaffolddddddddddddddddddddddddddddddddddddddddddddddddddd');
                print(loadState is RestaurantProductsLoadingState);
                print(loadState);
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    toolbarHeight: 80,
                    backgroundColor: Colors.white,
                    leading: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: size.width * 0.1,
                      child: IconButton(
                        padding: const EdgeInsets.only(left: 15),
                        splashRadius: 1,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    elevation: 0,
                    leadingWidth: 35,
                    title: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 35,
                      width: size.width * 0.83,
                      child: TextFormField(
                        //label: '123',
                        //minStringLength: 3,
                        /* future: () => Timer(
                                    const Duration(seconds: 5),
                                    () => ListView(
                                          children: [Text('test')],
                                        )),*/
                        enabled: loadState is RestaurantProductsLoadedSuccess,
                        onChanged: (value) {
                          //if (_controller.text.trim().isNotEmpty) {
                          BlocProvider.of<SearchBloc>(context).add(
                              SearchKeyChanged(
                                  word: _controller.text.trim().toLowerCase(),
                                  context: context));
                          // }
                        },
                        controller: _controller,
                        decoration: InputDecoration(
                          fillColor: const Color(0xFFECEEF1),
                          filled: true,
                          contentPadding: const EdgeInsets.only(left: 10),
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[900],
                          ),
                          hintText: 'Search by restaurant or item',
                          hintStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800]),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(width: 0, color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(width: 0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    bottom: TabBar(
                        isScrollable: true,
                        indicatorColor: const Color(0XFFEF6C00),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelPadding: EdgeInsets.zero,
                        labelColor: Colors.black,
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.w500),
                        unselectedLabelColor: Colors.grey[500],
                        tabs: List.generate(tabs.length, (index) {
                          final length = list[index].isNotEmpty
                              ? ' (${list[index].length.toString()})'
                              : '';
                          return Container(
                            child: Tab(
                              text: '${tabs[index]}$length',
                            ),
                            width: size.width / 3,
                          );
                        })),
                  ),
                  body: TabBarView(
                    children: List.generate(
                        list.length,
                        (index) => Stack(
                              children: [
                                ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    itemBuilder: (_, i) {
                                      if (list[index].isEmpty) {
                                        return Container(
                                          height: 0,
                                        );
                                      } else if (index == 0) {
                                        final restaurant = list[0][i]
                                            as RestaurantAndMarktModel;
                                        return Restaurant(
                                            restModel: restaurant,
                                            isloading: false);
                                      } else if (index == 2) {
                                        final smalList = list[index][i] as List;
                                        final product =
                                            smalList[0] as ProductModel;
                                        return Item(
                                          // itemName: product.title, //'itemName',
                                          product: product,
                                          restaurantName:
                                              smalList[1], //'restaurantName',
                                          // price: product.price, //'price',
                                          isOpen: smalList[2],
                                          //imgUrl: product.imageUrl, //'imgUrl',
                                        );
                                      } else {
                                        return Container(
                                          height: 0,
                                        );
                                      }
                                    },
                                    separatorBuilder: (_, __) =>
                                        list[index].isEmpty
                                            ? Container()
                                            : Container(
                                                // color: Colors.blue,
                                                child: const Divider(
                                                  color: Colors.black,
                                                ),
                                              ),
                                    itemCount: list[index].length),
                                if (loadState is RestaurantProductsLoadingState)
                                  ModalBarrier(
                                    color: Colors.grey.withOpacity(0.3),
                                    dismissible: false,
                                    barrierSemanticsDismissible: false,
                                  ),
                                if (loadState is RestaurantProductsLoadingState)
                                  const Center(
                                      child: CircularProgressIndicator()),
                              ],
                            )
                        /*ListView(
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    children: [
                                      Item(
                                          itemName: 'itemName',
                                          restaurantName: 'restaurantName',
                                          price: 'price',
                                          isOpen: 'isOpen',
                                          imgUrl: 'imgUrl')
                                    ],
                                  ),*/
                        ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
