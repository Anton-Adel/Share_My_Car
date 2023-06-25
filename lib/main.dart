import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gp/Drivers/Home.dart';
import 'package:gp/Register/CarInfo.dart';
import 'package:gp/core/base_usecase.dart';
import 'package:gp/map/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gp/test.dart';
import 'package:gp/trip/data/repository/trip_repository.dart';
import 'package:gp/trip/domain/respository/base_trip_repository.dart';
import 'package:gp/trip/domain/usecase/trip_create_usecase.dart';
import 'package:gp/trip/domain/usecase/trip_delete_usecase.dart';
import 'package:gp/trip/domain/usecase/trip_get_all_usecase.dart';
import 'package:gp/trip/domain/usecase/trip_update_usecase.dart';
import 'package:gp/user/data/data_source/user_remote_data_source.dart';
import 'package:gp/user/data/repository/user_repository.dart';
import 'package:gp/user/domain/repository/base_user_repository.dart';
import 'package:gp/user/domain/usecase/user_get_all_usecase.dart';
import 'package:gp/user/domain/usecase/user_get_usecase.dart';
import 'package:gp/user/domain/usecase/user_login_usecase.dart';
import 'core/bloc_observer.dart';
import 'user/presentation/screens/LoginPage.dart';
import 'Register/SignupPage.dart';
import 'Register/Verfication.dart';

void main() async {
  // BaseUserRemoteDataSource baseUserRemoteDataSource=UserRemoteDataSource();
  // BaseUserRepository baseUserRepository=UserRepository(baseUserRemoteDataSource);
  // UserGetUseCase userGatAllUseCase=UserGetUseCase(baseUserRepository);
  // await userGatAllUseCase(Parameter_User_Get(id:16 ));
  /*BaseUserRemoteDataSource baseUserRemoteDataSource = UserRemoteDataSource();
  BaseTripRepository baseTripRepository =
      TripRepository(baseUserRemoteDataSource);
  TripDeleteUseCase tripDeleteUseCase = TripDeleteUseCase(baseTripRepository);
  await tripDeleteUseCase(Parameter_delete(
      id: 3
  ));*/
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:LoginPage(),
    );
  }
}
