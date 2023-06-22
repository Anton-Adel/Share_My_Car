// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';



class TripEntity extends Equatable {

  // final String token;  // هناخده ك shared preference in login
  final int id;
  final String start_location;
  final String end_location;
  final String start_time;
  String? end_time;
  final int user_id;
  final String user_cluster;


   TripEntity({
    required this.id,
    required this.start_location,
    required this.end_location,
    required this.start_time,
     this.end_time,
    required this.user_id,
     required this.user_cluster
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [
        id,
        start_location,
        end_location,
        start_time,
        end_time,
        user_id,
        user_cluster
      ];


}
