import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/user/presentation/controller/Register/register_cubit.dart';
import 'package:gp/user/presentation/controller/Register/register_state.dart';
import 'package:gp/user/presentation/screens/Register/Properties.dart';
import 'package:gp/user/presentation/screens/Register/Verfication.dart';

import '../../../../core/shared_components/shared.dart';

class CarInfo extends StatelessWidget {
  CarInfo({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit=RegisterCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50.0,
                      ),

                      // car info
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),

                              child: const Divider(
                                color: Color(0xFF442268),
                                height: 0,
                                thickness: 3.5,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          const Text(
                            'Car Information',
                            style: TextStyle(
                                color: Color(0xFF442268),
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),

                              child: const Divider(
                                color: Color(0xFF442268),
                                height: 0,
                                thickness: 3.5,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 70.0,
                      ),

                      // car model & car color
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(

                              padding: const EdgeInsets.only(top: 20,right: 20,bottom: 20),
                              child: TextFormField(
                                controller: cubit.carmodel,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter car model';
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Car Model',
                                  labelStyle: TextStyle(
                                      color: Color(0xFF836D9A),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(

                              padding: const EdgeInsets.only(top: 20,left: 20,bottom: 20),

                              child: TextFormField(
                                controller: cubit.carcolor,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter car color';
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Car Color',
                                  labelStyle: TextStyle(
                                      color: Color(0xFF836D9A),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10.0,
                      ),

                      // car plate num
                      Container(
                        width: 370,
                        height: 55,
                        padding: const EdgeInsets.all(3),
                        child: TextFormField(
                          controller: cubit.carplatenumber,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter car plate number';
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Car Plate Number',
                            labelStyle: TextStyle(
                                color: Color(0xFF836D9A),
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 30.0,
                      ),

                      Container(
                        width: 370,
                        height: 55,
                        padding: const EdgeInsets.all(3),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: cubit.carseatnumber,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter car seat number';
                            }
                          },
                          decoration: const InputDecoration(

                            border: OutlineInputBorder(),
                            labelText: 'Car Seat Number',
                            labelStyle: TextStyle(
                                color: Color(0xFF836D9A),
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 30.0,
                      ),

                      // upload car image
                      Container(

                        padding: const EdgeInsets.all(3),
                        child: TextFormField(
                          controller: cubit.carimage,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter car image';
                            }
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Upload your car image',
                            labelStyle: const TextStyle(
                                color: Color(0xFF836D9A),
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                            suffixIcon: IconButton(
                              color: const Color(0xFF442268),
                              splashColor: const Color(0xFFCF283C),
                              iconSize: 30,
                              onPressed: () async {
                                cubit.CarImage = await get_image();
                                print(File(cubit.CarImage!.path).toString());
                                cubit.display_image_name((Uri.file(cubit.CarImage!.path).pathSegments.last).toString(),cubit.carimage);
                              },
                              icon: const Icon(Icons.add_photo_alternate),
                            ),
                          ),
                        ),
                      ),


                      const SizedBox(
                        height: 30.0,
                      ),


                      // upload car plate image
                      Container(

                        padding: const EdgeInsets.all(3),
                        child: TextFormField(
                          controller: cubit.carplateimage,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter car plate image';
                            }
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Upload your car plate image',
                            labelStyle: const TextStyle(
                                color: Color(0xFF836D9A),
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                            suffixIcon: IconButton(
                              color: const Color(0xFF442268),
                              splashColor: const Color(0xFFCF283C),
                              iconSize: 30,
                              onPressed: () async{
                                cubit.paletImage = await get_image();
                                print(File(cubit.paletImage!.path).toString());
                                cubit.display_image_name((Uri.file(cubit.paletImage!.path).pathSegments.last).toString(),cubit.carplateimage);
                              },
                              icon: const Icon(Icons.add_photo_alternate),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 30.0,
                      ),


                      // upload licence car image
                      Container(

                        padding: const EdgeInsets.all(3),
                        child: TextFormField(
                          controller: cubit.carlicenseimage,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter car license image';
                            }
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Upload your car license image',
                            labelStyle: const TextStyle(
                                color: Color(0xFF836D9A),
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                            suffixIcon: IconButton(
                              color: const Color(0xFF442268),
                              splashColor: const Color(0xFFCF283C),
                              iconSize: 30,
                              onPressed: () async{
                                cubit.licenseImage = await get_image();
                                print(File(cubit.licenseImage!.path).toString());
                                cubit.display_image_name((Uri.file(cubit.licenseImage!.path).pathSegments.last).toString(),cubit.carlicenseimage);
                              },
                              icon: const Icon(Icons.add_photo_alternate),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 50,
                      ),

                      // button next
                      ElevatedButton(
                        child: const Text('Next'),
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF442268),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 15),
                            textStyle: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.userPostModel?.car_model= cubit.carmodel.text;
                            cubit.userPostModel?.car_color= cubit.carcolor.text;
                            cubit.userPostModel?.car_plate_number= cubit.carplatenumber.text;
                            cubit.userPostModel?.car_image=cubit.CarImage;
                            cubit.userPostModel?.car_plate_image=cubit.paletImage;
                            cubit.userPostModel?.car_license_image=cubit.licenseImage;

                            print(cubit.userPostModel?.city);
                            // print(carcolor.text);
                            // print(carmodel.text);
                            // print(carplatenumber.text);
                            // print(cubit.carimage.text);
                            // print(cubit.carplateimage.text);
                            // print(cubit.carlicenseimage.text);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (
                                        context) =>  PropertiesPage()));
                          }
                        },
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}



