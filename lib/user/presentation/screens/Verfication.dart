import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/user/presentation/controller/Register/register_cubit.dart';
import 'package:gp/user/presentation/controller/Register/register_state.dart';

import '../../../core/shared_components/Constants.dart';

class verfication extends StatelessWidget {
  verfication({Key? key}) : super(key: key);
  String code = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit= RegisterCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 60.0,
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,

                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F3F9),
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(

                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Text(
                            'Verfication',
                            style: TextStyle(
                                color: Color(0xFF442268),
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          const Text(
                            'Please enter the code sent to the e-mail you entered: ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _textFieldOTP(
                                    first: true, last: false, context: context),
                                _textFieldOTP(first: false,
                                    last: false,
                                    context: context),
                                _textFieldOTP(first: false,
                                    last: false,
                                    context: context),
                                _textFieldOTP(
                                    first: false, last: true, context: context),
                              ]),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            'Please Enter the code',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                           TextButton(onPressed: () {

                            cubit.send_code();
                          }, child: const Text(
                            'Send again?',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          )),
                          const SizedBox(
                            height: 40.0,
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                        ]),
                  ),
                ),

                const SizedBox(
                  height: 60.0,
                ),

                // button next
                ElevatedButton(
                  child: const Text('Next'),
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF442268),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      textStyle:
                      const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    if(int.parse(code)==Code)
                      {
                        cubit.Register();
                      }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _textFieldOTP({bool first = true, last, context}) {
    return Container(
      height: 50,
      width: 50,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextFormField(

          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              if (code == "") {
                code = value;
              }
              else {
                code += value;
              }
              FocusScope.of(context).nextFocus();
            }
            else if (value.length == 1) {
              code += value;
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}


