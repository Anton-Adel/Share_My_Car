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
class ShareCarTrip extends StatelessWidget {
  ShareCarTrip({Key? key}) : super(key: key);

  // TextEditingController startAddressController = TextEditingController();
  // TextEditingController endAddressController = TextEditingController();
  // TextEditingController startTimeController = TextEditingController();
  // TextEditingController startDateController = TextEditingController();
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
    return BlocConsumer<TripCubit, TripStates>
      (
      listener: (context, state) {

        if(state is TripBookTripSuccessState)
          {
            ShowToast("Your car is shared now", ToastState.Success);
          }
      },
      builder: (context, state) {
        var cubit = TripCubit.get(context);
        return cubit.userModel!.have_car==1? SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
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
                      TextFormField( //متنساش تجيب اللي في الكيوبت
                        controller: cubit.startAddressShareCarController,
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
                              cubit.ToLocation(1);
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
                        controller: cubit.endAddressShareCarController,
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
                              cubit.ToLocation(1);
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
                        controller: cubit.startDateShareCarController,
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
                              lastDate: DateTime.now().add(Duration(days: 30)));
                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10
                            String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(formattedDate);
                            // setState(() {
                            //   startDateController.text = formattedDate;
                            // });
                            // print(DateTime.now()-pickedDate);//formatted date output using intl package =>  2021-03-16
                            // setState(() {
                            //   dateInput.text =
                            //       formattedDate; //set output date to TextFormField value.
                            // });
                            cubit.display_date_time(formattedDate,cubit.startDateShareCarController);

                          }
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: cubit.startTimeShareCarController,
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
                            print(
                                pickedTime); //pickedDate output format => 2021-03-10
                            String formattedTime = pickedTime.format(context);

                            print(formattedTime);
                            // setState(() {
                            //   startTimeController.text = formattedTime;
                            // });
                            // print(DateTime.now()-pickedDate);//formatted date output using intl package =>  2021-03-16
                            // setState(() {
                            //   dateInput.text =
                            //       formattedDate; //set output date to TextFormField value.
                            // });
                             cubit.display_date_time(formattedTime,cubit.startTimeShareCarController);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: InkWell(

                                onTap: (){
                                  cubit.set_seats(1, cubit.c1);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  height: 40,

                                  child: Center(child: Text("1", style: TextStyle(
                                      color: Colors.black, fontSize: 35),)),
                                  decoration: BoxDecoration(
                                    color: cubit.c1,
                                      border: Border.all(
                                          color: Color(0xFF442268), width: 2),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: InkWell(
                                onTap: (){
                                  cubit.set_seats(2, cubit.c2);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  height: 40,

                                  child: Center(child: Text("2", style: TextStyle(
                                      color: Colors.black, fontSize: 35),)),
                                  decoration: BoxDecoration(
                                      color: cubit.c2,
                                      border: Border.all(
                                          color: Color(0xFF442268), width: 2),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: InkWell(
                                onTap: (){
                                  cubit.set_seats(3, cubit.c3);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  height: 40,

                                  child: Center(child: Text("3", style: TextStyle(
                                      color: Colors.black, fontSize: 35),)),
                                  decoration: BoxDecoration(
                                      color: cubit.c3,
                                      border: Border.all(
                                          color: Color(0xFF442268), width: 2),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: InkWell(
                                onTap: (){
                                  cubit.set_seats(4, cubit.c4);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  height: 40,

                                  child: Center(child: Text("4", style: TextStyle(
                                      color: Colors.black, fontSize: 35),)),
                                  decoration: BoxDecoration(
                                      color: cubit.c4,
                                      border: Border.all(
                                          color: Color(0xFF442268), width: 2),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
                            cubit.postBookTrip(start_address: cubit
                                .startAddressShareCarController.text,
                                end_address: cubit.endAddressShareCarController.text,
                                start_time: cubit.startTimeShareCarController.text,
                                start_date: cubit.startDateShareCarController.text,
                            from_book_trip: 2
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

            ],
          ),
        ):

            Center(child: Text("You don’t have a car to share",style: TextStyle
              ( fontSize: 25,color: Colors.grey,fontWeight: FontWeight.bold),));
        ;
      },
    );
  }
}


