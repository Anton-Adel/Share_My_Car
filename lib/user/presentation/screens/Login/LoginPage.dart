import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/user/presentation/screens/Register/SignupPage.dart';
import 'package:gp/user/presentation/controller/login/login_cubit.dart';
import 'package:gp/user/presentation/controller/login/login_states.dart';

class LoginPage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginPage({super.key});
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => LoginCubit(),
  child: BlocConsumer<LoginCubit, LoginState>(
  listener: (context, state) {

  },
  builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
          key:formKey ,
          child: Column(
            children: [
              // text over image
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height*0.25,
                width: double.infinity,
                // decoration: const BoxDecoration(
                //     // image: DecorationImage(
                //     //     image: AssetImage("assets/sh.jpg"),
                //     //     fit: BoxFit.cover)
                //        ),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          // width: double.infinity,
                          child:  Divider(
                            color: Colors.white,
                            height: 0,
                            thickness: 3.9,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),

                          child:  Divider(
                            color: Colors.white,
                            height: 0,
                            thickness: 3.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // login process
              Container(
                //height: 600,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F2F8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F2F8),
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        // text (have account or no)
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            "Have an account ?",
                            style:
                            TextStyle(color: Color(0xFF442268), fontSize: 28),
                          ),
                        ),

                        const Padding(padding: EdgeInsets.all(2)),
                        // name edit text
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'E-mail',
                                labelStyle: TextStyle(
                                    color: Color(0xFF836D9A),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 25)),
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return "Email Must not be empty";
                              }
                              else
                              {
                                return null;
                              }
                            },
                          ),
                        ),


                        // password edit text
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 40),
                          child: TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    color: Color(0xFF836D9A),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 25)),
                            validator: (value){
                              if(value!.isEmpty)
                                {
                                  return "Password Must not be empty";
                                }
                              else
                                {
                                  return null;
                                }
                            },
                          ),
                        ),

                        const Padding(padding: EdgeInsets.all(5)),

                        // login button
                        Container(
                          height: 70,
                          width: 360,
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF3C1858),
                            ),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  backgroundColor: Color(0xFF3C1858)),
                            ),
                            onPressed: () {
                              if(formKey.currentState!.validate()) {
                                LoginCubit.get(context).Login(
                                    email: nameController.text,
                                    password: passwordController.text);
                              }
                            },
                          ),
                        ),


                        // signup button
                        Container(
                          height: 75,
                          width: 360,
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFFF7F2F8),
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 2, color: Color(0xFF3C1858)),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            child: const Text(
                              'Sign UP',
                              style: TextStyle(
                                  color: Color(0xFF3C1858),
                                  fontSize: 28,
                                  backgroundColor: Color(0xFFF7F2F8)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>  SignUpPage()));
                            },
                          ),
                        ),

                        const Padding(padding: EdgeInsets.all(5)),

                        // forget password
                        TextButton(
                          onPressed: () {
                            //forgot password screen
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  width: 50,
                                  child: const Divider(
                                    color: Color(0xFF442268),
                                    height: 0,
                                    thickness: 2.5,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 13,
                              ),
                              const Text(
                                'Forgot Password ?',
                                style: TextStyle(
                                    color: Color(0xFF442268),
                                    fontSize: 28,
                                    fontWeight: FontWeight.w400,
                                    backgroundColor: Color(0xFFF7F2F8)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  width: 50,
                                  child: const Divider(
                                    color: Color(0xFF442268),
                                    height: 0,
                                    thickness: 2.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
),
);
  }
}

