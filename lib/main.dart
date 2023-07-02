import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gp/trip/presentation/screens/Drivers/Home.dart';
import 'package:gp/user/presentation/controller/Register/register_cubit.dart';
import 'package:gp/user/presentation/screens/Register/CarInfo.dart';
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
import 'package:gp/user/presentation/screens/Register/Properties.dart';
import 'core/bloc_observer.dart';
import 'user/presentation/screens/Login/LoginPage.dart';
import 'user/presentation/screens/Register/SignupPage.dart';
import 'user/presentation/screens/Register/Verfication.dart';

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
  BaseUserRemoteDataSource baseUserRemoteDataSource = UserRemoteDataSource();
  BaseTripRepository baseTripRepository =
  TripRepository(baseUserRemoteDataSource);
  TripCreateUseCase tripCreateUseCase = TripCreateUseCase(baseTripRepository);
  await tripCreateUseCase(Parameter_trip_create(
      start_location: "start_address",
      end_location: "end_address",
      start_time: "2:40",
      user_id: "19",
      user_cluster: "1",
      start_date: "2023-2-2",
      shared_seats: "0",
      end_time: "0:0"
  ));
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(

      providers: [

        BlocProvider(create: (context)=>RegisterCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:LoginPage(),
      ),
    );
  }
}
