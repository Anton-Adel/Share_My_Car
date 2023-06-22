import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp/core/base_usecase.dart';
import 'package:gp/core/error/failure.dart';
import 'package:gp/trip/domain/entity/trip_entity.dart';
import 'package:gp/trip/domain/entity/trip_entity.dart';
import 'package:gp/trip/domain/respository/base_trip_repository.dart';
import 'package:gp/user/domain/entity/user_entity.dart';

import '../../../user/domain/repository/base_user_repository.dart';

class TripUserGetUseCase extends BaseUseCase<List<TripEntity>, Parameter_user_get_all_tirps> {
  final BaseTripRepository baseTripRepository;

  TripUserGetUseCase(this.baseTripRepository);

  @override
  Future<Either<Failure, List<TripEntity>>> call(Parameter_user_get_all_tirps parameter) async {
    return await baseTripRepository.tripUserGetAll(user_id: parameter.user_id);
  }
}
class Parameter_user_get_all_tirps extends Equatable {
  final int user_id;

  Parameter_user_get_all_tirps(
      {
        required this.user_id});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [ user_id];
}

