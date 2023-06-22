import 'package:flutter/material.dart';
import 'package:gp/core/base_usecase.dart';
import 'package:gp/map/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gp/test.dart';
import 'package:gp/trip/data/repository/trip_repository.dart';
import 'package:gp/trip/domain/respository/base_trip_repository.dart';
import 'package:gp/trip/domain/usecase/trip_create_usecase.dart';
import 'package:gp/trip/domain/usecase/trip_get_all_usecase.dart';
import 'package:gp/user/data/data_source/user_remote_data_source.dart';
import 'package:gp/user/data/repository/user_repository.dart';
import 'package:gp/user/domain/repository/base_user_repository.dart';
import 'package:gp/user/domain/usecase/user_get_all_usecase.dart';
import 'package:gp/user/domain/usecase/user_get_usecase.dart';
import 'package:gp/user/domain/usecase/user_login_usecase.dart';
import 'Register/LoginPage.dart';
import 'Register/SignupPage.dart';

void main() async {
  BaseUserRemoteDataSource baseUserRemoteDataSource=UserRemoteDataSource();
  BaseUserRepository baseUserRepository=UserRepository(baseUserRemoteDataSource);
  UserGetUseCase userGatAllUseCase=UserGetUseCase(baseUserRepository);
  await userGatAllUseCase(Parameter_User_Get(id:10 ));
  runApp(const MyApp());


  // BaseUserRemoteDataSource baseUserRemoteDataSource = UserRemoteDataSource();
  // BaseTripRepository baseTripRepository =
  //     TripRepository(baseUserRemoteDataSource);
  // TripGetAllUseCase tripGetAllUseCase = TripGetAllUseCase(baseTripRepository);
  // await tripGetAllUseCase(NoParameter());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: test(),
    );
  }
}
