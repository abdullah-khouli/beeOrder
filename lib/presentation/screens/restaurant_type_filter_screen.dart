//import 'package:beeorder/screens/restaurant_items_screen.dart';
//import 'package:beeorder/widgets/restaurant.dart';
import 'package:beeorder_bloc/data/models/market_and_restaurant.dart';
import 'package:beeorder_bloc/presentation/widgets/restaurant.dart';
import 'package:flutter/material.dart';

import 'restaurant_items_screen.dart';

class RestaurantTypeFilter extends StatelessWidget {
  const RestaurantTypeFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: size.height / 12.8 < 27 ? 27 : size.height / 12.8,
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: size.width * 0.15,
        leading: Container(
          height: size.height / 12.8,
          //margin: EdgeInsets.only(bottom: 10),
          width: size.width * 0.15,
          child: IconButton(
            //padding: EdgeInsets.only(left: 15),
            splashRadius: 1,
            onPressed: () {
              FocusScope.of(context).unfocus();
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: size.height / 40 < 13 ? 13 : size.height / 40,
              color: Colors.black,
            ),
          ),
        ),
        //leadingWidth: 0,
        titleSpacing: 0,
        title: Container(
          alignment: Alignment.centerLeft,
          // margin: EdgeInsets.only(bottom: 10),
          height: size.height / 12.8,
          width: size.width * 0.83,
          child: Text(
            'Choose your filter',
            style: TextStyle(
              color: const Color(0XFFEF6C00),
              fontSize: size.height / 40 < 13 ? 13 : size.height / 40,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),

            height: size.height / 16 < 38 ? 38 : size.height / 16,
            //width: 240,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(
                  'Deliver to:',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size.height / 46 < 13 ? 13 : size.height / 46,
                      letterSpacing: 0.01,
                      fontWeight: FontWeight.w600),
                ),
                TextButton.icon(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {},
                  icon: Text(
                    'Current location',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: size.height / 46 < 13 ? 13 : size.height / 46,
                        letterSpacing: 0.01,
                        fontWeight: FontWeight.w600),
                  ),
                  label: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                    size: size.height / 26 < 16 ? 16 : size.height / 26,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: const Divider(
              color: Colors.black,
            ),
            height: 2,
          ),
          const SizedBox(height: 8),
          Container(
              //   color: Colors.blue,
              height: size.height / 6 < 65 ? 65 : size.height / 6,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(
                      left: 10, right: 10, bottom: size.height < 400 ? 10 : 20),
                  itemBuilder: (_, __) => GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://png.pngtree.com/png-clipart/20190515/original/pngtree-vector-cartoon-illustration-of-a-traditional-set-of-fast-food-me-png-image_3565698.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                          height: size.height / 6 < 65
                              ? 65 - 20
                              : (size.height / 6) - 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.red,
                          ),
                          width: size.width * 0.25,
                        ),
                      ),
                  separatorBuilder: (_, __) => const SizedBox(
                        width: 8,
                      ),
                  itemCount: 5)),
          const SizedBox(height: 5),
          Container(
            child: ListView(
              padding: const EdgeInsets.only(
                  bottom: 50, left: 10, right: 10, top: 10),
              children: List.generate(
                3,
                (index) => GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          RestaurantItems(index.toString(), false))),
                  child: Restaurant(
                    restModel: RestaurantAndMarktModel(
                        deliveryFee: '800',
                        id: index.toString(),
                        coverPhotoUrl:
                            'https://png.pngtree.com/png-clipart/20201208/original/pngtree-wide-avenue-png-image_5609305.jpg',
                        logoUrl:
                            'https://banner2.cleanpng.com/20180323/obq/kisspng-t-shirt-polo-shirt-lacoste-clothing-sizes-polo-shirt-5ab57a46dad160.5622717315218427588963.jpg',
                        name: 'Restaurant name',
                        timeToDeliver: '63 - 73 min',
                        isOnline: 'Online',
                        type: 'test'),
                    isloading: false,
                  ),
                ),
              ),
            ),
            height: size.height -
                ((MediaQuery.of(context).padding.top) +
                    (size.height / 12.8 < 27 ? 27 : size.height / 12.8) +
                    (size.height / 16 < 38 ? 38 : size.height / 16) +
                    (size.height / 6 < 65 ? 65 : size.height / 6) +
                    15 +
                    20),
          )
        ],
      ),
    );
  }
}
