
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

void ShowToast(String message,ToastState state)
{
  // Fluttertoast.showToast(
  //     msg: "please check gender field & have car question",
  //     toastLength: Toast.LENGTH_LONG,
  //     gravity: ToastGravity.CENTER,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: const Color(0xFF442268),
  //     textColor: Colors.white,
  //     fontSize: 16.0
  // );
  Fluttertoast.showToast(
      msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: ToastColor(state),
    textColor: Colors.white,
    fontSize:20,
  );

}


enum ToastState{Error,Success,TakeCar}

Color ToastColor (ToastState state)
{
  Color? c;
  switch(state)
  {
    case ToastState.Error:
      c=Colors.red;
      break;

    case ToastState.Success:
      c=const Color(0xFF442268);
      break;

    case ToastState.TakeCar :
      c= Colors.black;
      break;
  }
  return c;
}


File? image;
final picker = ImagePicker();

Future<File> get_image() async
{
  final f = await picker.pickImage(source: ImageSource.gallery);
  if (f != null) {
    image = File(f.path);
    print(image);
  }
  return image!;
}


