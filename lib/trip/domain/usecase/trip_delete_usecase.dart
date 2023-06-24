import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp/core/base_usecase.dart';
import 'package:gp/core/error/failure.dart';
import 'package:gp/trip/domain/respository/base_trip_repository.dart';

import '../entity/trip_entity.dart';

class TripDeleteUseCase extends BaseUseCase<TripEntity,Parameter_delete>
{
  final BaseTripRepository baseTripRepository;

  TripDeleteUseCase(this.baseTripRepository);
  @override
  Future<Either<Failure, TripEntity>> call(Parameter_delete parameter) async {
    return await baseTripRepository.tripDelete(id: parameter.id);
  }

}

class Parameter_delete extends Equatable
{
   final int id;

  Parameter_delete({required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => [id];

}