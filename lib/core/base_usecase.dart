import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp/core/error/failure.dart';

abstract class BaseUseCase<T,Parameter>
{

  Future<Either<Failure,T>> call(Parameter parameter); // ممكن نستخدم []
}

class NoParameter extends Equatable
{
  const NoParameter();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}