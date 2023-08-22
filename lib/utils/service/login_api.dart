import 'dart:convert';
import 'package:abgtools/model/envrinementModel.dart';
import 'package:abgtools/utils/helpers/custom_exception.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:abgtools/constant.dart';

Future<EnvrinementModel?> login_api(String email, String password) async {
  var result = Uri.https(uri, 'abgTools/login.php', {
    "email": "$email",
    "password": "$password",
  });
  var response = await http.get(result, headers: {
        'Accept': '*/*',});
  if (response.statusCode == 200) {
   Map<String, dynamic> loginMap = json.decode(response.body);
    EnvrinementModel login = EnvrinementModel.fromMap(loginMap);
    return login;
  }
  if (response.statusCode == 400 || response.statusCode == 404) {
    throw NotifyException(response.body);
  }
  if (response.statusCode == 401) {
    throw UnauthorizedException();
  }

  //andled regulare error
  throw Exception(response.body);
}
