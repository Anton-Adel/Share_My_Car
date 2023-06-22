import 'package:gp/trip/domain/entity/trip_entity.dart';

class TripModel extends TripEntity {
  TripModel({required super.id,
    required super.start_location,
    required super.end_location,
    required super.start_time,
    required super.end_time,
    required super.user_id, required super.user_cluster});

  factory TripModel.fromjson(Map<String, dynamic> json)
  =>
      TripModel(id: json['id'] ,
          start_location:  json['start_location'],
          end_location:  json['end_location'],
          start_time:  json['start_time'],
          end_time:  json['end_time'],
          user_id:  json['user_id'],
          user_cluster: json['user_cluster']
      );
}
