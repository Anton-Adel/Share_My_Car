import 'package:gp/user/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
   UserModel({

    required super.id,
    required super.first_name,
    required super.last_name,
    required super.gender,
    required super.age,
    required super.id_number,
    required super.personal_image,
    required super.card_image,
    required super.email,
    required super.country,
    required super.city,
    required super.address,
    required super.phone_number,
    required super.have_car,
     super.car_model,
     super.car_color,
     super.car_plate_number,
     super.car_image,
     super.car_plate_image,
     super.car_license_image,
    required super.trip_gender,
    required super.smoke,
    required super.trip_smoke,
    required super.trip_music,
    required super.trip_conditioner,
    required super.trip_children,
    required super.trip_pets,
     super.car_seats,
     super.cluster_number});

  factory UserModel.fromjson(Map<String, dynamic> json)
  =>
      UserModel(

          id: json['id'],
          first_name: json['first_name'],
          last_name: json['last_name'],
          gender: json['gender'],
          age: json['age'],
          id_number: json['id_number'],
          personal_image: json['personal_image'],
          card_image: json['card_image'],
          email: json['email'],
          country: json['country'],
          city: json['city'],
          address: json['address'],
          phone_number: json['phone_number'],
          have_car: json['have_car'],
          car_model: json['car_model'],
          car_color: json['car_color'],
          car_plate_number: json['car_plate_number'],
          car_image: json['car_image'],
          car_plate_image: json['car_plate_image'],
          car_license_image: json['car_license_image'],
          trip_gender: json['trip_gender'],
          smoke: json['smoke'],
          trip_smoke: json['trip_smoke'],
          trip_music: json['trip_music'],
          trip_conditioner: json['trip_conditioner'],
          trip_children: json['trip_children'],
          trip_pets: json['trip_pets'],
        car_seats: json['car_seats'],
        cluster_number: json['cluster_number']
      );


}
