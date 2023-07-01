import 'dart:convert';
import 'dart:io';

import 'package:gp/core/error/exception.dart';
import 'package:gp/core/network/error_message_model.dart';
import 'package:http/http.dart' as http;

abstract class BaseUserRemoteDataSource {
  getRequest(String uri);

  Future postRequest(String uri, Map data);

  postWithImage(String uri, Map data,  {required File personal_image,required File card_image,File? car_image,File? car_plate_image,File? car_license_image });

  updateRequest(String uri, Map data,{File? personal_image, File? card_image,File? car_image,File? car_plate_image,File? car_license_image });

  deleteRequest(String uri);
}

class UserRemoteDataSource extends BaseUserRemoteDataSource {
  @override
  postRequest(String uri, Map data) async {
    var response = await http.post(Uri.parse(uri), body: data,
        headers: {
          "Accept": "application/json",
          "Authorization":
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZDNhYTU2MWIyZDE2YTJmMmM3MjI4MTZlZjc3NGRmMWU0ZThkMjM2YmIyNGJjM2UyNmNkNzk5NDllMGI0YmY1NDIxZWU3OWIzZTU5NzZiMWMiLCJpYXQiOjE2ODc2MTU5NTAuMjIxOTYxLCJuYmYiOjE2ODc2MTU5NTAuMjIxOTY0LCJleHAiOjE3MTkyMzgzNTAuMjAxNTE3LCJzdWIiOiIxNiIsInNjb3BlcyI6W119.g7ApEy3hmp_aEp11DhPKzX231ARKXxMMJwLqHYmCmj7JVKT9wjNhvZFtIfNQR_T5DDr81rKLAb20Jqkc2ejRAzwPS3hEUBEzoo-13jg-4OnNycNNDiYDGEIqyGgWduVYvDPrqRMtOBNQ2pn0tFFnxs5mobNAcgG3YRiHszqRjqL5t7ftgUyQX_Xbcl_rwDmhUbg6bDdl8Aj0iivV5CtV88SzAFaWYBPJKGfo7VcC1xDlbqI2uwOx7fQ53QNWanU1ZY8XJ2R4_vmvT5HR7zrU_WpaWyOXkvTFY9_ZKP4PqZZiqRRD3b6MNXA6F07mouxK71uoRi7fZ3MFmdPb3rKNl3_3wke6eOMaKq8Rnb0E3BBxXcTtsskgx2fK2m5Ip5pnaY0uIb8Lhp1yN2hVgmepLSVeeZPPishojRa2xOfQ_yxIJXDJdbSQS3oOgxwVEA9PDYL2E66f65xvx4kt8oY8Ax_ht7WUuUToRglgMpw6w2afze5ljqJw_YTyN6M01X9C0on5Cmlk43tCRtQQB5W9LcyPbVwfb9Ifc9-C6and7QNopKNIihg6KdRNPlLs2sXCabz4HggByIZPtaNKJErARjI4IJugtPu_kNxvHJHyxfocffjTI_ylwjuiTFVB7bwqF5Bd7_BsgCigmvp5RNb-ZHIC8niA6_j_Sf_ejIoSWJE"
        }
    );
    print(response.statusCode);
    print("Anton Adel");
    print(data);


      if (response.statusCode == 200) {
        print("Esllllllllllllllllllllllllllllllllllllllllllllllllllllam");
        var responseJson = jsonDecode(response.body);
        print(responseJson);
        // return responseJson
        return responseJson;
      }
      else {

        var responseJson = jsonDecode(response.body);
        print(responseJson);
        print(response.statusCode);
        print("error Anton ");

        throw ServerException(ErrorMessageModel.fromjson(responseJson));
        //return responseJson;
      }


  }

