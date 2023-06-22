import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gp/core/error/failure.dart';
import 'package:gp/user/domain/entity/user_entity.dart';

abstract class BaseUserRepository
{
  Future<Either <Failure,UserEntity>> userLogin({required String email,required String password});
  Future<Either <Failure,Map<String,dynamic>>> userRegister({required String email,required String password,required File image1,required File image2});
  Future<Either <Failure,UserEntity>> userGet({required int user_id});
  Future<Either <Failure,List<UserEntity>>> userGetAll();
  Future<Either <Failure,UserEntity>> userUpdate({required String first_name,required String last_name,required int id,required File personal_image});
}