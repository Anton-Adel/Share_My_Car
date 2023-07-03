import 'dart:io';

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

import '../../../../core/shared_components/Constants.dart';
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

  //TextEditingController dateInput = TextEditingController();
  TextEditingController personalImage = TextEditingController();
  TextEditingController idCardImage = TextEditingController();
  TextEditingController carimage = TextEditingController();
  TextEditingController carplateimage = TextEditingController();
  TextEditingController carlicenseimage = TextEditingController();

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController CountryController = TextEditingController();
  TextEditingController CityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController idController = TextEditingController();
  File? PersonalImage;
  File? CardImage;


  // car info
  TextEditingController carmodel = TextEditingController();
  TextEditingController carcolor = TextEditingController();
  TextEditingController carplatenumber = TextEditingController();

  TextEditingController carseatnumber = TextEditingController();


  File? CarImage;
  File? paletImage;
  File? licenseImage;

  String? Q1;
  String? Q2;
  String? Q3;
  String? Q4;
  String? Q5;
  String? Q6;
  String? Q7;


  void get_question_value(value,index)
  {
    switch (index)
    {
      case 1:
        Q1=value;
        break;

      case 2:
        Q2=value;
        break;
      case 3:
        Q3=value;
        break;
      case 4:
        Q4=value;
        break;
      case 5:
        Q5=value;
        break;
      case 6:
        Q6=value;
        break;
      case 7:
        Q7=value;
        break;
    }
    emit(RegisterQuestion());
  }

  void send_code ()
  {
    try {
      emit(RegisterSendCodeLoadingState());
      BaseUserRemoteDataSource baseUserRemoteDataSource = UserRemoteDataSource();
      baseUserRemoteDataSource.postRequest("$PATH/sendcode", {
        "first_name": userPostModel!.first_name,
        "last_name": userPostModel!.last_name,
        "email": userPostModel!.email
      }).then((value) {
        Code = value['result']['code'];

        print("code is $Code");
        emit(RegisterSendCodeSuccessState());
      }).catchError((e) {
        print(e.toString());
        emit(RegisterSendCodeErrorState());
      });
    }
    catch(e)
    {
      print(e.toString());
      emit(RegisterSendCodeErrorState());
    }
  }
  // void get_date(value)
  // {
  //   dateInput.text=value;
  //   emit(RegisterGetDate());
  // }
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

  // void personal_image_controller(value,)
  // {
  //   personalImage.text=value;
  //   emit(RegisterPersonalImageController());
  // }
  // void card_image_controller(value)
  // {
  //   idCardImage.text=value;
  //   emit(RegisterCardImageController());
  //
  // }
  void display_image_name(value,TextEditingController controller)
  {
    controller.text=value;
    emit(RegisterImageController());
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
