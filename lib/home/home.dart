import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gp/map/location.dart';
import '../Notifications/NotificationsPage.dart';
import '../Setting/SettingPage.dart';

import '../AboutUS/AboutUS.dart';
import '../Riders/RidersListPage.dart';
import '../trip/presentation/screens/Drivers/DriversListPage.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
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
                        IconButton(onPressed: (){}, icon: const Icon(Icons.account_circle_sharp,color: Colors.white,size: 80,)),
                        const SizedBox(height: 50,),
                        // Padding(padding: EdgeInsets.all(25)),
                        const Text("Username@gmail.com",style: TextStyle(fontSize: 20,color: Colors.white),)
                      ],
                    )
                ),
                ListTile(
                  leading: const Icon(
                    Icons.notifications,
                    color: Color(0xFF442268),
                  ),
                  title: const Text('Notification',style: TextStyle(fontSize: 17)),
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
                  title: const Text('Riders List',style: TextStyle(fontSize: 17)),
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
                  title: const Text('Drivers List',style: TextStyle(fontSize: 17)),
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
                  title: const Text('Setting',style: TextStyle(fontSize: 17)),
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
                  title: const Text('About Us',style: TextStyle(fontSize: 17)),
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
        appBar: AppBar(
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Color(0xFF442268),
              ),
            );
          }),
          title: const Text(
            'HOME',
            style: TextStyle(
              color: Color(0xFF442268),
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
          ),
          actions: [
            const Icon(
              Icons.arrow_forward_sharp,
              color: Color(0xFF442268),
            ),
          ],
          backgroundColor: Colors.white,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                child: Text(
                  'Book Trip',
                  style: TextStyle(
                    color: Color(0xFF442268),
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Share Car',
                  style: TextStyle(
                    color: Color(0xFF442268),
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'My Trips',
                  style: TextStyle(
                    color: Color(0xFF442268),
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController startAddressController = TextEditingController();
  TextEditingController endAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    final placemark = placemarks.first;
    setState(() {
      startAddressController.text = placemark.thoroughfare ?? '';
      if (placemark.subThoroughfare != null) {
        startAddressController.text += ', ' + placemark.subThoroughfare!;
      }
      startAddressController.text +=
      ', ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextField(
            controller: startAddressController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your start address',
              labelStyle: TextStyle(
                color: Color(0xFF836D9A),
                fontWeight: FontWeight.w300,
                fontSize: 20,
              ),
              suffixIcon: IconButton(
                color: Colors.red,
                splashColor: const Color(0xFFCF283C),
                iconSize: 30,
                onPressed: () {
                  _getCurrentLocation();
                },
                icon: const Icon(Icons.location_on),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextField(
            controller: endAddressController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your end address',
              labelStyle: TextStyle(
                color: Color(0xFF836D9A),
                fontWeight: FontWeight.w300,
                fontSize: 20,
              ),
              suffixIcon: IconButton(
                color: const Color(0xFF442268),
                splashColor: const Color(0xFFCF283C),
                iconSize: 30,
                onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) =>  LocationPage (backPage: Home(),)));

    print('hello');
    }
                ,
                icon: const Icon(Icons.location_on),
              ),
            ),
          ),
          const SizedBox(
            height: 80.0,
          ),
          ElevatedButton(
            child: const Text('Next'),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF442268),
              padding:
              const EdgeInsets.symmetric(horizontal: 100,vertical: 15),
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}