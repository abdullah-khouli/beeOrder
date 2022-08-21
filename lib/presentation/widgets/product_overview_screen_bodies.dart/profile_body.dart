import 'package:beeorder_bloc/logic/cubit/auth_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/profile_cubit.dart';
import 'package:beeorder_bloc/presentation/screens/profile_screen.dart';
import 'package:beeorder_bloc/presentation/screens/settings.dart';
import 'package:beeorder_bloc/presentation/widgets/build_dishes_fav_list.dart';
import 'package:beeorder_bloc/presentation/widgets/build_rest_fav_list.dart';
import 'package:beeorder_bloc/presentation/widgets/shimmer/big_shimmer.dart';
import 'package:beeorder_bloc/presentation/widgets/shimmer/shimmer_gradient.dart';
import 'package:beeorder_bloc/presentation/widgets/shimmer/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({
    Key? key,
    required this.size,
    required this.topPadding,
  }) : super(key: key);
  final double topPadding;
  final Size size;

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).getFavList();
    BlocProvider.of<AuthCubit>(context).getUserProfileData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      print('callllllllllllllllllllllllled');
      return NestedScrollView(
        headerSliverBuilder: (BuildContext _, bool innerBoxIsScrolled) => [
          SliverAppBar(
            titleSpacing: 0,
            leadingWidth: 0,
            title: Column(
              children: [
                Container(
                  height: (widget.size.height / 4 < 120
                          ? 120
                          : widget.size.height / 4) +
                      (widget.size.height / 10.67 < 50
                          ? 50
                          : widget.size.height / 10.67), //size.height / 2.91,
                  // color: Colors.blue,
                  child: Stack(
                    // fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        child: Container(
                          // margin: EdgeInsets.only(bottom: size.height * 0.11),
                          // color: Colors.blue,
                          height: widget.size.height / 4 < 120
                              ? 120
                              : widget.size.height / 4,
                          width: widget.size.width,
                          child: Image.asset(
                            'assets/images/profile.jpg',
                            fit: BoxFit.cover,
                          ),

                          /*Image.network(
                  coverPhotoUrl,
                  fit: BoxFit.fill,
                ),*/
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,

                        /*padding: EdgeInsets.only(
                                    right: (size.width * 0.5) - 60),*/
                        child: Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                widget.size.height / 10.67 < 50
                                    ? 50
                                    : widget.size.height / 10.67),
                            child: Image.asset(
                              'assets/images/splash.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          width: widget.size.height / 5.33 < 50
                              ? 50
                              : widget.size.height / 5.33,
                          height: widget.size.height / 5.33 < 50
                              ? 50
                              : widget.size.height / 5.33,
                        ),
                      ),
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, right: 15),
                          child: GestureDetector(
                            child: Icon(
                              Icons.edit,
                              size: widget.size.height / 23.7 < 20
                                  ? 20
                                  : widget.size.height / 23.7,
                              color: Colors.white,
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => Profile(size: widget.size)));
                            },
                          ),
                        ),
                        alignment: Alignment.topRight,
                      )
                    ],
                  ),
                ),
                Container(
                  //color: Colors.red,
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  height: widget.size.height / 32 < 15
                      ? 15
                      : widget.size.height / 32,
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is GettingUserDataFailed) {
                        const snackBar = SnackBar(
                          content: Text('some thing went wrong'),
                        );
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    buildWhen: (previous, current) =>
                        current is GettingUserData ||
                        current is GettingUserDataDone ||
                        current is GettingUserDataFailed,
                    builder: (context, state) {
                      return Text(
                        BlocProvider.of<AuthCubit>(context).authRep.username,
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: widget.size.height / 42.6 < 12
                              ? 12
                              : widget.size.height / 42.6,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                  //   color: Colors.green,
                ),
                SizedBox(
                  height: widget.size.height / 64,
                )
              ],
            ),
            primary: false,
            bottom: PreferredSize(
              child: Container(
                margin: EdgeInsets.only(top: widget.size.height / 32),
                height:
                    widget.size.height / 16 < 30 ? 30 : widget.size.height / 16,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: (widget.size.width - 4) / 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.grey[700],
                              size: widget.size.height / 27.826 < 15
                                  ? 15
                                  : widget.size.height / 27.826,
                            ),
                            Text(
                              'My Order',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: widget.size.height / 49.23 < 11
                                    ? 11
                                    : widget.size.height / 49.23,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: widget.size.height / 16 < 30
                          ? 30
                          : widget.size.height / 16,
                      child: const VerticalDivider(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: (widget.size.width - 4) / 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.grey[700],
                              size: widget.size.height / 27.826 < 15
                                  ? 15
                                  : widget.size.height / 27.826,
                            ),
                            Text('My Address',
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: widget.size.height / 49.23 < 11
                                        ? 11
                                        : widget.size.height / 49.23)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: widget.size.height / 16 < 30
                          ? 30
                          : widget.size.height / 16,
                      child: const VerticalDivider(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const Settings(),
                          ),
                        );
                        /*  Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const UserDataScreen(),
                          ),
                        );*/
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: (widget.size.width - 4) / 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.grey[700],
                              size: widget.size.height / 27.826 < 15
                                  ? 15
                                  : widget.size.height / 27.826,
                            ),
                            Text('Settings',
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: widget.size.height / 49.23 < 11
                                        ? 11
                                        : widget.size.height / 49.23)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              preferredSize: widget.size / 10.67,
            ),
            elevation: 2,
            toolbarHeight: ((widget.size.height / 4 < 120
                    ? 120
                    : widget.size.height / 4) +
                (widget.size.height / 10.67 < 50
                    ? 50
                    : widget.size.height / 10.67) +
                (widget.size.height / 32 < 15 ? 15 : widget.size.height / 32) +
                (widget.size.height / 64)), //size.height / 2.56,
            //    centerTitle: true,
            backgroundColor: Colors.white,
            expandedHeight: (((widget.size.height / 4 < 120
                        ? 120
                        : widget.size.height / 4) +
                    (widget.size.height / 10.67 < 50
                        ? 50
                        : widget.size.height / 10.67) +
                    (widget.size.height / 32 < 15
                        ? 15
                        : widget.size.height / 32) +
                    (widget.size.height / 64)) +
                (widget.size.height / 10.67)), //

            pinned: false,
            floating: false,
          ),
        ],
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            print('objecttttttttttttttttttttttttttttttttttt');
            print(state);
          },
          buildWhen: (previous, current) =>
              current is FavListsLoadingState ||
              current is FavListsLoadedSuccess,
          builder: (context, state) {
            return Shimmer(
                linearGradient: shimmerGradient,
                child: RefreshIndicator(
                  onRefresh: state is FavListsLoadingState
                      ? () async {}
                      : () async {
                          await BlocProvider.of<ProfileCubit>(context)
                              .getFavList();
                        },
                  child: ShimmerLoading(
                    isLoading: state is FavListsLoadingState,
                    child: ListView(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          color: Colors.white,
                          width: widget.size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: const [
                              Text('Favorite Dishes'),
                              SizedBox(width: 10),
                              Icon(
                                Icons.favorite,
                                color: Color(0XFFEF6C00),
                                size: 18,
                              )
                            ],
                          ),
                        ),
                        BuildProdFavList(
                          isLoading: state is FavListsLoadingState,
                        ),
                        const SizedBox(height: 25),
                        Container(
                          color: Colors.white,
                          width: widget.size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: const Text('Invite your friends'),
                        ),
                        Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 10, left: 15, right: 15),
                            height: 100,
                            child: Stack(
                              children: [
                                const Text(
                                  'Receive a voucher of 5000 SP by \nsesnding invitation to (5/5) of your friends.',
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Send Invitations',
                                      style:
                                          TextStyle(color: Color(0XFFEF6C00)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          color: Colors.white,
                          width: widget.size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: const [
                              Text('Favorite Restaurants'),
                              SizedBox(width: 10),
                              Icon(
                                Icons.favorite,
                                color: Color(0XFFEF6C00),
                                size: 18,
                              )
                            ],
                          ),
                        ),
                        BuildRestFavList(
                          isLoading: state is FavListsLoadingState,
                        ),
                        const SizedBox(
                          height: 600,
                        )
                      ],

                      // itemExtent: 700
                    ),
                  ),
                ));
          },
        ),

        //  physics: s,
      );
    });
  }
}