  @override
  postWithImage(String uri, Map data, {required File personal_image,required File card_image,File? car_image,File? car_plate_image,File? car_license_image }) async {
    var request = http.MultipartRequest("POST", Uri.parse(uri));
    // personal image
    print("hiiiiiiiiiiiiiiiiii");
    var length = await personal_image.length();
    var stream = http.ByteStream(personal_image.openRead());
    var multiPartFile = http.MultipartFile('personal_image', stream, length,
        filename: Uri.file(personal_image.path).pathSegments.last);
    // card image
     var length2 = await card_image.length();
     var stream2 = http.ByteStream(card_image.openRead());
     var multiPartFile2 = http.MultipartFile('card_image', stream2, length2,
         filename: Uri.file(card_image.path).pathSegments.last);
    request.files.add(multiPartFile);
    request.files.add(multiPartFile2);
     // car image
    if(car_image!=null)
      {
        var length3 = await car_image.length();
        var stream3 = http.ByteStream(car_image.openRead());
        var multiPartFile3 = http.MultipartFile('car_image', stream3, length3,
            filename: Uri.file(car_image.path).pathSegments.last);
        request.files.add(multiPartFile3);
      }
    // car_plate_image

    if(car_plate_image!=null)
    {
      var length4 = await car_plate_image.length();
      var stream4 = http.ByteStream(car_plate_image.openRead());
      var multiPartFile4 = http.MultipartFile('car_plate_image', stream4, length4,
          filename: Uri.file(car_plate_image.path).pathSegments.last);
      request.files.add(multiPartFile4);
    }
    // car_license_image
    if(car_license_image!=null)
    {
      var length5 = await car_license_image.length();
      var stream5 = http.ByteStream(car_license_image.openRead());
      var multiPartFile5 = http.MultipartFile('car_license_image', stream5, length5,
          filename: Uri.file(car_license_image.path).pathSegments.last);
      request.files.add(multiPartFile5);
    }

    data.forEach((key, value) {
      if(value !=null)
      request.fields[key] = value;
    });
    var myResponse = await request.send();
    var response = await http.Response.fromStream(myResponse);
    if (myResponse.statusCode == 200) {
      print("post with image done");
     // print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
     // print("error im request with image");
      var responseJson=jsonDecode(response.body);
      print(responseJson);
     // print(response.statusCode);
      print("error post with image ");
      throw ServerException(ErrorMessageModel.fromjson(responseJson));
    }


  }

  @override
  getRequest(String uri) async {
    var response = await http.get(Uri.parse(uri), headers: {
      "Accept": "application/json",
      "Authorization":
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZDNhYTU2MWIyZDE2YTJmMmM3MjI4MTZlZjc3NGRmMWU0ZThkMjM2YmIyNGJjM2UyNmNkNzk5NDllMGI0YmY1NDIxZWU3OWIzZTU5NzZiMWMiLCJpYXQiOjE2ODc2MTU5NTAuMjIxOTYxLCJuYmYiOjE2ODc2MTU5NTAuMjIxOTY0LCJleHAiOjE3MTkyMzgzNTAuMjAxNTE3LCJzdWIiOiIxNiIsInNjb3BlcyI6W119.g7ApEy3hmp_aEp11DhPKzX231ARKXxMMJwLqHYmCmj7JVKT9wjNhvZFtIfNQR_T5DDr81rKLAb20Jqkc2ejRAzwPS3hEUBEzoo-13jg-4OnNycNNDiYDGEIqyGgWduVYvDPrqRMtOBNQ2pn0tFFnxs5mobNAcgG3YRiHszqRjqL5t7ftgUyQX_Xbcl_rwDmhUbg6bDdl8Aj0iivV5CtV88SzAFaWYBPJKGfo7VcC1xDlbqI2uwOx7fQ53QNWanU1ZY8XJ2R4_vmvT5HR7zrU_WpaWyOXkvTFY9_ZKP4PqZZiqRRD3b6MNXA6F07mouxK71uoRi7fZ3MFmdPb3rKNl3_3wke6eOMaKq8Rnb0E3BBxXcTtsskgx2fK2m5Ip5pnaY0uIb8Lhp1yN2hVgmepLSVeeZPPishojRa2xOfQ_yxIJXDJdbSQS3oOgxwVEA9PDYL2E66f65xvx4kt8oY8Ax_ht7WUuUToRglgMpw6w2afze5ljqJw_YTyN6M01X9C0on5Cmlk43tCRtQQB5W9LcyPbVwfb9Ifc9-C6and7QNopKNIihg6KdRNPlLs2sXCabz4HggByIZPtaNKJErARjI4IJugtPu_kNxvHJHyxfocffjTI_ylwjuiTFVB7bwqF5Bd7_BsgCigmvp5RNb-ZHIC8niA6_j_Sf_ejIoSWJE"
    });
    if (response.statusCode == 200) {
      print("get done");
     // print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      print("error get");
      var responseJson=jsonDecode(response.body);
      // print(response.statusCode);
      //print("error post with image ");
      throw ServerException(ErrorMessageModel.fromjson(responseJson));

    }
  }

