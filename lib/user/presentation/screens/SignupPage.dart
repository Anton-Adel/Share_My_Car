import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gp/core/global_models/user_post_model.dart';
import 'package:gp/core/shared_components/shared.dart';
import 'package:gp/user/presentation/controller/Register/register_cubit.dart';
import 'package:gp/user/presentation/controller/Register/register_state.dart';
import 'package:intl/intl.dart';
import 'package:gp/user/presentation/screens/CarInfo.dart';

import '../../../Drivers/Home.dart';
import 'Verfication.dart';

// const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController CountryController = TextEditingController();
  TextEditingController CityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController idController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  File? PersonalImage;
  File? CardImage;

  // have a car or not


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // text signup
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 30),
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.fromLTRB(
                                    0, 5, 0, 0),
                                width: 100,
                                child: const Divider(
                                  color: Color(0xFF442268),
                                  height: 0,
                                  thickness: 3.5,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            const Text(
                              "Sign up",
                              style: TextStyle(
                                  color: Color(0xFF442268),
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Expanded(
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 5, 0, 0),
                                  width: 100,
                                  child: const Divider(
                                    color: Color(0xFF442268),
                                    height: 0,
                                    thickness: 3.5,
                                  )),
                            ),
                          ],
                        ),
                      ),

                      // name edit text
                      Row(
                        children: [
                          Expanded(
                            child: Container(

                              height: 85,
                              padding: const EdgeInsets.all(20),
                              child: TextFormField(
                                controller: fnameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'first name must not be empty';
                                  }
                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'First name',
                                    labelStyle: TextStyle(
                                        color: Color(0xFF836D9A),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(

                              height: 85,
                              padding: const EdgeInsets.all(20),
                              child: TextFormField(
                                controller: lnameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'last name must not be empty';
                                  }
                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Last name',
                                    labelStyle: TextStyle(
                                        color: Color(0xFF836D9A),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20)),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // gender
                      Container(

                        height: 46,
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              "Gender",
                              style: TextStyle(
                                  color: Color(0xFF836D9A),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Row(
                              children: [
                                Theme(
                                  data: ThemeData(
                                    primarySwatch: Colors.deepPurple,
                                    unselectedWidgetColor:
                                    const Color(0xFF442268), // Your color
                                  ),
                                  child: Radio(
                                      value: "male",

                                      groupValue: cubit.gender,
                                      onChanged: (String? value) {
                                        cubit.change_gender(value);
                                        // cubit.gender = value!;

                                      }),
                                ),
                                const Text(
                                  'M',
                                  style: TextStyle(
                                      color: Color(0xFF836D9A),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Row(
                              children: [
                                Theme(
                                  data: ThemeData(
                                    primarySwatch: Colors.deepPurple,
                                    unselectedWidgetColor:
                                    const Color(0xFF442268), // Your color
                                  ),
                                  child: Radio(
                                      value: "female",
                                      groupValue: cubit.gender,
                                      onChanged: (String? value) {
                                        cubit.change_gender(value);
                                      }),
                                ),
                                const Text(
                                  'F',
                                  style: TextStyle(
                                      color: Color(0xFF836D9A),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // birthdate (DatePicker)
                      Container(

                        height: 85,
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: ageController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Age must not be empty';
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Age',
                            labelStyle: TextStyle(
                                color: Color(0xFF836D9A),
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                            // suffixIcon: Icon(
                            //   Icons.calendar_today,
                            //   color: Color(0xFF442268),
                            //   size: 30,
                            // )
                          ),
                          //readOnly: true,
                          //set it true, so that user will not able to edit text

                          // datePicker
                          // onTap: () async {
                          //   DateTime? pickedDate = await showDatePicker(
                          //       context: context,
                          //       initialDate: DateTime.now(),
                          //       firstDate: DateTime(1950),
                          //       //DateTime.now() - not to allow to choose before today.
                          //       lastDate: DateTime.now());
                          //   if (pickedDate != null) {
                          //
                          //     print(
                          //         pickedDate); //pickedDate output format => 2021-03-10
                          //     String formattedDate =
                          //     DateFormat('yyyy-MM-dd').format(pickedDate);
                          //     print(
                          //         formattedDate);
                          //     print(DateTime.now()-pickedDate);//formatted date output using intl package =>  2021-03-16
                          //     // setState(() {
                          //     //   dateInput.text =
                          //     //       formattedDate; //set output date to TextFormField value.
                          //     // });
                          //     cubit.get_date(formattedDate);
                          //   } else {}
                          // },
                        ),
                      ),

                      // id num
                      Container(

                        height: 85,
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: idController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'id number for car must not be empty';
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'ID number',
                              labelStyle: TextStyle(
                                  color: Color(0xFF836D9A),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20)),
                        ),
                      ),

                      // 2 edit text to upload personal_image & id_card_image
                      Container(


                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          controller: cubit.personalImage,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'personalImage must not be empty';
                            }
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Upload your personal image',
                            labelStyle: const TextStyle(
                                color: Color(0xFF836D9A),
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                            suffixIcon: IconButton(
                              color: const Color(0xFF442268),
                              // hoverColor: const Color(0xFFCF283C),
                              iconSize: 30,
                              onPressed: () async {
                                PersonalImage = await get_image();
                                print(File(PersonalImage!.path).toString());
                                cubit.display_image_name((Uri
                                    .file(PersonalImage!.path)
                                    .pathSegments
                                    .last).toString(), cubit.personalImage);
                              },
                              icon: const Icon(Icons.add_photo_alternate),
                            ),
                          ),
                        ),
                      ),
                      Container(


                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          controller: cubit.idCardImage,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'card image must not be empty';
                            }
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Upload your ID card image',
                            labelStyle: const TextStyle(
                                color: Color(0xFF836D9A),
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                            suffixIcon: IconButton(
                              color: const Color(0xFF442268),
                              // hoverColor: const Color(0xFFCF283C),
                              iconSize: 30,
                              onPressed: () async {
                                CardImage = await get_image();
                                cubit.display_image_name((Uri
                                    .file(CardImage!.path)
                                    .pathSegments
                                    .last).toString(), cubit.idCardImage);
                              },
                              icon: const Icon(Icons.add_photo_alternate),
                            ),
                          ),
                        ),
                      ),

                      // contact info
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 30),
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.fromLTRB(
                                    0, 5, 0, 0),
                                width: 65,
                                child: const Divider(
                                  color: Color(0xFF442268),
                                  height: 0,
                                  thickness: 3.5,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Text(
                              "Contact information",
                              style: TextStyle(
                                  color: Color(0xFF442268),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.fromLTRB(
                                    0, 5, 0, 0),
                                width: 65,
                                child: const Divider(
                                  color: Color(0xFF442268),
                                  height: 0,
                                  thickness: 3.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // email
                      Container(
                        width: 400,
                        height: 85,
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email must not be empty';
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              // errorText: 'it is required',
                              labelStyle: TextStyle(
                                  color: Color(0xFF836D9A),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20)),
                        ),
                      ),
                      Container(
                        width: 400,
                        height: 85,
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password must not be empty';
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              // errorText: 'it is required',
                              labelStyle: TextStyle(
                                  color: Color(0xFF836D9A),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20)),
                        ),
                      ),

                      // country & city
                      Container(
                        width: 400,
                        height: 85,
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          controller: CountryController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Country must not be empty';
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Country',
                              // errorText: 'it is required',
                              labelStyle: TextStyle(
                                  color: Color(0xFF836D9A),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20)),
                        ),
                      ),
                      Container(
                        width: 400,
                        height: 85,
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          controller: CityController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'City must not be empty';
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'City',
                              // errorText: 'it is required',
                              labelStyle: TextStyle(
                                  color: Color(0xFF836D9A),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20)),
                        ),
                      ),

                      // address
                      const Padding(padding: EdgeInsets.all(10)),
                      Container(
                        width: 400,
                        height: 85,
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          controller: addressController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'address must not be empty';
                            }
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Address',
                            labelStyle: const TextStyle(
                                color: Color(0xFF836D9A),
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                            suffixIcon: IconButton(
                              color: const Color(0xFF442268),
                              // hoverColor: const Color(0xFFCF283C),
                              iconSize: 30,
                              onPressed: () {
                                print('hello');
                              },
                              icon: const Icon(Icons.add_location_alt),
                            ),
                          ),
                        ),
                      ),

                      // phone number
                      Container(
                        width: 400,
                        height: 85,
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: phoneController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'phone number must not be empty';
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone number',
                            labelStyle: TextStyle(
                                color: Color(0xFF836D9A),
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                          ),
                        ),
                      ),

                      // divider
                      Center(
                        child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            width: 300,
                            child: const Divider(
                              color: Color(0xFF442268),
                              height: 0,
                              thickness: 3.5,
                            )),
                      ),

                      // check user have a car or not
                      const Padding(padding: EdgeInsets.all(12)),
                      Container(
                        width: 365,
                        height: 150,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0DEF3),
                          border:
                          Border.all(
                              color: const Color(0xFF442268), width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(children: [
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text(
                                "Have a car ?",
                                style:
                                TextStyle(
                                    color: Color(0xFF442268), fontSize: 25),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.all(8)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        10, 40, 0, 0),
                                  ),
                                  const Text(
                                    "Yes",
                                    style: TextStyle(
                                        color: Color(0xFF442268),
                                        fontSize: 25),
                                  ),
                                  Theme(
                                    data: ThemeData(
                                      primarySwatch: Colors.deepPurple,
                                      unselectedWidgetColor:
                                      const Color(0xFF442268), // Your color
                                    ),
                                    child: Checkbox(
                                        value: cubit.have_car,
                                        onChanged: ((value) {
                                          cubit.check_have_car(true);
                                        })),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        10, 20, 0, 0),
                                  ),
                                  const Text(
                                    "No",
                                    style: TextStyle(
                                        color: Color(0xFF442268),
                                        fontSize: 25),
                                  ),
                                  Theme(
                                    data: ThemeData(
                                      primarySwatch: Colors.deepPurple,
                                      unselectedWidgetColor:
                                      const Color(0xFF442268), // Your color
                                    ),
                                    child: Checkbox(
                                        value: cubit.dont_have_car,
                                        onChanged: ((value) {
                                          cubit.check_have_car(false);
                                        })),
                                  ),
                                ],
                              )
                            ],
                          )
                        ]),
                      ),

                      // button Next
                      const Padding(padding: EdgeInsets.all(10)),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF3C1858),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 15),
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                backgroundColor: Color(0xFF3C1858)),
                          ),

                          onPressed: () {
                            if (formKey.currentState!.validate() &&
                                (cubit.check_car) &&
                                cubit.gender != null) {
                              String user_age="0";
                             var age=int.parse(ageController.text);
                              if(age>=16&& age<25)
                                {
                                  user_age="Young";
                                }
                              else if(age>=25&& age<50)
                                {
                                  user_age='Middle';
                                }
                              else
                                user_age="Old";
                              cubit.userPostModel = UserPostModel(
                                  first_name: fnameController.text,
                                  last_name: lnameController.text,
                                  gender: cubit.gender! ,
                                  age: user_age,
                                  id_number: idController.text,
                                  email: emailController.text,
                                  country: CountryController.text,
                                  city: CityController.text,
                                  address: addressController.text ,
                                  password: passwordController.text,
                                  phone_number: phoneController.text,
                                  have_car: cubit.have_car? "1":"0",

                              personal_image: PersonalImage,
                                card_image: CardImage,
                              );
                              print(cubit.userPostModel?.city);
                              if (cubit.have_car == true) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CarInfo()));
                              } else {
                                ShowToast("please Check your gmail",
                                    ToastState.Success);
                                // not have a car
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (
                                            context) =>  verfication()));
                              }
                            } else {
                              print("please enter gender");
                              ShowToast(
                                  "please check gender field & have car question",
                                  ToastState.Error);
                            }
                          },
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(20)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}




