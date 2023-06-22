import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp/user/domain/entity/user_entity.dart';

import '../../../core/base_usecase.dart';
import '../../../core/error/failure.dart';
import '../repository/base_user_repository.dart';

class UserRegisterUseCase extends BaseUseCase<Map<String,dynamic>,Parameter_register>
{
  final BaseUserRepository baseUserRepository;

  UserRegisterUseCase(this.baseUserRepository);
  @override
  Future<Either<Failure, Map<String,dynamic>>> call(Parameter_register parameter) async{
    return await baseUserRepository.userRegister(email: parameter.email, password: parameter.password, image1: parameter.image1,image2: parameter.image2);
  }
}

class Parameter_register extends Equatable
{
  final String email;
  final String password;
  final File image1,image2;


  Parameter_register({required this.image2,required this.image1,required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [email,password,image1,image2];
}