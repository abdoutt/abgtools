import 'dart:convert';

import 'package:abgtools/model/article_model.dart';
import 'package:abgtools/utils/helpers/custom_exception.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:abgtools/constant.dart';

Future<dynamic?> getArticlePage(String filter, int page, int limit) async {
  var result = Uri.http(uri, 'abgTools/articlepage.php', {
    "search": filter,
    "page": "$page",
    "limit": "$limit",
  });
   var response = await http.get(result, headers: {
    "Authorization": "Bearer ${authService.env}",
    "Accept": "*/*",
  });
  if (response.statusCode == 200) {
    return articleModelFromJson(response.body);
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


Future<int> getArticleCount(String filter) async {
  var result = Uri.http(uri, 'abgTools/articlecount.php', {
    "search": filter
  });

 var response = await http.get(result, headers: {
    "Authorization": "Bearer ${authService.env}",
    "Accept": "*/*",
  });
  if (response.statusCode == 200) {
    return int.parse(response.body);
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


Future<int> postArticleApi(ArticleModel article) async {
  var url = Uri.http(uri, 'abgTools/newarticle.php');
  var bodyjson=jsonEncode(article);
    var response =
      await http.post(url, body: bodyjson, headers: {
    'Accept': '*/*',
    'Authorization': 'Bearer ${authService.env}',
  });
  if (response.statusCode == 200) {
    return int.parse(response.body);
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
Future<int> putArticleApi(ArticleModel article) async {
  var url = Uri.http(uri, 'abgTools/updatearticle.php');
      var jsonBody=jsonEncode(article);

       var response =
      await http.put(url,headers: {
       'Content-Type': 'application/json; charset=UTF-8',
    'Accept': '*/*',
     'Authorization': 'Bearer ${authService.env}',
  }, body: jsonBody);
  if (response.statusCode == 200) {
    return  int.parse(response.body);
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


Future<String> deleteArticleApi(int id) async {
  var url = Uri.http(uri, '/abgTools/deletearticle.php',{"id":"$id"});
 var response =
      await http.delete(url, headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*',
     'Authorization': 'Bearer ${authService.env}',
  });
  
  if (response.statusCode == 200) {
    return  response.body;
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