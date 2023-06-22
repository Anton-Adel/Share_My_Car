import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gp/core/error/failure.dart';
import 'package:gp/trip/domain/entity/trip_entity.dart';
import 'package:gp/trip/domain/entity/trip_entity.dart';
import 'package:gp/trip/domain/entity/trip_entity.dart';
import 'package:gp/trip/domain/entity/trip_entity.dart';
import 'package:gp/user/domain/entity/user_entity.dart';

abstract class BaseTripRepository {
  //Future<Either <Failure,TripEntity>> userLogin({required String email,required String password});
  Future<Either<Failure, TripEntity>> tripCreate(
      {required String start_location,
      required String end_location,
      required String start_time,
      required String end_time,
      required String user_id});

  Future<Either<Failure, TripEntity>> tripUpdate();

  Future<Either<Failure, List<TripEntity>>> tripGetAll();

  Future<Either<Failure, TripEntity>> tripGet({required int trip_id});

  Future<Either<Failure, List<TripEntity>>> tripUserGetAll({required int user_id});

  Future<Either<Failure, TripEntity>> tripDelete();
}
