import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/core/error/failure.dart';
import 'package:gp/user/data/model/user_model.dart';
import 'package:gp/user/domain/usecase/user_login_usecase.dart';
import 'package:gp/user/presentation/controller/login/login_states.dart';

import '../../../data/data_source/user_remote_data_source.dart';
import '../../../data/repository/user_repository.dart';
import '../../../domain/repository/base_user_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  Failure ? error;

  void Login({required String email, required String password}) {
    emit(LoginLoadingState());
    BaseUserRemoteDataSource baseUserRemoteDataSource = UserRemoteDataSource();
    BaseUserRepository baseUserRepository =
        UserRepository(baseUserRemoteDataSource);
    UserLoginUseCase userLoginUseCase = UserLoginUseCase(baseUserRepository);
    userLoginUseCase(Parameter_login(email: email, password: password))
        .then((value) {
      value.fold((l) {
        print(l);
        error=l;
        emit(LoginErrorState());
      }, (r) {
        print(r.id);
        userModel = r as UserModel?;
        emit(LoginSuccessState());
      });
    }).catchError((e) {

      print(e);
      emit(LoginErrorState());
    });
  }
}
