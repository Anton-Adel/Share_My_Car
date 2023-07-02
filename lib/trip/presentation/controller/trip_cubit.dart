import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/trip/data/model/trip_model.dart';
import 'package:gp/trip/data/repository/trip_repository.dart';
import 'package:gp/trip/domain/respository/base_trip_repository.dart';
import 'package:gp/trip/domain/usecase/trip_create_usecase.dart';
import 'package:gp/trip/presentation/controller/trip_state.dart';
import 'package:gp/user/data/model/user_model.dart';

import '../../../core/error/failure.dart';
import '../../../user/data/data_source/user_remote_data_source.dart';

class TripCubit extends Cubit<TripStates> {
  TripCubit() : super(TripInitialState());

  static TripCubit get(context) => BlocProvider.of(context);
  TextEditingController startTimeController = TextEditingController();
  TextEditingController startDateController = TextEditingController();

  UserModel? userModel;
  TripModel? tripModel;
  Failure ? error;
  void display_date_time(value, TextEditingController controller) {
    controller.text = value;
    emit(TripDisplayDateTimeState());
  }

  void postBookTrip(
      {required String start_address,
      required end_address,
      required start_time,
      required start_date}) {
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
            user_cluster: userModel!.cluster_number.toString(),
      start_date: start_date,
      shared_seats: "0",
      end_time: "0:0"
    )).then((value) {
          value.fold(
                  (l)  {
                    error=l;
                    emit(TripBookTripErrorState());
                  }, (r) {
                    tripModel=r as TripModel?;
                    print(tripModel!.start_location);
                    emit(TripBookTripSuccessState());
          } );

    })
        .catchError((e) {
          print(e.toString());
      emit(TripBookTripErrorState());
    });
  }
}
