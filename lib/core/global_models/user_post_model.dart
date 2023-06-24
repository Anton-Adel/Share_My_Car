// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:equatable/equatable.dart';



class UserPostModel extends Equatable {

  // final String token;  // هناخده ك shared preference in login
  final String first_name;
  final String last_name;
  final String gender;
  final String age;
  final String id_number;
   File? personal_image;
   File? card_image;
  final String email;
  final String password;
  final String country;
  final String city;
  final String address;
  final String phone_number;
  final String have_car;
  String? car_model;
  String? car_color;
  String? car_plate_number;
  File? car_image;
  File? car_plate_image;
  File? car_license_image;
  final String trip_gender;
  final String smoke;
  final String trip_smoke;
  final String trip_music;
  final String trip_conditioner;
  final String trip_children;
  final String trip_pets;
  String? car_seats;
  String? cluster_number;

  UserPostModel({
    required this.first_name,
    required this.last_name,
    required this.gender,
    required this.age,
    required this.id_number,
     this.personal_image,
     this.card_image,
    required this.email,
    required this.country,
    required this.city,
    required this.address,
    required this.password,
    required this.phone_number,
    required this.have_car,
    this.car_model,
    this.car_color,
    this.car_plate_number,
    this.car_image,
    this.car_plate_image,
    this.car_license_image,
    required this.trip_gender,
    required this.smoke,
    required this.trip_smoke,
    required this.trip_music,
    required this.trip_conditioner,
    required this.trip_children,
    required this.trip_pets,
    this.car_seats,
    this.cluster_number
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [
        first_name,
        last_name,
        gender,
        age,
        id_number,
        personal_image,
        card_image,
        password,
        email,
        country,
        city,
        address,
        phone_number,
        have_car,
        car_model,
        car_color,
        car_plate_number,
        car_image,
        car_plate_image,
        car_license_image,
        trip_gender,
        smoke,
        trip_smoke,
        trip_music,
        trip_conditioner,
        trip_children,
        trip_pets,
        car_seats,
        cluster_number,
      ];


}
