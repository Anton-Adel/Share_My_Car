import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp/core/base_usecase.dart';
import 'package:gp/core/error/failure.dart';
import 'package:gp/trip/domain/entity/trip_entity.dart';
import 'package:gp/trip/domain/entity/trip_entity.dart';
import 'package:gp/trip/domain/respository/base_trip_repository.dart';
import 'package:gp/user/domain/entity/user_entity.dart';

import '../../../user/domain/repository/base_user_repository.dart';

class TripCreateUseCase extends BaseUseCase<TripEntity, Parameter_trip_create> {
  final BaseTripRepository baseTripRepository;

  TripCreateUseCase(this.baseTripRepository);

  @override
  Future<Either<Failure, TripEntity>> call(Parameter_trip_create parameter) async {
    return await baseTripRepository.tripCreate(
        start_location: parameter.start_location,
        end_location: parameter.end_location,
        start_time: parameter.start_time,
        end_time: parameter.end_time,
        user_id: parameter.user_id);
  }
}

class Parameter_trip_create extends Equatable {
  final String start_location;
  final String end_location;
  final String start_time;
  final String end_time;
  final String user_id;

  Parameter_trip_create(
      {required this.start_location,
      required this.end_location,
      required this.start_time,
      required this.end_time,
      required this.user_id});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [start_location, end_location, start_time, end_time, user_id];
}
