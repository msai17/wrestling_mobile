import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:wrestling_hub/core/constants/app_urls.dart';
import 'package:wrestling_hub/src/data/user/models/user.dart';
abstract class UserRemoteDataSource {

  factory UserRemoteDataSource(Dio dio) = _UserRemoteDataSource;
  Future<HttpResponse<String>> sendImageToServer(File image);
  Future<HttpResponse<User>> editProfileUser(Map<String,dynamic> data);
  Future<HttpResponse<bool>> deleteProfileUser(String token);
  Future<HttpResponse<User>> confirmSmsCode(Map<String,dynamic> data);
  Future<HttpResponse<User>> getUser(String token);
}

class _UserRemoteDataSource implements UserRemoteDataSource {

  final Dio client;

  _UserRemoteDataSource(this.client);

  @override
  Future<HttpResponse<String>> sendImageToServer(File image) async {
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path,filename: image.absolute.path)
    });
    final request = await client.post(
        AppUrls.sendImageServer,
        data: formData,
        options: Options(
            headers: {
              'Content-type': 'application/json',
              "Content-Type":"multipart/form-data"
            }
        )
    );
    final parsed = jsonDecode(request.data);
    print(parsed);
    String value = '';
    if(parsed['success']) {
      value = parsed['image'];
    }else{
      value = "error";
    }
    return HttpResponse(value, request);
  }

  @override
  Future<HttpResponse<User>> editProfileUser(Map<String, dynamic> data) async {
    final request = await client.get(AppUrls.editUser, data: data);
    final User value;
    final parsed = jsonDecode(request.data);
      try{
        if(parsed['user'] != null && parsed['is_set']) {
          value = User.fromJson(parsed['user']);
        }else{
          value = User();
        }
      }catch(e) {
        rethrow;
      }
    return HttpResponse(value, request);

  }

  @override
  Future<HttpResponse<bool>> deleteProfileUser(String token) async {
    final request = await client.get(AppUrls.deleteUser, data: jsonEncode({
      "token" : token
    }));
    final bool value;
    final parsed = jsonDecode(request.data);
    try{
      if(parsed['is_set']) {
        value = true;
      }else{
        value = false;
      }
    }catch(e) {
      rethrow;
    }
    return HttpResponse(value, request);
  }

  @override
  Future<HttpResponse<User>> confirmSmsCode(Map<String,dynamic> data) async {
    final request = await client.get(
        AppUrls.confirmSmsCode,
        data: json.encode(
            {
              "phone_number" : data['number'],
              "code" : data['code'],
            }
        ));
    final User value;
    final parsed = jsonDecode(request.data) ?? [];
    try{
      if(parsed['user'] != null) {
        value = User.fromJson(parsed['user']);
      }else{
        value = User();
      }
    }catch(e) {
      rethrow;
    }
    return HttpResponse(value, request);
  }

  @override
  Future<HttpResponse<User>> getUser(String token) async {
    final request = await client.get(
        AppUrls.getUser,
        data: json.encode(
            {
              "token" : token,
            }
        ));
    final User value;
    final parsed = jsonDecode(request.data) ?? [];
    try{
      if(parsed['user'] != null) {
        value = User.fromJson(parsed['user']);
      }else{
        value = User();
      }
    }catch(e) {
      rethrow;
    }
    return HttpResponse(value, request);
  }


}