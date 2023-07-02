import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../AboutUS/AboutUS.dart';

import '../Notifications/NotificationsPage.dart';
import '../Riders/RidersListPage.dart';
import '../Setting/SettingPage.dart';
import '../trip/presentation/screens/Drivers/DriversListPage.dart';
import '../trip/presentation/screens/Drivers/ProfilePage.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with
        AutomaticKeepAliveClientMixin<NotificationsPage>,
        TickerProviderStateMixin {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: AppBar(
            iconTheme: const IconThemeData(color: Color(0xFF442268)),
            centerTitle: true,
            title: const Text(
              'Notification',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF442268)),
            ),
            actions: <Widget>[
              // cancel Icon
              IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Color(0xFF442268),
                  ),
                  onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        contentPadding: const EdgeInsets.all(20),
                        actionsPadding:
                        const EdgeInsets.fromLTRB(0, 0, 65, 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: const Color(0XFF2A1540),
                        contentTextStyle: const TextStyle(
                            color: Colors.white, fontSize: 20),
                        title: const Text(
                          'Cancel',
                          style:
                          TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        content: const Text(
                            'You will cancel the trip and go to home. Are you sure?'),
                        actions: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, 'Yes'),
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0XFFD4C9D6),
                                padding: EdgeInsets.all(11),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(15)),
                                textStyle: const TextStyle(
                                  color: Color(0xFF442268),
                                )),
                            child: const Text('Yes',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF442268),
                                )),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, 'No'),
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0XFFD4C9D6),
                                padding: EdgeInsets.all(11),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(15)),
                                textStyle: const TextStyle(
                                  color: Color(0xFF442268),
                                )),
                            child: const Text(
                              'No',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF442268),
                              ),
                            ),
                          ),
                        ],
                      )))
            ],
            backgroundColor: const Color(0xFFFAFAFA),

            // tab bar
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
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.account_circle_sharp,
                          color: Colors.white,
                          size: 80,
                        )),
                    const SizedBox(
                      height: 50,
                    ),
                    // Padding(padding: EdgeInsets.all(25)),
                    const Text(
                      "Username@gmail.com",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )
                  ],
                )),
            ListTile(
              leading: const Icon(
                Icons.notifications,
                color: Color(0xFF442268),
              ),
              title: const Text('Notification', style: TextStyle(fontSize: 17)),
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
              title: const Text('Riders List', style: TextStyle(fontSize: 17)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RidersListPage()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.car_repair_sharp,
                color: Color(0xFF442268),
              ),
              title: const Text('Drivers List', style: TextStyle(fontSize: 17)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DriversListPage()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Color(0xFF442268),
              ),
              title: const Text('Setting', style: TextStyle(fontSize: 17)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingPage()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.info,
                color: Color(0xFF442268),
              ),
              title: const Text('About Us', style: TextStyle(fontSize: 17)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AboutUsPage()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(7)),
            InkWell(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                margin: const EdgeInsets.all(20),
                height: 180,
                width: 400,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                  border: Border.all(color: Colors.black12, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 45,
                          backgroundColor: Color(0xFF442268),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/eslam.jpeg'),
                            radius: 43.5,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "Eslam Khaled Eid wants to come\nwith you",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              children: const [
                                Text(
                                  "Distance:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "1Km",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Text(
                                  "Time:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "10min",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    // const SizedBox(height: 20),
                    // implement the rating bar

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Padding(padding: EdgeInsets.all(30)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF3C1858),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                          ),
                          child: const Text(
                            'Accept',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                backgroundColor: Color(0xFF3C1858)),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const NotificationsPage()));
                          },
                        ),
                        const Padding(padding: EdgeInsets.all(5)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF3C1858),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                          ),
                          child: const Text(
                            'Refuse',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                backgroundColor: Color(0xFF3C1858)),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const NotificationsPage()));
                          },
                        ),
                      ],
                    ),


                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()));
              },
            ),
            InkWell(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                margin: const EdgeInsets.all(20),
                height: 180,
                width: 400,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                  border: Border.all(color: Colors.black12, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 45,
                          backgroundColor: Color(0xFF442268),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/sh.jpg'),
                            radius: 43.5,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15,),
                            Row(
                              children: const [
                                Text(
                                  "Eslam Khaled Eid is here",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              children: const [
                                Text(
                                  "Car:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "Grey | Peugeot 3008",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              children: const [
                                Text(
                                  "Distance:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "1Km",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Text(
                                  "Time:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "10min",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()));
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
