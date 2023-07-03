import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gp/core/shared_components/shared.dart';
import 'package:gp/trip/presentation/controller/trip_cubit.dart';
import 'package:gp/trip/presentation/controller/trip_state.dart';
import 'package:intl/intl.dart';

import '../../../map/location.dart';
import '../screens/Drivers/Home.dart';

// for rebuild
class BookTrip extends StatelessWidget {
  BookTrip({Key? key}) : super(key: key);

  // TextEditingController startAddressController = TextEditingController();
  // TextEditingController endAddressController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    final placemark = placemarks.first;
    // setState(() {
    //   startAddressController.text = placemark.thoroughfare ?? '';
    //   if (placemark.subThoroughfare != null) {
    //     startAddressController.text += ', ' + placemark.subThoroughfare!;
    //   }
    //   startAddressController.text +=
    //   ', ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
    // });
  }

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
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: cubit.startAddressController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter start location";
                          } else
                            return null;
                        },
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LocationPage(backPage: HomePage(),)));
                            },
                            icon: const Icon(Icons.location_on),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: cubit.endAddressController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter end location";
                          } else
                            return null;
                        },
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
                                      builder: (context) =>
                                          LocationPage(backPage: HomePage(),)));

                              print('hello');
                            },
                            icon: const Icon(Icons.location_on),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: cubit.startDateController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Start date must not be empty';
                          }
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Trip date',
                            labelStyle: TextStyle(
                                color: Color(0xFF836D9A),
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                            suffixIcon: Icon(
                              Icons.calendar_today,
                              color: Color(0xFF442268),
                              size: 30,
                            )),
                        readOnly: true,
                        //set it true, so that user will not able to edit text

                        //datePicker
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime.now());
                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10
                            String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(formattedDate);
                            // setState(() {
                            //   startDateController.text = formattedDate;
                            // });

                            cubit.display_date_time(
                                formattedDate, cubit.startDateController);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: cubit.startTimeController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Start time must not be empty';
                          }
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Trip time',
                            labelStyle: TextStyle(
                                color: Color(0xFF836D9A),
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                            suffixIcon: Icon(
                              Icons.watch_later_outlined,
                              color: Color(0xFF442268),
                              size: 30,
                            )),
                        readOnly: true,
                        //set it true, so that user will not able to edit text

                        //datePicker
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (pickedTime != null) {
                            print(pickedTime); 
                            String formattedTime = pickedTime.format(context);

                            print(formattedTime);
                            // setState(() {
                            //   startTimeController.text = formattedTime;
                            // });

                            cubit.display_date_time(formattedTime, cubit.startTimeController);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        child: const Text('Next'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF442268),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.postBookTrip(
                                start_address: cubit.startAddressController.text,
                                end_address: cubit.endAddressController.text,
                                start_time: cubit.startTimeController.text,
                                start_date: cubit.startDateController.text);
                          }
                          ShowToast("Search for appropriate drivers", ToastState.Success);
                          // cubit.eslam();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      Card(
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
                                          'assets/Anton.jpeg'),
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
                                          children: const [
                                            Text("Name:", style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w400),),
                                            Expanded(child: Text(
                                              "Eslam Khaled Eid",
                                              style: TextStyle(fontSize: 18,
                                                  fontWeight: FontWeight
                                                      .w400),)),
                                          ],
                                        ),
                                        Row(
                                          children: const [
                                            Text("Phone number:",
                                              style: TextStyle(fontSize: 18,
                                                  fontWeight: FontWeight
                                                      .w400),),
                                            //SizedBox(width: 10,),
                                            Expanded(child: Text("01064643135",
                                              style: TextStyle(fontSize: 18,
                                                  fontWeight: FontWeight
                                                      .w400),)),
                                          ],
                                        ),
                                        Row(
                                          children: const [
                                            Text("Car:", style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),),
                                            Expanded(child: Text(
                                              "Grey | Peugeot 3008",
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
                            ],
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) =>
                      SizedBox(
                        height: 10,
                      ),
                  itemCount: 1)
            ],
          ),
        );
      },
    );
  }
}