  @override
  updateRequest(String uri, Map data, {File? personal_image, File? card_image,File? car_image,File? car_plate_image,File? car_license_image }) async {
    var request = http.MultipartRequest("POST", Uri.parse(uri),);
    request.headers.addAll({
      "Accept": "application/json",
      "Authorization":
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZDNhYTU2MWIyZDE2YTJmMmM3MjI4MTZlZjc3NGRmMWU0ZThkMjM2YmIyNGJjM2UyNmNkNzk5NDllMGI0YmY1NDIxZWU3OWIzZTU5NzZiMWMiLCJpYXQiOjE2ODc2MTU5NTAuMjIxOTYxLCJuYmYiOjE2ODc2MTU5NTAuMjIxOTY0LCJleHAiOjE3MTkyMzgzNTAuMjAxNTE3LCJzdWIiOiIxNiIsInNjb3BlcyI6W119.g7ApEy3hmp_aEp11DhPKzX231ARKXxMMJwLqHYmCmj7JVKT9wjNhvZFtIfNQR_T5DDr81rKLAb20Jqkc2ejRAzwPS3hEUBEzoo-13jg-4OnNycNNDiYDGEIqyGgWduVYvDPrqRMtOBNQ2pn0tFFnxs5mobNAcgG3YRiHszqRjqL5t7ftgUyQX_Xbcl_rwDmhUbg6bDdl8Aj0iivV5CtV88SzAFaWYBPJKGfo7VcC1xDlbqI2uwOx7fQ53QNWanU1ZY8XJ2R4_vmvT5HR7zrU_WpaWyOXkvTFY9_ZKP4PqZZiqRRD3b6MNXA6F07mouxK71uoRi7fZ3MFmdPb3rKNl3_3wke6eOMaKq8Rnb0E3BBxXcTtsskgx2fK2m5Ip5pnaY0uIb8Lhp1yN2hVgmepLSVeeZPPishojRa2xOfQ_yxIJXDJdbSQS3oOgxwVEA9PDYL2E66f65xvx4kt8oY8Ax_ht7WUuUToRglgMpw6w2afze5ljqJw_YTyN6M01X9C0on5Cmlk43tCRtQQB5W9LcyPbVwfb9Ifc9-C6and7QNopKNIihg6KdRNPlLs2sXCabz4HggByIZPtaNKJErARjI4IJugtPu_kNxvHJHyxfocffjTI_ylwjuiTFVB7bwqF5Bd7_BsgCigmvp5RNb-ZHIC8niA6_j_Sf_ejIoSWJE"
    });
    // personal image
    if(personal_image!=null) {
      var length = await personal_image.length();
      var stream = http.ByteStream(personal_image.openRead());
      var multiPartFile = http.MultipartFile('personal_image', stream, length,
          filename: Uri
              .file(personal_image.path)
              .pathSegments
              .last);
      request.files.add(multiPartFile);
    }
    // card image
    if(card_image!=null) {
      var length2 = await card_image.length();
      var stream2 = http.ByteStream(card_image.openRead());
      var multiPartFile2 = http.MultipartFile('card_image', stream2, length2,
          filename: Uri
              .file(card_image.path)
              .pathSegments
              .last);
      request.files.add(multiPartFile2);
    }


    // car image
    if(car_image!=null)
    {
      var length3 = await car_image.length();
      var stream3 = http.ByteStream(car_image.openRead());
      var multiPartFile3 = http.MultipartFile('car_image', stream3, length3,
          filename: Uri.file(car_image.path).pathSegments.last);
      request.files.add(multiPartFile3);
    }
    // car_plate_image

    if(car_plate_image!=null)
    {
      var length4 = await car_plate_image.length();
      var stream4 = http.ByteStream(car_plate_image.openRead());
      var multiPartFile4 = http.MultipartFile('car_plate_image', stream4, length4,
          filename: Uri.file(car_plate_image.path).pathSegments.last);
      request.files.add(multiPartFile4);
    }
    // car_license_image
    if(car_license_image!=null)
    {
      var length5 = await car_license_image.length();
      var stream5 = http.ByteStream(car_license_image.openRead());
      var multiPartFile5 = http.MultipartFile('car_license_image', stream5, length5,
          filename: Uri.file(car_license_image.path).pathSegments.last);
      request.files.add(multiPartFile5);
    }


    data.forEach((key, value) {
      if(value !=null)
      request.fields[key] = value;
    });
    var myResponse = await request.send();
    var response = await http.Response.fromStream(myResponse);
    if (myResponse.statusCode == 200) {
      print("update with image done");
      // print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      // print("error im request with image");
      var responseJson=jsonDecode(response.body);
      // print(response.statusCode);
      print("error post with image ");
      print(responseJson);
      throw ServerException(ErrorMessageModel.fromjson(responseJson));
    }
  }

