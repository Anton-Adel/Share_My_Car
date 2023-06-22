import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
final picker=ImagePicker();
Future<File> get_image() async
{

  final f=await picker.pickImage(source: ImageSource.camera);
  if(f!=null)
    {
      image=File(f.path);
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
          onPressed: () async{
            final x=await get_image();

            BaseUserRemoteDataSource baseUserRemoteDataSource=UserRemoteDataSource();
            BaseUserRepository baseUserRepository=UserRepository(baseUserRemoteDataSource);
            UserUpdateUseCase userUpdateUseCase=UserUpdateUseCase(baseUserRepository);
            userUpdateUseCase(Parameter_update(last_name: "anton",first_name: 'anton',personal_image: image!,id: 10));
          },
          child: Text("click"),
        ),
      ),
    );
  }
}
