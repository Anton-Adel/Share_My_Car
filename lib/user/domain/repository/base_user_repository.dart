import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gp/core/error/failure.dart';
import 'package:gp/core/global_models/user_post_model.dart';
import 'package:gp/user/domain/entity/user_entity.dart';

abstract class BaseUserRepository
{
  Future<Either <Failure,UserEntity>> userLogin({required String email,required String password});

  Future<Either <Failure,Map<String,dynamic>>> userRegister({required UserPostModel userPostModel});

  Future<Either <Failure,UserEntity>> userGet({required int user_id});
  Future<Either <Failure,List<UserEntity>>> userGetAll();
  Future<Either <Failure,UserEntity>> userUpdate({required UserPostModel userPostModel, required int id});
}