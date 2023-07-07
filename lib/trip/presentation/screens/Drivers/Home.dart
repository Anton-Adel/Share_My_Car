import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gp/Notifications/NotificationsPage.dart';
import 'package:gp/trip/presentation/components/my_trips.dart';
import 'package:gp/trip/presentation/controller/trip_cubit.dart';
import 'package:gp/user/presentation/controller/login/login_cubit.dart';
import 'package:intl/intl.dart';

import '../../../../AboutUS/AboutUS.dart';
import 'RidersListPage.dart';
import '../../../../Setting/SettingPage.dart';
import '../../../../core/shared_components/Constants.dart';
import '../../../../map/location.dart';
import '../../../../user/presentation/screens/Login/LoginPage.dart';
import '../../../../user/presentation/screens/Register/SignupPage.dart';
import '../../components/book_trip.dart';
import '../../components/share_car_trip.dart';
import '../../controller/trip_state.dart';
import 'DriversListPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage>, TickerProviderStateMixin {
  // GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(2);
  }

  static const List<Tab> _tabs = [
    Tab(
      child: Text(
        "Book Trip",
      ),
    ),
    Tab(
      child: Text(
        "Share Car",
      ),
    ),
    Tab(
      child: Text(
        "My Trips",
      ),
    ),
  ];

  // The rating value
  double? _ratingValue;

  @override
  Widget build(BuildContext context) { //انا هنا شيلت ال كيوبت وخليته عام علشان هستخدمه في صفحه اللوكاشن
    return BlocConsumer<TripCubit, TripStates>(
    listener: (context, state) {

      if(state is TripGetAllUsersRaidersSuccessState)
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RidersListPage()));
        }
      if(state is TripGetAllUsersDriversSuccessState)
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const DriversListPage()));
        }
    },
    builder: (context, state) {
      var cubit= TripCubit.get(context);
      return DefaultTabController(
        initialIndex: cubit.initial_index_of_tap!,
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(150),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: AppBar(
                iconTheme: const IconThemeData(color: Color(0xFF442268)),
                centerTitle: true,
                title: const Text(
                  'Home',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF442268)),
                ),
                actions: <Widget>[
                  // cancel Icon
                  // IconButton(
                  //     icon: const Icon(
                  //       Icons.delete,
                  //       color: Color(0xFF442268),
                  //     ),
                  //     onPressed: () => showDialog(
                  //         context: context,
                  //         builder: (BuildContext context) => AlertDialog(
                  //               contentPadding: const EdgeInsets.all(20),
                  //               actionsPadding:
                  //                   const EdgeInsets.fromLTRB(0, 0, 65, 30),
                  //               shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(15)),
                  //               backgroundColor: const Color(0XFF2A1540),
                  //               contentTextStyle: const TextStyle(
                  //                   color: Colors.white, fontSize: 20),
                  //               title: const Text(
                  //                 'Cancel',
                  //                 style: TextStyle(
                  //                     color: Colors.white, fontSize: 20),
                  //               ),
                  //               content: const Text(
                  //                   'You will cancel the trip and go to home. Are you sure?'),
                  //               actions: [
                  //                 ElevatedButton(
                  //                   onPressed: () =>
                  //                       Navigator.pop(context, 'Yes'),
                  //                   style: ElevatedButton.styleFrom(
                  //                       primary: const Color(0XFFD4C9D6),
                  //                       padding: EdgeInsets.all(11),
                  //                       shape: RoundedRectangleBorder(
                  //                           borderRadius:
                  //                               BorderRadius.circular(15)),
                  //                       textStyle: const TextStyle(
                  //                         color: Color(0xFF442268),
                  //                       )),
                  //                   child: const Text('Yes',
                  //                       style: TextStyle(
                  //                         fontSize: 20,
                  //                         color: Color(0xFF442268),
                  //                       )),
                  //                 ),
                  //                 const SizedBox(
                  //                   width: 50,
                  //                 ),
                  //                 ElevatedButton(
                  //                   onPressed: () => Navigator.pop(context, 'No'),
                  //                   style: ElevatedButton.styleFrom(
                  //                       primary: const Color(0XFFD4C9D6),
                  //                       padding: EdgeInsets.all(11),
                  //                       shape: RoundedRectangleBorder(
                  //                           borderRadius:
                  //                               BorderRadius.circular(15)),
                  //                       textStyle: const TextStyle(
                  //                         color: Color(0xFF442268),
                  //                       )),
                  //                   child: const Text(
                  //                     'No',
                  //                     style: TextStyle(
                  //                       fontSize: 20,
                  //                       color: Color(0xFF442268),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             )))
                ],
                backgroundColor: const Color(0xFFFAFAFA),

                // tab bar
                flexibleSpace: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TabBar(
                      labelColor: const Color(0xFF442268),
                      labelStyle: const TextStyle(
                          fontSize: 27.5, fontWeight: FontWeight.w400),
                      unselectedLabelColor: Colors.grey,
                      indicatorWeight: 3,
                      indicatorColor: const Color(0xFF442268),
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorPadding: const EdgeInsets.all(0),
                      isScrollable: true,
                      physics: const BouncingScrollPhysics(),
                      onTap: (int index) {

                        if(index==2)
                          {
                            cubit.getUserTrips(user_id: cubit.userModel!.id);
                          }

                      },
                      enableFeedback: true,
                      // Uncomment the line below and remove DefaultTabController if you want to use a custom TabController
                      // controller: _tabController,
                      tabs: _tabs,
                    ),
                  ],
                ),
              ),
            ),
          ),
          drawer: Drawer(

            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color(0xFF442268),
                    ),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // IconButton(
                        //     onPressed: () {},
                        //     icon: const Icon(
                        //       Icons.account_circle_sharp,
                        //       color: Colors.white,
                        //       size: 80,
                        //     )),
                        CircleAvatar(
                          radius: 35,
                         //backgroundColor: Colors.black,

                          backgroundImage: NetworkImage("$ImagePath${LoginCubit.get(context).userModel?.personal_image}"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Padding(padding: EdgeInsets.all(25)),
                         Text(
                          "${LoginCubit.get(context).userModel?.email}",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      ],
                    )),
                ListTile(
                  leading: const Icon(
                    Icons.notifications,
                    color: Color(0xFF442268),
                  ),
                  title:
                      const Text('Notification', style: TextStyle(fontSize: 17)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationsPage()));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Color(0xFF442268),
                  ),
                  title:
                      const Text('Riders List', style: TextStyle(fontSize: 17)),
                  onTap: () {
                    cubit.getAllUsersRidersDrivers(user_type: 0);

                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.car_repair_sharp,
                    color: Color(0xFF442268),
                  ),
                  title:
                      const Text('Drivers List', style: TextStyle(fontSize: 17)),
                  onTap: () {
                    cubit.getAllUsersRidersDrivers(user_type: 1);

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const DriversListPage()));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Color(0xFF442268),
                  ),
                  title: const Text('Logout', style: TextStyle(fontSize: 17)),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  LoginPage()));
                  },
                ),
                // ListTile(
                //   leading: const Icon(
                //     Icons.info,
                //     color: Color(0xFF442268),
                //   ),
                //   title: const Text('About Us', style: TextStyle(fontSize: 17)),
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const AboutUsPage()));
                //   },
                // ),
              ],
            ),
          ),
          body: TabBarView(

            physics: const BouncingScrollPhysics(),
            // Uncomment the line below and remove DefaultTabController if you want to use a custom TabController
            // controller: _tabController,
            children: [
              BookTrip(),
              ShareCarTrip(),
               MyTrips()
            ],
          ),
        ),
      );
    },
);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
