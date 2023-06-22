import 'dart:convert';
import 'dart:io';

import 'package:gp/core/error/exception.dart';
import 'package:gp/core/network/error_message_model.dart';
import 'package:http/http.dart' as http;

abstract class BaseUserRemoteDataSource {
  getRequest(String uri);

  postRequest(String uri, Map data);

  postWithImage(String uri, Map data, File file1, {File? file2});

  updateRequest(String uri, Map data, File file1);
}

class UserRemoteDataSource extends BaseUserRemoteDataSource {
  @override
  postRequest(String uri, Map data) async {
    var response = await http.post(Uri.parse(uri), body: data,
        headers: {
          "Accept": "application/json",
          "Authorization":
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMTRlODFmZTcyMDA0YTNjZGM3Y2YzY2RlZGRjNGQ4YTZmODRiYTM0YmYzYTk5NmE5ZjQ4ZDQwNTEwYWVjMDFjNTY5NzAxNmM2ZmQzYTMxNmMiLCJpYXQiOjE2ODMzMTcxMDYuNzAyNDU3LCJuYmYiOjE2ODMzMTcxMDYuNzAyNDY2LCJleHAiOjE3MTQ5Mzk1MDYuNjUwMjgsInN1YiI6IjYiLCJzY29wZXMiOltdfQ.kn6Tu_8LsO6PI2A_tGghHznBgtMvPht-U0LLdFhI_C4mhYCQBdiNAaMrJP3ou3Ywdiv71WSy2rF0J-HKQDSUs9glwSqa636GMw1Q2dEwo4gwwzLBYR7CGcZBCNZxaLz5vSml6rtFJQSGC8-xogc2-zh4tiRvM5UBXPISoRsY3jSeOn7Sjh2hzhNWyatQJqcw9gU7bTv6ztZGNH9dhJvHcsXSz1URJbHbV8fcVdTVmPAL80tLKF-SB7I0lq8zCkdoXX3KHQbZ7CpPYq8yddZCc4vtTNC0zwx9jIA2k7TxUqJR3YcI5q2gbW2TDssWmgpB3ZjvzPKMHnmZmrIkt7kI--_X2hEMnagM25icWvVeA2ve8YPaaPXHJVLc8ucu1T-OLfIQQpqzVUf9IDcxoDFWWq8liZpq2kcJBQLeUo0Agq3VfOVyaBiNHIPQkw11j80cQBoJjDIADgxr7nGt5XN-yW7OuEJI_qILcLwrmVpBNlyEGT4ECF2Ujd-FMVjyz-wAo_ZfGTQLa2dowyo4mhyzP-1VlnMxftIjDg_0C5Ci67C7uptmcuhhn5thUqM2HhxBjMzGt3vb2ijggawkUmo8uvjoMaiUbhYe8mV6Gfa6lIWu_KI5CQ4zrRjLaaze0pLfOeqgJHfPh8vax3yg7R5x_rqi-mQiYdD0sO8vOyCSNS8"
        }
    );
    print(response.statusCode);
    print("Anton Adel");
    print(data);
    try {

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
    catch(e)
    {
      print("Eslam");
      print(e.toString());
    }
  }

  @override
  postWithImage(String uri, Map data, File file1, {File? file2}) async {
    var request = http.MultipartRequest("POST", Uri.parse(uri));
    var length = await file1.length();
    var stream = http.ByteStream(file1.openRead());

    // var length2 = await file2.length();
    // var stream2 = http.ByteStream(file2.openRead());

    var multiPartFile = http.MultipartFile('personal_image', stream, length,
        filename: Uri.file(file1.path).pathSegments.last);

    // var multiPartFile2 = http.MultipartFile('card_image', stream2, length2,
    //     filename: Uri.file(file2.path).pathSegments.last);

    request.files.add(multiPartFile);
   // request.files.add(multiPartFile2);

    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myResponse = await request.send();
    var response = await http.Response.fromStream(myResponse);
    if (myResponse.statusCode == 200) {
      print("done");
     // print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
     // print("error im request with image");
      var responseJson=jsonDecode(response.body);
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
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMDU5MTFlOTRlMDhlNzk4YjMxYmQ0NTIxY2MwNzVmOTU3NGY4M2Q0OTA0N2NiMjMwZWUxYmFjNTQyNDkwMjEwODRjNzM4OTg4ZTIyMDQ0NWYiLCJpYXQiOjE2ODc0NDI1NDcuMjMwNTg3LCJuYmYiOjE2ODc0NDI1NDcuMjMwNTg5LCJleHAiOjE3MTkwNjQ5NDcuMDc5NDQzLCJzdWIiOiIxMCIsInNjb3BlcyI6W119.oyY84uA-eEXSmkFoO-9rIg_4odgo8FnwbNCOQD8Bjf0dd1nr1ukPqVIwUTU3VAbov0p4t5zxq4luoCHT1tBIseyneE3mZVJ2Cu769bAMqeBzcqWV7Nr9mx61GrOYx64QxssOowvbl3QqlHsxwlGz8ClxhMuaEC1kEGDNjrhI_CuCT_4Q7fGWdkNLxpgPSUEvvG14Q50ZgvAWXMh4PZfh90YkK7Dsitp_LxVH3pcxBRCKkS8tydvSWfrUhX01ssJZ278PbeMWMWRYUiHFr9ghXXy4yjTiOEqIqTbLXw54SB5mufug0TtAmWrjBudAoXj8p3e3TfGT3Ta-JUk1unAi4LCx0kvWBgLW9Wfxj-5n0xNWvOzz04xOiI32XDMgKexsB4vCS27xCM3_GzRV_kxAmJpl8DOH9U-tm_q4o1qCGZ7HufTaAhB9_37Xhy15ZAo6kxMdMZVX1GVXQzHKwOcC1dcpp8iVUDdClNAZJVv5vnBx_yp1a_xwGrvBQNMRm9L4cNK4ghlj8Ay87qT0MJ39b0w3eqUVYPTuYUD5ju5q0rddQVzZJ1-iPH4067BSEp_CR3jd7aIIf0iEL0J_4jF6vQFuu-8suqm9jZyRN-d-WGPU9eU4q1v8bs4zFs5P0unC31QvyVcPXKDY9vJq5IsU-8OJVKX6knTR-mAwUoPokAk"
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
  updateRequest(String uri, Map data, File file1) async {
    var request = http.MultipartRequest("POST", Uri.parse(uri),);
    request.headers.addAll({
      "Accept": "application/json",
      "Authorization":
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMDU5MTFlOTRlMDhlNzk4YjMxYmQ0NTIxY2MwNzVmOTU3NGY4M2Q0OTA0N2NiMjMwZWUxYmFjNTQyNDkwMjEwODRjNzM4OTg4ZTIyMDQ0NWYiLCJpYXQiOjE2ODc0NDI1NDcuMjMwNTg3LCJuYmYiOjE2ODc0NDI1NDcuMjMwNTg5LCJleHAiOjE3MTkwNjQ5NDcuMDc5NDQzLCJzdWIiOiIxMCIsInNjb3BlcyI6W119.oyY84uA-eEXSmkFoO-9rIg_4odgo8FnwbNCOQD8Bjf0dd1nr1ukPqVIwUTU3VAbov0p4t5zxq4luoCHT1tBIseyneE3mZVJ2Cu769bAMqeBzcqWV7Nr9mx61GrOYx64QxssOowvbl3QqlHsxwlGz8ClxhMuaEC1kEGDNjrhI_CuCT_4Q7fGWdkNLxpgPSUEvvG14Q50ZgvAWXMh4PZfh90YkK7Dsitp_LxVH3pcxBRCKkS8tydvSWfrUhX01ssJZ278PbeMWMWRYUiHFr9ghXXy4yjTiOEqIqTbLXw54SB5mufug0TtAmWrjBudAoXj8p3e3TfGT3Ta-JUk1unAi4LCx0kvWBgLW9Wfxj-5n0xNWvOzz04xOiI32XDMgKexsB4vCS27xCM3_GzRV_kxAmJpl8DOH9U-tm_q4o1qCGZ7HufTaAhB9_37Xhy15ZAo6kxMdMZVX1GVXQzHKwOcC1dcpp8iVUDdClNAZJVv5vnBx_yp1a_xwGrvBQNMRm9L4cNK4ghlj8Ay87qT0MJ39b0w3eqUVYPTuYUD5ju5q0rddQVzZJ1-iPH4067BSEp_CR3jd7aIIf0iEL0J_4jF6vQFuu-8suqm9jZyRN-d-WGPU9eU4q1v8bs4zFs5P0unC31QvyVcPXKDY9vJq5IsU-8OJVKX6knTR-mAwUoPokAk"
    });
    var length = await file1.length();
    var stream = http.ByteStream(file1.openRead());

    // var length2 = await file2.length();
    // var stream2 = http.ByteStream(file2.openRead());

    var multiPartFile = http.MultipartFile('personal_image', stream, length,
        filename: Uri.file(file1.path).pathSegments.last);

    // var multiPartFile2 = http.MultipartFile('card_image', stream2, length2,
    //     filename: Uri.file(file2.path).pathSegments.last);

    request.files.add(multiPartFile);
    // request.files.add(multiPartFile2);

    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myResponse = await request.send();
    var response = await http.Response.fromStream(myResponse);
    if (myResponse.statusCode == 200) {
      print("done");
      // print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      // print("error im request with image");
      var responseJson=jsonDecode(response.body);
      // print(response.statusCode);
      print("error post with image ");
      throw ServerException(ErrorMessageModel.fromjson(responseJson));
    }
  }
}
