import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp/user/domain/entity/user_entity.dart';

import '../../../core/base_usecase.dart';
import '../../../core/error/failure.dart';
import '../../../core/global_models/user_post_model.dart';
import '../repository/base_user_repository.dart';

class UserRegisterUseCase extends BaseUseCase<Map<String,dynamic>,Parameter_register>
{
  final BaseUserRepository baseUserRepository;

  UserRegisterUseCase(this.baseUserRepository);
  @override
  Future<Either<Failure, Map<String,dynamic>>> call(Parameter_register parameter) async{
    return await baseUserRepository.userRegister(userPostModel: parameter.userPostModel);
  }
}

class Parameter_register extends Equatable
{
  final UserPostModel userPostModel;


  Parameter_register({required this.userPostModel});

  @override
  // TODO: implement props
  List<Object?> get props => [userPostModel];


}