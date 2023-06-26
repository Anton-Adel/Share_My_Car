import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:gp/Register/CarInfo.dart';

import '../Drivers/Home.dart';

// const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();

  TextEditingController personalImage = TextEditingController();
  TextEditingController idCardImage = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController idController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String? gender =null;

  // datapicker
  TextEditingController dateInput = TextEditingController();

  // have a car or not
  bool yes = false;
  bool no = false;

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_city);
    _itemSelected = _dropdownMenuItems?[1].value!;
  }

  // List of City
  // String dropdownValue = list.first;
  final List<ListItem> _city = [
    ListItem(1, "Cairo"),
    ListItem(2, "Alex"),
    ListItem(3, "Giza"),
  ];

  List<DropdownMenuItem<ListItem>>? _dropdownMenuItems;
  ListItem? _itemSelected;

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = [];
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
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
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                            validator: (value){
                              if(value!.isEmpty){
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
                            validator: (value){
                              if(value!.isEmpty){
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

                                  groupValue: gender,
                                  onChanged: (String? value) {
                                    setState(() {
                                      gender = value!;

                                    });
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
                                  groupValue: gender,
                                  onChanged: (String? value) {
                                    setState(() {
                                      gender = value!;
                                    });
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
                      controller: dateInput,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'date must not be empty';
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Birthdate',
                          labelStyle: TextStyle(
                              color: Color(0xFF836D9A),
                              fontWeight: FontWeight.w300,
                              fontSize: 20),
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: Color(0xFF442268),
                            size: 30,
                          )),
                      readOnly:
                      true, //set it true, so that user will not able to edit text

                      // datePicker
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10
                          String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            dateInput.text =
                                formattedDate; //set output date to TextFormField value.
                          });
                        } else {}
                      },
                    ),
                  ),

                  // id num
                  Container(

                    height: 85,
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: idController,
                      validator: (value){
                        if(value!.isEmpty){
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

                    height: 85,
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      controller: personalImage,
                      validator: (value){
                        if(value!.isEmpty){
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
                          onPressed: () {
                            print('hello');
                          },
                          icon: const Icon(Icons.add_photo_alternate),
                        ),
                      ),
                    ),
                  ),
                  Container(

                    height: 85,
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      controller: idCardImage,
                      validator: (value){
                        if(value!.isEmpty){
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
                          onPressed: () {
                            print('hello');
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
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                      validator: (value){
                        if(value!.isEmpty){
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
                      validator: (value){
                        if(value!.isEmpty){
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
                  const Padding(padding: EdgeInsets.all(10)),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 160,
                        height: 60,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              style: const TextStyle(
                                  color: Color(0xFF836D9A),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20),
                              value: _itemSelected,
                              items: _dropdownMenuItems,
                              onChanged: (ListItem? value) {
                                setState(() {
                                  _itemSelected = value!;
                                });
                              },
                            )),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Container(
                        width: 160,
                        height: 60,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: const Text("City"),
                              disabledHint: const Text("country"),
                              style: const TextStyle(
                                  color: Color(0xFF836D9A),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20),
                              value: _itemSelected,
                              items: _dropdownMenuItems,
                              onChanged: (ListItem? value) {
                                setState(() {
                                  _itemSelected = value!;
                                });
                              },
                            )),
                      ),
                    ],
                  ),

                  // address
                  const Padding(padding: EdgeInsets.all(10)),
                  Container(
                    width: 400,
                    height: 85,
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      controller:addressController ,
                      validator: (value){
                        if(value!.isEmpty){
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
                      validator: (value){
                        if(value!.isEmpty){
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
                      Border.all(color: const Color(0xFF442268), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(children: [
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            "Have a car ?",
                            style:
                            TextStyle(color: Color(0xFF442268), fontSize: 25),
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
                                padding: EdgeInsets.fromLTRB(10, 40, 0, 0),
                              ),
                              const Text(
                                "Yes",
                                style: TextStyle(
                                    color: Color(0xFF442268), fontSize: 25),
                              ),
                              Theme(
                                data: ThemeData(
                                  primarySwatch: Colors.deepPurple,
                                  unselectedWidgetColor:
                                  const Color(0xFF442268), // Your color
                                ),
                                child: Checkbox(
                                    value: yes,
                                    onChanged: ((value) {
                                      setState(() {
                                        yes = value!;
                                      });
                                    })),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                              ),
                              const Text(
                                "No",
                                style: TextStyle(
                                    color: Color(0xFF442268), fontSize: 25),
                              ),
                              Theme(
                                data: ThemeData(
                                  primarySwatch: Colors.deepPurple,
                                  unselectedWidgetColor:
                                  const Color(0xFF442268), // Your color
                                ),
                                child: Checkbox(
                                    value: no,
                                    onChanged: ((value) {
                                      setState(() {
                                        no = value!;
                                      });
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
                        if(formKey.currentState!.validate() && (yes == true || no == true ) && gender !=null){
                          if(yes == true){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CarInfo()));
                          }else{
                            // not have a car
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          }
                        }else{
                          print("please enter gender");
                          Fluttertoast.showToast(
                              msg: "please check gender field & have car question",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: const Color(0xFF442268),
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
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
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
