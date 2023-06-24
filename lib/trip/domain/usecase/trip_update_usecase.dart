import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp/core/base_usecase.dart';
import 'package:gp/core/error/failure.dart';
import 'package:gp/trip/domain/entity/trip_entity.dart';
import 'package:gp/trip/domain/entity/trip_entity.dart';
import 'package:gp/trip/domain/respository/base_trip_repository.dart';
import 'package:gp/user/domain/entity/user_entity.dart';

import '../../../user/domain/repository/base_user_repository.dart';

class TripUpdateUseCase extends BaseUseCase<TripEntity, Parameter_trip_update> {
  final BaseTripRepository baseTripRepository;

  TripUpdateUseCase(this.baseTripRepository);

  @override
  Future<Either<Failure, TripEntity>> call(Parameter_trip_update parameter) async {
    return await baseTripRepository.tripUpdate(
        start_location: parameter.start_location,
        end_location: parameter.end_location,
        start_time: parameter.start_time,
        end_time: parameter.end_time,
        user_id: parameter.user_id,
        user_cluster: parameter.user_cluster,
        id: parameter.id
    );
  }
}

class Parameter_trip_update extends Equatable {
  final String start_location;
  final String end_location;
  final String start_time;
  String? end_time;
  final String user_id;
  final String user_cluster;
  final int id;

  Parameter_trip_update(
      {required this.start_location,
        required this.end_location,
        required this.start_time,
         this.end_time,
        required this.user_id,
        required this.user_cluster,
        required this.id

      });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [start_location, end_location, start_time, end_time, user_id,user_cluster,id];
}
