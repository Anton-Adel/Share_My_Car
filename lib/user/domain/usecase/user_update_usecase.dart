import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp/core/base_usecase.dart';
import 'package:gp/core/error/failure.dart';
import 'package:gp/user/domain/repository/base_user_repository.dart';

import '../../../core/global_models/user_post_model.dart';
import '../entity/user_entity.dart';

class UserUpdateUseCase extends BaseUseCase<UserEntity, Parameter_update> {
  final BaseUserRepository baseUserRepository;

  UserUpdateUseCase(this.baseUserRepository);

  @override
  Future<Either<Failure, UserEntity>> call(Parameter_update parameter) async {
    return await baseUserRepository.userUpdate(
       userPostModel: parameter.userPostModel,
      id: parameter.id
    );
  }
}

class Parameter_update extends Equatable {
  final UserPostModel userPostModel;
  final int id;
  Parameter_update(
      {
        required this.userPostModel,
        required this.id

      });

  @override
  // TODO: implement props
  List<Object?> get props => [
        userPostModel,
    id
      ];
}
