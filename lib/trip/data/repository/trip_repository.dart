import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:gp/core/error/failure.dart';
import 'package:gp/trip/domain/entity/trip_entity.dart';
import 'package:gp/trip/domain/respository/base_trip_repository.dart';

import '../../../core/error/exception.dart';
import '../../../core/shared_components/Constants.dart';
import '../../../user/data/data_source/user_remote_data_source.dart';
import '../model/trip_model.dart';

class TripRepository extends BaseTripRepository {
  final BaseUserRemoteDataSource baseUserRemoteDataSource;

  TripRepository(this.baseUserRemoteDataSource);

  @override
  Future<Either<Failure, TripEntity>> tripCreate({
    required String start_location,
    required String end_location,
    required String start_time,
    String? end_time,
    required String user_id,
    required String user_cluster,
    required String start_date,
    String? shared_seats,
  }) async {
    try {
    var response = await baseUserRemoteDataSource.postRequest("$PATH/trip", {
      "start_location": start_location,
      "end_location": end_location,
      "start_time": start_time,
      "end_time": end_time,
      "user_id": user_id,
      'user_cluster': user_cluster,
      'start_date': start_date,
      "shared_seats": shared_seats
    });

      print(response["result"]);

      response['result']["user_id"] = int.parse(response['result']["user_id"]);
      return Right(TripModel.fromjson(response["result"]));
    }
    on ServerException catch (e) {
      print("Adel");
      return Left(Failure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, TripEntity>> tripGet({required int trip_id}) async {
    try {
    var response = await baseUserRemoteDataSource
        .getRequest("http://192.168.1.3:9000/api/trip/$trip_id");
    // try {
      //print(response);
      var trip_list = TripModel.fromjson(response["result"]);
      print(trip_list.user_id);
      return Right(trip_list);
      //return Right(List<UserEntity>.from((response.data["results"] as List).map((e) => UserModel.fromjson(e))));
    } on ServerException catch (e) {
      return Left(Failure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, List<TripEntity>>> tripGetAll() async {
    try {
    var response = await baseUserRemoteDataSource
        .getRequest("http://192.168.1.3:9000/api/trip");
    // try {
      //print(response);
      var trip_list = List<TripModel>.from(
          (response["result"] as List).map((e) => TripModel.fromjson(e)));
      print(trip_list);
      return Right(trip_list);
      //return Right(List<UserEntity>.from((response.data["results"] as List).map((e) => UserModel.fromjson(e))));
    } on ServerException catch (e) {
      return Left(Failure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, List<TripEntity>>> tripUserGetAll(
      {required int user_id}) async {
    try {
    var response = await baseUserRemoteDataSource
        .getRequest("http://192.168.1.3:9000/api/user_trips/$user_id");
    // try {
      //print(response);
      var trip_list = List<TripModel>.from(
          (response["result"] as List).map((e) => TripModel.fromjson(e)));
      print(trip_list);
      return Right(trip_list);
      //return Right(List<UserEntity>.from((response.data["results"] as List).map((e) => UserModel.fromjson(e))));
    } on ServerException catch (e) {
      return Left(Failure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, TripEntity>> tripUpdate(
      {required int id,
      required String start_location,
      required String end_location,
      required String start_time,
      String? end_time,
      required String user_id,
      required String user_cluster}) async {
    try {
    var response = await baseUserRemoteDataSource
        .postRequest("http://192.168.1.10:9000/api/trip/$id", {
      "_method": "PUT",
      "start_location": start_location,
      "end_location": end_location,
      "start_time": start_time,
      "end_time": end_time ?? "00:00:00",
      "user_id": user_id,
      'user_cluster': user_cluster
    });
    // try {
      print(response["result"]);

      response['result']["user_id"] = response['result']["user_id"];
      return Right(TripModel.fromjson(response["result"]));
    } on ServerException catch (e) {
      return Left(Failure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, TripEntity>> tripDelete({required int id}) async {
    try {
    var response = await baseUserRemoteDataSource
        .deleteRequest("http://192.168.1.10:9000/api/trip/$id");
    // try {
      print(response["result"]);

      return Right(TripModel.fromjson(response["result"]));
    } on ServerException catch (e) {
      return Left(Failure(e.errorMessageModel.message));
    }
  }
}