  @override
  deleteRequest(String uri) async{
    var response=await http.delete(Uri.parse(uri),headers: {
      "Accept": "application/json",
      "Authorization":
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZDNhYTU2MWIyZDE2YTJmMmM3MjI4MTZlZjc3NGRmMWU0ZThkMjM2YmIyNGJjM2UyNmNkNzk5NDllMGI0YmY1NDIxZWU3OWIzZTU5NzZiMWMiLCJpYXQiOjE2ODc2MTU5NTAuMjIxOTYxLCJuYmYiOjE2ODc2MTU5NTAuMjIxOTY0LCJleHAiOjE3MTkyMzgzNTAuMjAxNTE3LCJzdWIiOiIxNiIsInNjb3BlcyI6W119.g7ApEy3hmp_aEp11DhPKzX231ARKXxMMJwLqHYmCmj7JVKT9wjNhvZFtIfNQR_T5DDr81rKLAb20Jqkc2ejRAzwPS3hEUBEzoo-13jg-4OnNycNNDiYDGEIqyGgWduVYvDPrqRMtOBNQ2pn0tFFnxs5mobNAcgG3YRiHszqRjqL5t7ftgUyQX_Xbcl_rwDmhUbg6bDdl8Aj0iivV5CtV88SzAFaWYBPJKGfo7VcC1xDlbqI2uwOx7fQ53QNWanU1ZY8XJ2R4_vmvT5HR7zrU_WpaWyOXkvTFY9_ZKP4PqZZiqRRD3b6MNXA6F07mouxK71uoRi7fZ3MFmdPb3rKNl3_3wke6eOMaKq8Rnb0E3BBxXcTtsskgx2fK2m5Ip5pnaY0uIb8Lhp1yN2hVgmepLSVeeZPPishojRa2xOfQ_yxIJXDJdbSQS3oOgxwVEA9PDYL2E66f65xvx4kt8oY8Ax_ht7WUuUToRglgMpw6w2afze5ljqJw_YTyN6M01X9C0on5Cmlk43tCRtQQB5W9LcyPbVwfb9Ifc9-C6and7QNopKNIihg6KdRNPlLs2sXCabz4HggByIZPtaNKJErARjI4IJugtPu_kNxvHJHyxfocffjTI_ylwjuiTFVB7bwqF5Bd7_BsgCigmvp5RNb-ZHIC8niA6_j_Sf_ejIoSWJE"
    });
    if (response.statusCode == 200) {
      print("delete done");
      // print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      print("error delete");
      var responseJson=jsonDecode(response.body);
      // print(response.statusCode);
      //print("error post with image ");
      throw ServerException(ErrorMessageModel.fromjson(responseJson));

    }
  }
}
