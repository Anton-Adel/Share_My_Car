import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/core/base_usecase.dart';
import 'package:gp/trip/data/model/trip_model.dart';
import 'package:gp/trip/data/repository/trip_repository.dart';
import 'package:gp/trip/domain/entity/trip_entity.dart';
import 'package:gp/trip/domain/respository/base_trip_repository.dart';
import 'package:gp/trip/domain/usecase/trip_create_usecase.dart';
import 'package:gp/trip/domain/usecase/trip_get_all_usecase.dart';
import 'package:gp/trip/presentation/controller/trip_state.dart';
import 'package:gp/user/data/model/user_model.dart';
import 'package:gp/user/data/repository/user_repository.dart';
import 'package:gp/user/domain/entity/user_entity.dart';
import 'package:gp/user/domain/repository/base_user_repository.dart';
import 'package:gp/user/domain/usecase/user_get_all_usecase.dart';
import 'package:gp/user/domain/usecase/user_get_usecase.dart';

import '../../../core/error/failure.dart';
import '../../../user/data/data_source/user_remote_data_source.dart';

class TripCubit extends Cubit<TripStates> {
  TripCubit() : super(TripInitialState());

  static TripCubit get(context) => BlocProvider.of(context);
  TextEditingController startTimeController = TextEditingController();
  TextEditingController startDateController = TextEditingController();

  TextEditingController startTimeShareCarController = TextEditingController();
  TextEditingController startDateShareCarController = TextEditingController();

  TextEditingController startAddressController = TextEditingController();
  TextEditingController endAddressController = TextEditingController();

  //share car
  TextEditingController startAddressShareCarController =
      TextEditingController();
  TextEditingController endAddressShareCarController = TextEditingController();

  UserModel? userModel;
  TripModel? tripModel;
  Failure? error;
  int? seats = 0;

  int? to_location;

  int? from_register;

  int? initial_index_of_tap = 0;

  void FromRegister(value) {
    from_register = value;
    to_location = 0;
    emit(TripToLocationState());
  }

  void ToLocation(value) {
    from_register = 0;
    to_location = value;
    if (value == 0) {
      initial_index_of_tap = 0;
    } else {
      initial_index_of_tap = 1;
    }
    emit(TripToLocationState());
  }

  Color c1 = Colors.white,
      c2 = Colors.white,
      c3 = Colors.white,
      c4 = Colors.white;

  void display_date_time(value, TextEditingController controller) {
    controller.text = value;
    // if (startAddressController.text != null) {
    //   startAddressShareCarController.text = startAddressController.text;
    // }
    // if (endAddressController.text != null) {
    //   endAddressShareCarController.text = endAddressController.text;
    // }
    emit(TripDisplayDateTimeState());
  }

  void set_seats(int value, Color c) {
    seats = value;
    switch (value) {
      case 1:
        c1 = Color(0xFF442268);
        c2 = Colors.white;
        c3 = Colors.white;
        c4 = Colors.white;
        break;
      case 2:
        c2 = Color(0xFF442268);
        c1 = Colors.white;

        c3 = Colors.white;
        c4 = Colors.white;

        break;
      case 3:
        c3 = Color(0xFF442268);
        c1 = Colors.white;
        c2 = Colors.white;

        c4 = Colors.white;
        break;
      case 4:
        c4 = Color(0xFF442268);
        c1 = Colors.white;
        c2 = Colors.white;
        c3 = Colors.white;

        break;
    }

    emit(TripGetNumberOfSeatsState());
  }

  Future<void> get_user_from_login(UserModel userModel) async {
    this.userModel = userModel;
  }

  void getUserInHome({required int id}) {
    emit(TripGetUserLoadingState());
    BaseUserRemoteDataSource baseUserRemoteDataSource = UserRemoteDataSource();
    BaseUserRepository baseUserRepository =
        UserRepository(baseUserRemoteDataSource);
    UserGetUseCase userGetUseCase = UserGetUseCase(baseUserRepository);
    userGetUseCase(Parameter_User_Get(id: id)).then((value) {
      value.fold((l) {
        error = l;
        emit(TripGetUserErrorState());
      }, (r) {
        print("getUserInHome");
        userModel = r as UserModel?;
        print(userModel!.email);
        emit(TripGetUserSuccessState());
      });
    }).catchError((e) {
      print(e.toString());
      emit(TripGetUserErrorState());
    });
  }

  void postBookTrip({
    required String start_address,
    required String end_address,
    required String start_time,
    required String start_date,
  }) {
    print(start_address);
    print(end_address);
    print(start_time);
    print(start_date);
    emit(TripBookTripLoadingState());

    BaseUserRemoteDataSource baseUserRemoteDataSource = UserRemoteDataSource();
    BaseTripRepository baseTripRepository =
        TripRepository(baseUserRemoteDataSource);
    TripCreateUseCase tripCreateUseCase = TripCreateUseCase(baseTripRepository);
    tripCreateUseCase(Parameter_trip_create(
            start_location: start_address,
            end_location: end_address,
            start_time: start_time,
            user_id: userModel!.id.toString(),
            user_cluster: "1",
            start_date: start_date,
            shared_seats: "${seats ?? 0}",
            end_time: "0:0"))
        .then((value) {
      value.fold((l) {
        error = l;
        print(error);
        emit(TripBookTripErrorState());
      }, (r) {
        tripModel = r as TripModel?;
        print(tripModel!.start_location);
        emit(TripBookTripSuccessState());
      });
    }).catchError((e) {
      print(e.toString());
      emit(TripBookTripErrorState());
    });
  }

  List<TripEntity> tripList = [];

  void getAllUsers() {
    emit(TripGetAllTripsLoadingState());
    BaseUserRemoteDataSource baseUserRemoteDataSource = UserRemoteDataSource();
    BaseTripRepository baseTripRepository =
        TripRepository(baseUserRemoteDataSource);
    TripGetAllUseCase tripGetAllUseCase = TripGetAllUseCase(baseTripRepository);
    tripGetAllUseCase(NoParameter()).then((value) {
      value.fold((l) {
        error = l;
        emit(TripGetAllTripsErrorState());
      }, (r) {
        r.forEach((element) {
          if (element.shared_seats != 0 &&
              element.user_cluster == userModel!.cluster_number &&
              element.start_date == tripModel!.start_date &&
              element.end_location == tripModel!.end_location) {
          // هنا هنعمل جيل لكل يوزر ونحطه في ليس
          List<String> element_time = element.start_time.split(" ");
          List<String> user_time = tripModel!.start_time.split(" ");
          element_time = element_time[0].split(":");
          user_time = user_time[0].split(":");
          int sub=int.parse(element_time[0]) * 60 +
              int.parse(element_time[1]) -
              (int.parse(user_time[0]) * 60 + int.parse(user_time[1]));
          if(sub>=-20&&sub<=20)
            {

            }

           }
        });
        emit(TripGetAllTripsSuccessState());
      });
    }).catchError((e) {
      print(e.toString());
      emit(TripGetAllTripsErrorState());
    });
  }
}
