import 'package:flutter/material.dart';

class RestaurantAppBar extends StatelessWidget {
  const RestaurantAppBar({
    Key? key,
    required this.coverPhotoUrl,
    required this.deliveryFee,
    required this.logoUrl,
    required this.restaurantName,
    required this.restaurantType,
    required this.timeToDeliver,
    required this.id,
  }) : super(key: key);
  final String coverPhotoUrl;
  final String id;
  final String timeToDeliver;
  final String logoUrl;
  final String restaurantName;
  final String restaurantType;
  final String deliveryFee;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(size.width);
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          child: Container(
            margin: EdgeInsets.only(bottom: size.height * 0.11),
            height: size.height / 3.368,
            width: size.width,
            child: FadeInImage(
              fit: BoxFit.fill,
              placeholder:
                  const AssetImage('assets/images/restaurantPlaceHolder.png'),
              image: NetworkImage(coverPhotoUrl),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            margin:
                EdgeInsets.only(right: 10, bottom: 10 + (size.height * 0.11)),
            // height: size.height / 22 < 25 ? 25 : size.height / 22,
            child: Text(
              timeToDeliver,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: size.height / 45 < 12 ? 12 : size.height / 45,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    )
        /* Container(
          height: 60,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                  logoUrl,
                ),
                radius: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: (size.width - 65),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hello',
                            style: TextStyle(
                              fontSize: size.height / 40,
                              color: Color(0XFFEF6C00),
                            ),
                          ),
                          Text(
                            timeToDeliver,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: size.width / 22,
                              color: Color(0XFFEF6C00),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$restaurantType',
                            style: TextStyle(
                              fontSize: size.width / 25,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Delivery Fee : $deliveryFee',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.width / 25,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
              /* Container(
                width: size.width * 0.35,
                child: RichText(
                  maxLines: null,
                  text: TextSpan(
                    text: 'Hello',
                    style: TextStyle(
                      fontSize: size.width / 18,
                      color: Color(0XFFEF6C00),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '\n$restaurantType',
                        style: TextStyle(
                          fontSize: size.width / 25,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),*/
              /* Spacer(),*/
              /* Container(
                width: size.width * 0.37,
                child: RichText(
                  textAlign: TextAlign.end,
                  maxLines: null,
                  text: TextSpan(
                    text: '|',
                    style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: size.width / 18,
                      color: Colors.white,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: timeToDeliver,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: size.width / 22,
                          color: Color(0XFFEF6C00),
                        ),
                      ),
                      TextSpan(
                        text: '\n Delivery Fee : $deliveryFee',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: size.width / 25,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            */
            ],
          ),
        ),*/
        /* SizedBox(
          height: 10,
        )*/
        ;
  }
}
