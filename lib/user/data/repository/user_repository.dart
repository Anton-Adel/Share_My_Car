import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gp/core/error/exception.dart';
import 'package:gp/core/error/failure.dart';
import 'package:gp/user/data/data_source/user_remote_data_source.dart';
import 'package:gp/user/data/model/user_model.dart';
import 'package:gp/user/domain/entity/user_entity.dart';
import 'package:gp/user/domain/repository/base_user_repository.dart';

class UserRepository extends BaseUserRepository{
  final BaseUserRemoteDataSource baseUserRemoteDataSource;

  UserRepository(this.baseUserRemoteDataSource);
  @override
  
  Future<Either<Failure, UserEntity>> userGet({required int user_id}) async {
    var respons= await baseUserRemoteDataSource.getRequest("http://192.168.1.185:9000/api/user/${user_id}");
    try
    {
      //print(respons);
      //var x=List<UserEntity>.from((respons["result"] as List).map((e) => UserModel.fromjson(e)));
      print(respons["result"]);
      return Right(UserModel.fromjson(respons["result"] ));
      //return Right(List<UserEntity>.from((respons.data["results"] as List).map((e) => UserModel.fromjson(e))));
    }
    on ServerException catch(e)
    {
      return Left(Failure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> userGetAll() async {
    var respons= await baseUserRemoteDataSource.getRequest("http://192.168.1.3:9000/api/user");
    try
    {
      //print(respons);
      var x=List<UserEntity>.from((respons["result"] as List).map((e) => UserModel.fromjson(e)));
      print(x[0].email);
      return Right(List<UserEntity>.from((respons["result"] as List).map((e) => UserModel.fromjson(e))));
      //return Right(List<UserEntity>.from((respons.data["results"] as List).map((e) => UserModel.fromjson(e))));
    } on ServerException catch(e)
    {
      return Left(Failure(e.errorMessageModel.message));
    }
  }
//10.0.2.2:8000
//192.168.1.3:9000
//لازم ارن الlaravel علي بورت 9000و 0.0.0.0
  @override
  Future<Either<Failure, UserEntity>> userLogin({required String email,required String password}) async {
    var respons= await baseUserRemoteDataSource.postRequest("http://192.168.1.3:9000/api/login", {
      "email": email,
      "password":password
    });
    try
    {

      return Right(UserModel.fromjson(respons["result"]));
    } on ServerException catch(e)
    {
      return Left(Failure(e.errorMessageModel.message));
    }
    return respons;

  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> userRegister({required String email,required String password,required File image1,required File image2}) async{
    var respons= await baseUserRemoteDataSource.postWithImage("http://192.168.1.3:9000/api/register", {
      "email": email,
      "password":password
    },
    image1,
      file2: image2
    );
    try
    {
      return Right(respons);
    } on ServerException catch(e)
    {
      return Left(Failure(e.errorMessageModel.message));
    }
    return respons;
  }

  @override
  Future<Either<Failure, UserEntity>> userUpdate({required String first_name, required String last_name,required int id, required File personal_image}) async {

    var respons= await baseUserRemoteDataSource.updateRequest("http://192.168.1.185:9000/api/user/$id", {

      "_method":"PUT",
      "first_name": first_name,
      "last_name":first_name
    },
      personal_image,

    );
    try
    {
      print(respons);

      return Right(UserModel.fromjson(respons["result"]));
    } on ServerException catch(e)
    {
      return Left(Failure(e.errorMessageModel.message));
    }
  }


}