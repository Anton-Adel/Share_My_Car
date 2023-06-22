import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp/core/base_usecase.dart';
import 'package:gp/core/error/failure.dart';
import 'package:gp/user/domain/entity/user_entity.dart';

import '../repository/base_user_repository.dart';

class UserGetUseCase extends BaseUseCase<UserEntity,Parameter_User_Get>
{
  final BaseUserRepository baseUserRepository;

  UserGetUseCase(this.baseUserRepository);
  @override
  Future<Either<Failure, UserEntity>> call(Parameter_User_Get parameter) async{
    return await baseUserRepository.userGet(user_id: parameter.id);
  }
}

class Parameter_User_Get extends Equatable
{
  final int id;


  Parameter_User_Get({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}