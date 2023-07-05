import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gp/core/base_usecase.dart';
import 'package:gp/core/shared_components/shared.dart';
import 'package:gp/trip/data/model/trip_model.dart';
import 'package:gp/trip/data/repository/trip_repository.dart';
import 'package:gp/trip/domain/entity/trip_entity.dart';
import 'package:gp/trip/domain/respository/base_trip_repository.dart';
import 'package:gp/trip/domain/usecase/trip_create_usecase.dart';
import 'package:gp/trip/domain/usecase/trip_get_all_usecase.dart';
import 'package:gp/trip/domain/usecase/trip_update_usecase.dart';
import 'package:gp/trip/domain/usecase/trip_user_get_usecase.dart';
import 'package:gp/trip/presentation/controller/trip_state.dart';
import 'package:gp/user/data/model/user_model.dart';
import 'package:gp/user/data/repository/user_repository.dart';
import 'package:gp/user/domain/entity/user_entity.dart';
import 'package:gp/user/domain/repository/base_user_repository.dart';
import 'package:gp/user/domain/usecase/user_get_all_usecase.dart';
import 'package:gp/user/domain/usecase/user_get_usecase.dart';

import '../../../core/error/failure.dart';
import '../../../core/shared_components/Constants.dart';
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

  Future getUserInHome({required int id}) async {
    emit(TripGetUserLoadingState());
    BaseUserRemoteDataSource baseUserRemoteDataSource = UserRemoteDataSource();
    BaseUserRepository baseUserRepository =
    UserRepository(baseUserRemoteDataSource);
    UserGetUseCase userGetUseCase = UserGetUseCase(baseUserRepository);
    var response = await userGetUseCase(Parameter_User_Get(id: id));
    return response;
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
        // from user
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
        print("Anton");
        getAllUsers();
        emit(TripBookTripSuccessState());
      });
    }).catchError((e) {
      print(e.toString());
      emit(TripBookTripErrorState());
    });
  }

  Future<LatLng> _getLatLngFromAddress_trip(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        Location location = locations.first;
        LatLng latLng = LatLng(location.latitude, location.longitude);
        return latLng;
      }
    } catch (e) {
      print(e);
    }
    return LatLng(0, 0);
  }

  List<TripEntity> tripList = [];
  List<UserEntity> userList = [];

  int triplistCount = -1;

  void getAllUsers() async {
    tripList = [];
    userList = [];
    emit(TripGetAllTripsLoadingState());
    BaseUserRemoteDataSource baseUserRemoteDataSource = UserRemoteDataSource();
    BaseTripRepository baseTripRepository =
    TripRepository(baseUserRemoteDataSource);
    TripGetAllUseCase tripGetAllUseCase = TripGetAllUseCase(baseTripRepository);
    tripGetAllUseCase(NoParameter()).then((value) {
      value.fold((l) {
        error = l;

        print(error);
        emit(TripGetAllTripsErrorState());
      }, (r) async {
        triplistCount = r.length;
        r.forEach((element) async {
          triplistCount = triplistCount - 1;

          if (element.shared_seats != 0 &&
              element.user_cluster == "1" &&
              element.start_date == tripModel!.start_date &&
              element.end_location == tripModel!.end_location &&
              element.user_id != userModel!.id) {
            // هنا هنعمل جيل لكل يوزر ونحطه في ليس
            List<String> element_time = element.start_time.split(" ");
            List<String> user_time = tripModel!.start_time.split(" ");
            if (element_time[1] == user_time[1]) {
              element_time = element_time[0].split(":");
              user_time = user_time[0].split(":");
              int sub = (int.parse(element_time[0]) * 60 +
                  int.parse(element_time[1])) -
                  (int.parse(user_time[0]) * 60 + int.parse(user_time[1]));
              if (sub >= -20 && sub <= 20) {
                var element_lang_lat =
                await _getLatLngFromAddress_trip(element.start_location);
                var user_lang_lat =
                await _getLatLngFromAddress_trip(tripModel!.start_location);
                double distanceInMeters = await Geolocator.distanceBetween(
                    element_lang_lat.latitude,
                    element_lang_lat.longitude,
                    user_lang_lat.latitude,
                    user_lang_lat.longitude);
                if (distanceInMeters <= 1000) {
                  tripList.add(element);
                  getUserInHome(id: element.user_id).then((value) {
                    value.fold((l) {
                      error = l;
                      print("error");
                      print(l);
                      emit(TripGetUserErrorState());
                      if (triplistCount == 0) {
                        print(userList.length);
                        emit(TripGetAllTripsSuccessState());
                      }
                    }, (r) {
                      userList.add(r);
                      print(userList);
                      emit(TripGetUserSuccessState());
                      if (triplistCount == 0) {
                        print(userList.length);
                        emit(TripGetAllTripsSuccessState());
                      }
                    });
                  }).catchError((error) {
                    print(error.toString());
                    emit(TripGetUserErrorState());
                    if (triplistCount == 0) {
                      print(userList.length);
                      emit(TripGetAllTripsSuccessState());
                    }
                  });
                }
              }
            }
          }
        });
        // if (triplistCount == 0) {
        //   print(userList.length);
        //   emit(TripGetAllTripsSuccessState());
        // }
      });
    }).catchError((e) {
      print(e.toString());
      emit(TripGetAllTripsErrorState());
    });
  }

  void updateTrip({required String start_address,
    required String end_address,
    required String start_time,
    required String start_date,
    required String user_id,
    required String user_cluster,
    required String id,
    required String Shared_seats,
    required String email,
    required String phone,
    required String f_name,
    required String l_name}) {
    emit(TripUpdateTripsLoadingState());
    BaseUserRemoteDataSource baseUserRemoteDataSource = UserRemoteDataSource();
    BaseTripRepository baseTripRepository =
    TripRepository(baseUserRemoteDataSource);
    TripUpdateUseCase tripUpdateUseCase = TripUpdateUseCase(baseTripRepository);
    tripUpdateUseCase(Parameter_trip_update(
        start_location: start_address,
        end_location: end_address,
        start_time: start_time,
        user_id: user_id,
        user_cluster: user_cluster,
        id: id,
        start_date: start_date,
        shared_seats: Shared_seats))
        .then((value) {
      value.fold((l) {
        error = l;
        print(error);
        emit(TripUpdateTripsErrorState());
      }, (r) {
        startAddressController.text = "";
        endAddressController.text = "";
        startTimeController.text = "";
        startDateController.text = "";
        tripList = [];
        userList = [];
        send_confirm(
            email: email, f_name: f_name, l_name: l_name, phone: phone);
        emit(TripUpdateTripsSuccessState());
      });
    }).catchError((e) {
      print(e.toString());
      emit(TripUpdateTripsErrorState());
    });
  }

  void send_confirm({required String email,
    required String phone,
    required String f_name,
    required String l_name}) {
    try {
      emit(TripSendConfirmLoadingState());
      BaseUserRemoteDataSource baseUserRemoteDataSource =
      UserRemoteDataSource();
      baseUserRemoteDataSource.postRequest("$PATH/sendconfirm", {
        "first_name": f_name,
        "last_name": l_name,
        "email": email,
        'phone': phone
      }).then((value) {
        Code = value['result']['code'];

        print("code is $Code");
        emit(TripSendConfirmSuccessState());
      }).catchError((e) {
        print(e.toString());
        emit(TripSendConfirmErrorState());
      });
    } catch (e) {
      print(e.toString());
      emit(TripSendConfirmErrorState());
    }
  }

  List<TripEntity> user_trips_list = [];

  void getUserTrips({required int user_id}) {
    emit(TripGetUserTripsLoadingState());
    user_trips_list = [];
    BaseUserRemoteDataSource baseUserRemoteDataSource = UserRemoteDataSource();
    BaseTripRepository baseTripRepository =
    TripRepository(baseUserRemoteDataSource);
    TripUserGetUseCase tripUserGetUseCase =
    TripUserGetUseCase(baseTripRepository);
    tripUserGetUseCase(Parameter_user_get_all_tirps(user_id: user_id))
        .then((value) {
      value.fold((l) {
        error = l;
        print(error);
        emit(TripGetUserTripsErrorState());
      }, (r) {
        user_trips_list = r;
        print(user_trips_list);
        emit(TripGetUserTripsSuccessState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(TripGetUserTripsErrorState());
    });
  }


  List<UserEntity> raidersList = [];
  List<UserEntity> driversList = [];

  void getAllUsersRidersDrivers({required int user_type}) {
    raidersList=[];
    driversList=[];
    emit(TripGetAllUsersRaidersDriversLoadingState());
    BaseUserRemoteDataSource baseUserRemoteDataSource = UserRemoteDataSource();
    BaseUserRepository baseUserRepository = UserRepository(
        baseUserRemoteDataSource);
    UserGetAllUseCase userGetAllUseCase = UserGetAllUseCase(baseUserRepository);
    userGetAllUseCase(NoParameter())
        .then((value) {
          value.fold((l) {
            error=l;
            emit(TripGetAllUsersRaidersDriversErrorState());
          },
                  (r){
            r.forEach((element) {
              //print(element);
              if(element.have_car==0)
                {
                  raidersList.add(element);
                }
              else
                {
                  driversList.add(element);
                }
            });
            if(user_type==0) {
              print("Eslam");
              print(raidersList.length);
              emit(TripGetAllUsersRaidersSuccessState());
            }
            else
              {
                print(driversList.length);
                emit(TripGetAllUsersDriversSuccessState());
              }
          });
    })
        .catchError((error) {
          print(error);
          emit(TripGetAllUsersRaidersDriversErrorState());
    });
  }
}
