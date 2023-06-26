import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/core/error/failure.dart';
import 'package:gp/core/global_models/user_post_model.dart';
import 'package:gp/user/data/model/user_model.dart';
import 'package:gp/user/domain/usecase/user_login_usecase.dart';
import 'package:gp/user/domain/usecase/user_register_usecase.dart';
import 'package:gp/user/presentation/controller/Register/register_state.dart';
import 'package:gp/user/presentation/controller/login/login_states.dart';

import '../../../data/data_source/user_remote_data_source.dart';
import '../../../data/repository/user_repository.dart';
import '../../../domain/repository/base_user_repository.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  UserPostModel? userPostModel;
  Failure ? error;
  String? gender =null;
  bool have_car = false;
  bool dont_have_car=false;
  bool check_car=false;

  TextEditingController dateInput = TextEditingController();
  TextEditingController personalImage = TextEditingController();
  TextEditingController idCardImage = TextEditingController();

  void get_date(value)
  {
    dateInput.text=value;
    emit(RegisterGetDate());
  }
  void change_gender(value)
  {
    gender=value;

    emit(RegisterChangeGender());
  }
  void check_have_car(value)
  {
    have_car=value;
    dont_have_car=!value;
    check_car=true;
    emit(RegisterHaveCar());
  }

  void personal_image_controller(value)
  {
    personalImage.text=value;
    emit(RegisterPersonalImageController());
  }
  void card_image_controller(value)
  {
    idCardImage.text=value;
    emit(RegisterCardImageController());

  }
  void Register()
  {
    emit(RegisterLoadingState());
    BaseUserRemoteDataSource baseUserRemoteDataSource = UserRemoteDataSource();
    BaseUserRepository baseUserRepository =
    UserRepository(baseUserRemoteDataSource);
    UserRegisterUseCase userRegisterUseCase = UserRegisterUseCase(baseUserRepository);
    userRegisterUseCase(Parameter_register(userPostModel: userPostModel!)).
    then((value) {
      value.fold((l) {
        emit(RegisterErrorState());
        error=l;
      }, (r) {
        emit(RegisterSuccessState());
        print(r);
      });

    }).catchError((e){
      emit(RegisterErrorState());
      print(e.toString());

    });
  }


}
