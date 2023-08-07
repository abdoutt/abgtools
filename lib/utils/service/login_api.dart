import 'dart:convert';
import 'package:abgtools/utils/helpers/custom_exception.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:abgtools/constant.dart';

Future<String?> login_api(String email, String password) async {
  var result = Uri.http(uri, 'abgTools/login.php', {
    "email": "$email",
    "password": "$password",
  });
  var response = await http.get(result, headers: {
        'Accept': '*/*',});
  if (response.statusCode == 200) {
    return response.body;
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
