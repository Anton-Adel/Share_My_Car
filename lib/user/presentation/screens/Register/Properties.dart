import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/core/shared_components/shared.dart';
import 'package:gp/user/data/data_source/user_remote_data_source.dart';
import 'package:gp/user/presentation/controller/Register/register_cubit.dart';
import 'package:gp/user/presentation/controller/Register/register_state.dart';

import 'Verfication.dart';


class PropertiesPage extends StatelessWidget {
  PropertiesPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if(state is RegisterSendCodeSuccessState)
          {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) =>
                        verfication()));
          }
      },
      builder: (context, state) {
        var cubit=RegisterCubit.get(context);
        return Scaffold(
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // text signup
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                width: 100,
                                child: const Divider(
                                  color: Color(0xFF442268),
                                  height: 0,
                                  thickness: 3.5,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            const Text(
                              "Properties",
                              style: TextStyle(
                                  color: Color(0xFF442268),
                                  fontSize: 33,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 30,
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
                      Column(
                        children: [
                          Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  "Gender you want to share your trip with",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF442268),
                                      fontWeight: FontWeight.w300),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
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
                                        groupValue: cubit.Q1,
                                        onChanged: (String? value) {

                                            cubit.get_question_value(value, 1);

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
                                        groupValue: cubit.Q1,
                                        onChanged: (String? value) {
                                          cubit.get_question_value(value, 1);
                                          print(value);

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
                              Row(
                                children: [
                                  Theme(
                                    data: ThemeData(
                                      primarySwatch: Colors.deepPurple,
                                      unselectedWidgetColor:
                                      const Color(0xFF442268), // Your color
                                    ),
                                    child: Radio(
                                        value: "Both",
                                        groupValue: cubit.Q1,
                                        onChanged: (String? value) {
                                          cubit.get_question_value(value, 1);
                                        }),
                                  ),
                                  const Text(
                                    'Both',
                                    style: TextStyle(
                                        color: Color(0xFF836D9A),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: const [
                              Text(
                                "Are you smoker",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF442268),
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 50,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                        primarySwatch: Colors.deepPurple,
                                        unselectedWidgetColor:
                                        const Color(0xFF442268), // Your color
                                      ),
                                      child: Radio(
                                          value: "yes",
                                          groupValue: cubit.Q2,
                                          onChanged: (String? value) {
                                            cubit.get_question_value(value, 2);
                                          }),
                                    ),
                                    const Text(
                                      'Yes',
                                      style: TextStyle(
                                          color: Color(0xFF836D9A),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Expanded(
                                child: Row(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                        primarySwatch: Colors.deepPurple,
                                        unselectedWidgetColor:
                                        const Color(0xFF442268), // Your color
                                      ),
                                      child: Radio(
                                          value: "no",
                                          groupValue: cubit.Q2,
                                          onChanged: (String? value) {
                                            cubit.get_question_value(value, 2);
                                          }),
                                    ),
                                    const Text(
                                      'No',
                                      style: TextStyle(
                                          color: Color(0xFF836D9A),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: const [
                              Text(
                                "Sharing car with smoker",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF442268),
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 50,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                        primarySwatch: Colors.deepPurple,
                                        unselectedWidgetColor:
                                        const Color(0xFF442268), // Your color
                                      ),
                                      child: Radio(
                                          value: "yes",
                                          groupValue: cubit.Q3,
                                          onChanged: (String? value) {
                                            cubit.get_question_value(value, 3);
                                          }),
                                    ),
                                    const Text(
                                      'Yes',
                                      style: TextStyle(
                                          color: Color(0xFF836D9A),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Expanded(
                                child: Row(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                        primarySwatch: Colors.deepPurple,
                                        unselectedWidgetColor:
                                        const Color(0xFF442268), // Your color
                                      ),
                                      child: Radio(
                                          value: "no",
                                          groupValue: cubit.Q3,
                                          onChanged: (String? value) {
                                            cubit.get_question_value(value, 3);
                                          }),
                                    ),
                                    const Text(
                                      'No',
                                      style: TextStyle(
                                          color: Color(0xFF836D9A),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: const [
                              Text(
                                "Turning on music or radio",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF442268),
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 50,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                        primarySwatch: Colors.deepPurple,
                                        unselectedWidgetColor:
                                        const Color(0xFF442268), // Your color
                                      ),
                                      child: Radio(
                                          value: "yes",
                                          groupValue: cubit.Q4,
                                          onChanged: (String? value) {
                                            cubit.get_question_value(value,4);
                                          }),
                                    ),
                                    const Text(
                                      'Yes',
                                      style: TextStyle(
                                          color: Color(0xFF836D9A),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ), 
                              
                              Spacer(),
                              Expanded(
                                child: Row(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                        primarySwatch: Colors.deepPurple,
                                        unselectedWidgetColor:
                                        const Color(0xFF442268), // Your color
                                      ),
                                      child: Radio(
                                          value: "no",
                                          groupValue: cubit.Q4,
                                          onChanged: (String? value) {
                                            cubit.get_question_value(value,4);
                                          }),
                                    ),
                                    const Text(
                                      'No',
                                      style: TextStyle(
                                          color: Color(0xFF836D9A),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: const [
                              Text(
                                "Turning on conditioner",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF442268),
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 50,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                        primarySwatch: Colors.deepPurple,
                                        unselectedWidgetColor:
                                        const Color(0xFF442268), // Your color
                                      ),
                                      child: Radio(
                                          value: "yes",
                                          groupValue: cubit.Q5,
                                          onChanged: (String? value) {
                                            cubit.get_question_value(value, 5);
                                          }),
                                    ),
                                    const Text(
                                      'Yes',
                                      style: TextStyle(
                                          color: Color(0xFF836D9A),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                             Spacer(),
                              Expanded(
                                child: Row(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                        primarySwatch: Colors.deepPurple,
                                        unselectedWidgetColor:
                                        const Color(0xFF442268), // Your color
                                      ),
                                      child: Radio(
                                          value: "no",
                                          groupValue: cubit.Q5,
                                          onChanged: (String? value) {
                                            cubit.get_question_value(value, 5);
                                          }),
                                    ),
                                    const Text(
                                      'No',
                                      style: TextStyle(
                                          color: Color(0xFF836D9A),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: const [
                              Text(
                                "Bring someone to children",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF442268),
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 50,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                        primarySwatch: Colors.deepPurple,
                                        unselectedWidgetColor:
                                        const Color(0xFF442268), // Your color
                                      ),
                                      child: Radio(
                                          value: "yes",
                                          groupValue: cubit.Q6,
                                          onChanged: (String? value) {
                                            cubit.get_question_value(value, 6);
                                          }),
                                    ),
                                    const Text(
                                      'Yes',
                                      style: TextStyle(
                                          color: Color(0xFF836D9A),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Expanded(
                                child: Row(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                        primarySwatch: Colors.deepPurple,
                                        unselectedWidgetColor:
                                        const Color(0xFF442268), // Your color
                                      ),
                                      child: Radio(
                                          value: "no",
                                          groupValue: cubit.Q6,
                                          onChanged: (String? value) {
                                            cubit.get_question_value(value, 6);
                                          }),
                                    ),
                                    const Text(
                                      'No',
                                      style: TextStyle(
                                          color: Color(0xFF836D9A),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: const [
                              Text(
                                "Bring someone to pets",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF442268),
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 50,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                        primarySwatch: Colors.deepPurple,
                                        unselectedWidgetColor:
                                        const Color(0xFF442268), // Your color
                                      ),
                                      child: Radio(
                                          value: "yes",
                                          groupValue: cubit.Q7,
                                          onChanged: (String? value) {
                                            cubit.get_question_value(value, 7);
                                          }),
                                    ),
                                    const Text(
                                      'Yes',
                                      style: TextStyle(
                                          color: Color(0xFF836D9A),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Expanded(
                                child: Row(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                        primarySwatch: Colors.deepPurple,
                                        unselectedWidgetColor:
                                        const Color(0xFF442268), // Your color
                                      ),
                                      child: Radio(
                                          value: "no",
                                          groupValue: cubit.Q7,
                                          onChanged: (String? value) {
                                            cubit.get_question_value(value, 7);
                                          }),
                                    ),
                                    const Text(
                                      'No',
                                      style: TextStyle(
                                          color: Color(0xFF836D9A),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5,),

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
                                onPressed: () async{
                                  if (cubit.Q1 == null || cubit.Q2 == null ||
                                      cubit.Q3 == null ||
                                      cubit.Q4 == null || cubit.Q5 == null ||
                                      cubit.Q6 == null ||
                                      cubit.Q7 == null) {
                                    ShowToast("Please enter all properties",
                                        ToastState.Error);
                                  }
                                  else  {
                                    cubit.userPostModel?.trip_gender=cubit.Q1;
                                    cubit.userPostModel?.smoke=cubit.Q2=="yes"?"1":"0";
                                    cubit.userPostModel?.trip_smoke=cubit.Q3=="yes"?"1":"0";
                                    cubit.userPostModel?.trip_music=cubit.Q4=="yes"?"1":"0";
                                    cubit.userPostModel?.trip_conditioner=cubit.Q5=="yes"?"1":"0";
                                    cubit.userPostModel?.trip_children=cubit.Q6=="yes"?"1":"0";
                                    cubit.userPostModel?.trip_pets=cubit.Q7=="yes"?"1":"0";
                                     //cubit.send_code();
                                    cubit.get_cluster();

                                  }
                                }
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(20)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
