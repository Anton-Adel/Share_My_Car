import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp/core/base_usecase.dart';
import 'package:gp/core/error/failure.dart';
import 'package:gp/trip/domain/entity/trip_entity.dart';
import 'package:gp/trip/domain/entity/trip_entity.dart';
import 'package:gp/trip/domain/respository/base_trip_repository.dart';
import 'package:gp/user/domain/entity/user_entity.dart';

import '../../../user/domain/repository/base_user_repository.dart';

class TripGetAllUseCase extends BaseUseCase<List<TripEntity>, NoParameter> {
  final BaseTripRepository baseTripRepository;

  TripGetAllUseCase(this.baseTripRepository);

  @override
  Future<Either<Failure, List<TripEntity>>> call(NoParameter parameter) async {
    return await baseTripRepository.tripGetAll();
  }
}

