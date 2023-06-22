import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp/core/base_usecase.dart';
import 'package:gp/core/error/failure.dart';
import 'package:gp/user/domain/entity/user_entity.dart';

import '../repository/base_user_repository.dart';

class UserLoginUseCase extends BaseUseCase<UserEntity,Parameter_login>
{
  final BaseUserRepository baseUserRepository;

   UserLoginUseCase(this.baseUserRepository);
  @override
  Future<Either<Failure, UserEntity>> call(Parameter_login parameter) async{
   return await baseUserRepository.userLogin(email: parameter.email,password: parameter.password);
  }
}

class Parameter_login extends Equatable
{
  final String email;
  final String password;

  Parameter_login({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [email,password];
}