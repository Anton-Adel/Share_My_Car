import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gp/AboutUS/AboutUS.dart';


import 'package:gp/trip/presentation/screens/Drivers/RidersListPage.dart';
import 'package:gp/Setting/SettingPage.dart';

import '../../../../Notifications/NotificationsPage.dart';
import 'DriversListPage.dart';
import 'ProfilePage.dart';



class DriversPage extends StatefulWidget {
  const DriversPage({Key? key}) : super(key: key);

  @override
  State<DriversPage> createState() => _DriversPageState();
}

class _DriversPageState extends State<DriversPage>
    with AutomaticKeepAliveClientMixin<DriversPage>, TickerProviderStateMixin {
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
    return Text("");
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
