import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable
{

  // final bool success;
  final String message;
  //final int status_code;

 const ErrorMessageModel( this.message);

  factory ErrorMessageModel.fromjson(Map<String,dynamic>json)=>
      ErrorMessageModel(  json["message"]);

  @override
  // TODO: implement props
  List<Object?> get props => [message];

}