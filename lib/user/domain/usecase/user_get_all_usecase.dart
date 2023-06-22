import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp/core/base_usecase.dart';
import 'package:gp/core/error/failure.dart';
import 'package:gp/user/domain/entity/user_entity.dart';

import '../repository/base_user_repository.dart';

class UserGetAllUseCase extends BaseUseCase<List<UserEntity>,NoParameter>
{
  final BaseUserRepository baseUserRepository;

  UserGetAllUseCase(this.baseUserRepository);
  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParameter parameter) async{
    return await baseUserRepository.userGetAll();
  }
}

