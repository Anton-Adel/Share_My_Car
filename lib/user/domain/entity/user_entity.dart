// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';



class UserEntity extends Equatable {

  // final String token;  // هناخده ك shared preference in login
  final int id;
  final String first_name;
  final String last_name;
  final String gender;
  final String age;
  final String id_number;
  final String personal_image;
  final String card_image;
  final String email;
  final String country;
  final String city;
  final String address;
  final String phone_number;
  final int have_car;
   String? car_model;
   String? car_color;
   String? car_plate_number;
   String? car_image;
   String? car_plate_image;
   String? car_license_image;
  final String trip_gender;
  final int smoke;
  final int trip_smoke;
  final int trip_music;
  final int trip_conditioner;
  final int trip_children;
  final int trip_pets;
  int? car_seats;
  String? cluster_number;

  UserEntity({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.gender,
    required this.age,
    required this.id_number,
    required this.personal_image,
    required this.card_image,
    required this.email,
    required this.country,
    required this.city,
    required this.address,
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
        id,
        first_name,
        last_name,
        gender,
        age,
        id_number,
        personal_image,
        card_image,
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
