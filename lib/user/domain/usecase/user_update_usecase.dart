import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp/core/base_usecase.dart';
import 'package:gp/core/error/failure.dart';
import 'package:gp/user/domain/repository/base_user_repository.dart';

import '../entity/user_entity.dart';

class UserUpdateUseCase extends BaseUseCase<UserEntity, Parameter_update> {
  final BaseUserRepository baseUserRepository;

  UserUpdateUseCase(this.baseUserRepository);

  @override
  Future<Either<Failure, UserEntity>> call(Parameter_update parameter) async {
    return await baseUserRepository.userUpdate(
        first_name: parameter.first_name,
        last_name: parameter.last_name,
        personal_image: parameter.personal_image,
      id: parameter.id,
    );
  }
}

class Parameter_update extends Equatable {
  final String first_name;
  final String last_name;
  final int id;
  final File personal_image;

  Parameter_update(
      {required this.first_name,
      required this.last_name,
      required this.personal_image,
      required this.id
      });

  @override
  // TODO: implement props
  List<Object?> get props => [
        first_name,
        last_name,
        personal_image,
    id,
      ];
}
