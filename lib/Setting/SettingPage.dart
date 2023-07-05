import 'package:flutter/material.dart';

import '../AboutUS/AboutUS.dart';

import '../Notifications/NotificationsPage.dart';
import '../trip/presentation/screens/Drivers/RidersListPage.dart';
import '../trip/presentation/screens/Drivers/DriversListPage.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: PreferredSize(
      preferredSize: const Size.fromHeight(130),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0,30,0,0),
        child: AppBar(
          iconTheme: const IconThemeData(color: Color(0xFF442268)),
          centerTitle: true,
          title: const Text(
            'Setting',
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
                        style: TextStyle(
                            color: Colors.white, fontSize: 20),
                      ),
                      content: const Text(
                          'You will cancel the trip and go to home. Are you sure?'),
                      actions: [
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.pop(context, 'Yes'),
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
      ),);
  }
}
