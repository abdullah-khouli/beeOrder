import 'package:beeorder_bloc/data/models/market_and_restaurant.dart';
import 'package:beeorder_bloc/presentation/widgets/shimmer/shimmer_loading.dart';
import 'package:flutter/material.dart';

class Market extends StatelessWidget {
  const Market({Key? key, required this.restModel, this.isloading = false})
      : super(key: key);
  final RestaurantAndMarktModel restModel;
  final bool? isloading;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(size.width);
    print(isloading);
    return ShimmerLoading(
      isLoading: isloading,
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(vertical: 7),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
              width: size.width,
              height: size.height / 4.26 < 125 ? 125 : size.height / 4.26,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    child: Hero(
                      tag: restModel.id,
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: const AssetImage(
                            'assets/images/restaurantPlaceHolder.png'),
                        image: NetworkImage(restModel.coverPhotoUrl),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      margin: const EdgeInsets.only(right: 10, bottom: 10),
                      // height: size.height / 22 < 25 ? 25 : size.height / 22,
                      child: Text(
                        restModel.timeToDeliver == ''
                            ? ''
                            : '${restModel.timeToDeliver} min',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize:
                              size.height / 45 < 12 ? 12 : size.height / 45,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  restModel.logoUrl,
                ),
                radius: size.height / 32 < 12 ? 12 : size.height / 32,
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: (size.width -
                    30 -
                    (size.height / 32 < 12 ? 12 : size.height / 32) * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: isloading == true
                      ? [
                          Container(
                            height: size.height / 45,
                            width: double.infinity,
                            color: Colors.black,
                          ),
                          SizedBox(height: size.height / 90),
                          Container(
                            height: size.height / 45,
                            width: double.infinity,
                            color: Colors.black,
                          ),
                        ]
                      : [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  restModel.name,
                                  style: TextStyle(
                                    fontSize: size.height / 40 < 12
                                        ? 12
                                        : size.height / 40,
                                    color: const Color(0XFFEF6C00),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      restModel.isOnline,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: size.height / 45 < 12
                                            ? 12
                                            : size.height / 45,
                                        color: Colors.teal,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    if (restModel.isOnline != '')
                                      const Icon(
                                        Icons.circle,
                                        color: Colors.teal,
                                        size: 10,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  restModel.type != null
                                      ? '${restModel.type}'
                                      : '',
                                  style: TextStyle(
                                    fontSize: size.height / 55 < 10
                                        ? 10
                                        : size.height / 55,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey[900],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  (restModel.deliveryFee == null ||
                                          restModel.deliveryFee == '')
                                      ? ''
                                      : 'Delivery Fee : ${restModel.deliveryFee} SYP',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.height / 55 < 10
                                        ? 10
                                        : size.height / 55,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
