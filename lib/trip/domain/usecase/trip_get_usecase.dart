import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp/core/base_usecase.dart';
import 'package:gp/core/error/failure.dart';
import 'package:gp/trip/domain/entity/trip_entity.dart';
import 'package:gp/trip/domain/entity/trip_entity.dart';
import 'package:gp/trip/domain/respository/base_trip_repository.dart';
import 'package:gp/user/domain/entity/user_entity.dart';

import '../../../user/domain/repository/base_user_repository.dart';

class TripGetUseCase extends BaseUseCase<TripEntity, Parameter_get_only_tirp> {
  final BaseTripRepository baseTripRepository;

  TripGetUseCase(this.baseTripRepository);

  @override
  Future<Either<Failure, TripEntity>> call(Parameter_get_only_tirp parameter) async {
    return await baseTripRepository.tripGet(trip_id: parameter.trip_id);
  }
}
class Parameter_get_only_tirp extends Equatable {
  final int trip_id;

  Parameter_get_only_tirp(
      {
        required this.trip_id});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [ trip_id];
}

