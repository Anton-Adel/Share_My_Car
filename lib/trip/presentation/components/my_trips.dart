import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/trip_cubit.dart';
import '../controller/trip_state.dart';

class MyTrips extends StatelessWidget
{
    @override
    Widget build(BuildContext context) {
      return BlocConsumer<TripCubit, TripStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = TripCubit.get(context);
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        InkWell(
                          // onTap: (){
                          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                          // },
                          child: Card(
                            elevation: 10,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                              margin: const EdgeInsets.all(8),

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
                                        radius: 40,
                                        backgroundColor: Color(0xFF442268),
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'assets/eslam.jpeg'),
                                          radius: 43.5,
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,

                                          children: [
                                            Row(
                                              children:  [
                                                Text("Start location: ",
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w400),

                                                ),
                                                Expanded(child: Text(
                                                  "${cubit.user_trips_list[index].start_location}",
                                                  style: TextStyle(fontSize: 18,
                                                      fontWeight: FontWeight
                                                          .w400),
                                                maxLines: 2,
                                                  overflow:TextOverflow.ellipsis ,
                                                )),
                                              ],
                                            ),
                                            Row(
                                              children:  [
                                                Text("End location: ",
                                                  style: TextStyle(fontSize: 18,
                                                      fontWeight: FontWeight
                                                          .w400),),
                                                //SizedBox(width: 10,),
                                                Expanded(child: Text("${cubit.user_trips_list[index].end_location}",
                                                  style: TextStyle(fontSize: 18,
                                                      fontWeight: FontWeight
                                                          .w400),maxLines: 2,
                                                  overflow:TextOverflow.ellipsis ,)),
                                              ],
                                            ),
                                            Row(
                                              children:  [
                                                Text("Date: ", style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400),),
                                                Expanded(child: Text(
                                                  "${cubit.user_trips_list[index].start_date}",
                                                  style: TextStyle(fontSize: 18,
                                                      fontWeight: FontWeight
                                                          .w400),)),
                                              ],
                                            ),
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
                                  // ElevatedButton(
                                  //   child: const Text('Take car'),
                                  //   style: ElevatedButton.styleFrom(
                                  //     primary: Color(0xFF442268),
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 80, vertical: 15),
                                  //     textStyle: const TextStyle(
                                  //       fontSize: 20,
                                  //       fontWeight: FontWeight.bold,
                                  //     ),
                                  //   ),
                                  //   onPressed: () {
                                  //     // if (formKey.currentState!.validate()) {
                                  //     //   cubit.postBookTrip(
                                  //     //       start_address: cubit.startAddressController.text,
                                  //     //       end_address: cubit.endAddressController.text,
                                  //     //       start_time: cubit.startTimeController.text,
                                  //     //       start_date: cubit.startDateController.text);
                                  //     // }
                                  //   //  ShowToast("Take Car Confirmed", ToastState.TakeCar);
                                  //     // cubit.eslam();
                                  //   },
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
                    itemCount: cubit.user_trips_list.length)
              ],
            ),
          );
        },
      );
    }
  }
  
