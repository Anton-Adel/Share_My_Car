import 'package:dartz/dartz.dart';
import 'package:gp/core/error/failure.dart';
import 'package:gp/trip/domain/entity/trip_entity.dart';
import 'package:gp/trip/domain/respository/base_trip_repository.dart';

import '../../../core/error/exception.dart';
import '../../../user/data/data_source/user_remote_data_source.dart';
import '../model/trip_model.dart';

class TripRepository extends BaseTripRepository {
  final BaseUserRemoteDataSource baseUserRemoteDataSource;

  TripRepository(this.baseUserRemoteDataSource);

  @override
  Future<Either<Failure, TripEntity>> tripCreate(
      {required String start_location,
      required String end_location,
      required String start_time,
      required String end_time,
      required String user_id})
  async{
    var respons= await baseUserRemoteDataSource.postRequest("http://192.168.1.3:9000/api/trip", {
      "start_location": start_location,
      "end_location":end_location,
      "start_time":start_time,
      "end_time":end_time,
      "user_id":user_id
    });
    try
    {

      print(respons["result"]);

      respons['result']["user_id"]=int.parse(respons['result']["user_id"]);
      return Right(TripModel.fromjson(respons["result"]));
    } on ServerException catch(e)
    {
      return Left(Failure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, TripEntity>> tripDelete() {
    // TODO: implement tripDelete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TripEntity>> tripGet({required int trip_id}) async{
    var respons= await baseUserRemoteDataSource.getRequest("http://192.168.1.3:9000/api/trip/$trip_id");
    try
    {
      //print(respons);
      var trip_list= TripModel.fromjson(respons["result"]);
      print(trip_list.user_id);
      return Right(trip_list);
      //return Right(List<UserEntity>.from((respons.data["results"] as List).map((e) => UserModel.fromjson(e))));
    } on ServerException catch(e)
    {
      return Left(Failure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, List<TripEntity>>> tripGetAll() async{
    var respons= await baseUserRemoteDataSource.getRequest("http://192.168.1.3:9000/api/trip");
    try
    {
      //print(respons);
      var trip_list=List<TripModel>.from((respons["result"] as List).map((e) => TripModel.fromjson(e)));
      print(trip_list);
      return Right(trip_list);
      //return Right(List<UserEntity>.from((respons.data["results"] as List).map((e) => UserModel.fromjson(e))));
    } on ServerException catch(e)
    {
      return Left(Failure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, TripEntity>> tripUpdate() {
    // TODO: implement tripUpdate
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TripEntity>>> tripUserGetAll({required int user_id}) async{
    var respons= await baseUserRemoteDataSource.getRequest("http://192.168.1.3:9000/api/user_trips/$user_id");
    try
    {
      //print(respons);
      var trip_list=List<TripModel>.from((respons["result"] as List).map((e) => TripModel.fromjson(e)));
      print(trip_list);
      return Right(trip_list);
      //return Right(List<UserEntity>.from((respons.data["results"] as List).map((e) => UserModel.fromjson(e))));
    } on ServerException catch(e)
    {
      return Left(Failure(e.errorMessageModel.message));
    }
  }
}
