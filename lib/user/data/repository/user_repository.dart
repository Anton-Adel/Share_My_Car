import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gp/core/error/exception.dart';
import 'package:gp/core/error/failure.dart';
import 'package:gp/core/global_models/user_post_model.dart';
import 'package:gp/user/data/data_source/user_remote_data_source.dart';
import 'package:gp/user/data/model/user_model.dart';
import 'package:gp/user/domain/entity/user_entity.dart';
import 'package:gp/user/domain/repository/base_user_repository.dart';

import '../../../core/shared_components/Constants.dart';

class UserRepository extends BaseUserRepository{
  final BaseUserRemoteDataSource baseUserRemoteDataSource;

  UserRepository(this.baseUserRemoteDataSource);
  @override

  //192.168.1.185
  Future<Either<Failure, UserEntity>> userGet({required int user_id}) async {
    var respons= await baseUserRemoteDataSource.getRequest("$PATH/user/${user_id}");
    try
    {
      //print(respons);
      //var x=List<UserEntity>.from((respons["result"] as List).map((e) => UserModel.fromjson(e)));
      //print(respons["result"]['have_car']);
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
    var respons= await baseUserRemoteDataSource.getRequest("$PATH/user");
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
    var respons= await baseUserRemoteDataSource.postRequest("$PATH/login", {
      "email": email,
      "password":password
    });
    try
    {

      Token="Bearer ";
      Token+=respons["result"]["token"];
      print("token");
      print(Token);
      return Right(UserModel.fromjson(respons["result"]));

    } on ServerException catch(e)
    {
      return Left(Failure(e.errorMessageModel.message));
    }
    return respons;

  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> userRegister({required UserPostModel userPostModel}) async{
    var respons= await baseUserRemoteDataSource.postWithImage("$PATH/register", {
      "first_name": userPostModel.first_name,
      "last_name":userPostModel.last_name,
      "gender": userPostModel.gender,
      "age":userPostModel.age,
      "id_number": userPostModel.id_number,
      "email":userPostModel.email,
      "password": userPostModel.password,
      "c_password":userPostModel.password,
      "country":userPostModel.country,
      "city": userPostModel.city,
      "address":userPostModel.address,
      "phone_number": userPostModel.phone_number,
      "have_car":userPostModel.have_car,
      "car_model": userPostModel.car_model,
      "car_color":userPostModel.car_color,
      "car_plate_number": userPostModel.car_plate_number,
      "trip_gender":userPostModel.trip_gender,
      "smoke": userPostModel.smoke,
      "trip_smoke":userPostModel.trip_smoke,
      "trip_music": userPostModel.trip_music,
      "trip_conditioner":userPostModel.trip_conditioner,
      "trip_children": userPostModel.trip_children,
      "trip_pets":userPostModel.trip_pets,
      "car_seats": userPostModel.car_seats,
      'cluster_number':userPostModel.cluster_number,
    },

      personal_image: userPostModel.personal_image!,
      card_image: userPostModel.card_image!,
      car_image: userPostModel.car_image,
      car_license_image: userPostModel.car_license_image,
      car_plate_image: userPostModel.car_plate_image

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
  Future<Either<Failure, UserEntity>> userUpdate({required UserPostModel userPostModel,required int id}) async {

    var respons= await baseUserRemoteDataSource.updateRequest("$PATH/user/$id", {

      "_method":"PUT",
      "first_name": userPostModel.first_name,
      "last_name":userPostModel.last_name,
      "gender": userPostModel.gender,
      "age":userPostModel.age,
      "id_number": userPostModel.id_number,
      "email":userPostModel.email,
      "password": userPostModel.password,
      "c_password":userPostModel.password,
      "country":userPostModel.country,
      "city": userPostModel.city,
      "address":userPostModel.address,
      "phone_number": userPostModel.phone_number,
      "have_car":userPostModel.have_car,
      "car_model": userPostModel.car_model,
      "car_color":userPostModel.car_color,
      "car_plate_number": userPostModel.car_plate_number,
      "trip_gender":userPostModel.trip_gender,
      "smoke": userPostModel.smoke,
      "trip_smoke":userPostModel.trip_smoke,
      "trip_music": userPostModel.trip_music,
      "trip_conditioner":userPostModel.trip_conditioner,
      "trip_children": userPostModel.trip_children,
      "trip_pets":userPostModel.trip_pets,
      "car_seats": userPostModel.car_seats,
    },
        personal_image: userPostModel.personal_image,
        card_image: userPostModel.card_image,
        car_image: userPostModel.car_image,
        car_license_image: userPostModel.car_license_image,
        car_plate_image: userPostModel.car_plate_image

    );
    try
    {
      print(respons["result"]['have_car']);

      return Right(UserModel.fromjson(respons["result"]));
    } on ServerException catch(e)
    {
      return Left(Failure(e.errorMessageModel.message));
    }
  }


}