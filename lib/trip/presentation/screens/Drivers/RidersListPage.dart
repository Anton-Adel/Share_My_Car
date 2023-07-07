import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gp/trip/presentation/controller/trip_cubit.dart';
import 'package:gp/trip/presentation/controller/trip_state.dart';


import '../../../../AboutUS/AboutUS.dart';

import '../../../../Notifications/NotificationsPage.dart';
import '../../../../Setting/SettingPage.dart';
import '../../../../core/shared_components/Constants.dart';
import 'DriversListPage.dart';
import 'ProfilePage.dart';

class RidersListPage extends StatelessWidget {
  const RidersListPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return BlocConsumer<TripCubit, TripStates>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit =TripCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: AppBar(
            iconTheme: const IconThemeData(color: Color(0xFF442268)),
            centerTitle: true,
            title: const Text(
              'Riders List',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF442268)),
            ),

            backgroundColor: const Color(0xFFFAFAFA),
          ),
        ),
      ),
     
      body: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              InkWell(
                onTap: () {
                  print(cubit.userList[index].personal_image);
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                    margin: const EdgeInsets.all(8),

                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F1F1),
                      border: Border.all(
                          color: Colors.black12, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              //backgroundColor: Color(0xFF442268),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                  '$ImagePath${cubit.raidersList[index]
                                      .personal_image}',

                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,

                                children: [
                                  Row(
                                    children: [
                                      Text("Name: ", style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight
                                              .w400),),
                                      Expanded(child: Text(
                                        "${cubit.raidersList[index]
                                            .first_name} ${cubit
                                            .raidersList[index]
                                            .last_name}",
                                        style: TextStyle(fontSize: 18,
                                            fontWeight: FontWeight
                                                .w400),)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Phone number: ",
                                        style: TextStyle(fontSize: 18,
                                            fontWeight: FontWeight
                                                .w400),),
                                      //SizedBox(width: 10,),
                                      Expanded(child: Text(
                                        "${cubit.raidersList[index]
                                            .phone_number}",
                                        style: TextStyle(fontSize: 18,
                                            fontWeight: FontWeight
                                                .w400),)),
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Text("Car:", style: TextStyle(
                                  //         fontSize: 20,
                                  //         fontWeight: FontWeight
                                  //             .w400),),
                                  //     Expanded(child: Text(
                                  //       "${cubit.raidersList[index]
                                  //           .car_model} | ${cubit
                                  //           .raidersList[index]
                                  //           .car_plate_number}",
                                  //       style: TextStyle(fontSize: 18,
                                  //           fontWeight: FontWeight
                                  //               .w400),)),
                                  //   ],
                                  // ),
                                  // Row(
                                  //   children: const [
                                  //     Text("Distance:", style: TextStyle(
                                  //         fontSize: 18,
                                  //         fontWeight: FontWeight.w400),),
                                  //     Text("1Km", style: TextStyle(
                                  //         fontSize: 18,
                                  //         fontWeight: FontWeight.w400),),
                                  //     SizedBox(
                                  //       width: 15,
                                  //     ),
                                  //     Text("Time:", style: TextStyle(
                                  //         fontSize: 18,
                                  //         fontWeight: FontWeight.w400),),
                                  //     Expanded(child: Text("10min",
                                  //       style: TextStyle(fontSize: 18,
                                  //           fontWeight: FontWeight
                                  //               .w400),)),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        // implement the rating bar
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        //   child: RatingBar(
                        //       initialRating: 0,
                        //       direction: Axis.horizontal,
                        //       allowHalfRating: true,
                        //       itemCount: 5,
                        //       itemSize: 30,
                        //       ratingWidget: RatingWidget(
                        //           full: const Icon(Icons.star,
                        //               color: Colors.orange),
                        //           half: const Icon(
                        //             Icons.star_half,
                        //             color: Colors.orange,
                        //           ),
                        //           empty: const Icon(
                        //             Icons.star_outline,
                        //             color: Colors.orange,
                        //           )),
                        //       onRatingUpdate: (value) {
                        //         // setState(() {
                        //         //   _ratingValue = value;
                        //         // });
                        //       }),
                        // ),

                        const SizedBox(height: 15),

                      ],
                    ),
                  ),
                ),
              ),
          separatorBuilder: (context, index) =>
              SizedBox(
                height: 10,
              ),
          itemCount: cubit.raidersList.length)
    );
  },
);
  }
}
