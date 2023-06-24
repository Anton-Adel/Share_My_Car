import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/core/global_models/user_post_model.dart';
import 'package:gp/user/data/data_source/user_remote_data_source.dart';
import 'package:gp/user/data/repository/user_repository.dart';
import 'package:gp/user/domain/repository/base_user_repository.dart';
import 'package:gp/user/domain/usecase/user_register_usecase.dart';
import 'package:gp/user/domain/usecase/user_update_usecase.dart';
import 'package:image_picker/image_picker.dart';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {

  File? image;
  final picker = ImagePicker();

  Future<File> get_image() async
  {
    final f = await picker.pickImage(source: ImageSource.camera);
    if (f != null) {
      image = File(f.path);
      print(image);
    }
    return image!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          color: Colors.green,
          onPressed: () async {
            final x = await get_image();

            final UserPostModel userPostModel = UserPostModel(
                first_name:"Eslam",
                last_name: "last_name",
                gender: "gender",
                age: "12",
                id_number: "12345678912345",
                email: "antonadel@gmail.com",
                country: "country",
                city: "city",
                address: "address",
                password: "123456789",
                phone_number: "01276146964",
                have_car: "0",
                trip_gender: "trip_gender",
                smoke: "0",
                trip_smoke: "0",
                trip_music: "0",
                trip_conditioner: "0",
                trip_children: "0",
                trip_pets: "0",

            );
            BaseUserRemoteDataSource baseUserRemoteDataSource = UserRemoteDataSource();
            BaseUserRepository baseUserRepository = UserRepository(
                baseUserRemoteDataSource);
            UserUpdateUseCase userUpdateUseCase = UserUpdateUseCase(
                baseUserRepository);
            userUpdateUseCase(Parameter_update(userPostModel:userPostModel,id: 16));
          },
          child: Text("click"),
        ),
      ),
    );
  }
}
