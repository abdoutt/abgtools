import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:abgtools/model/article_model.dart';
import 'package:abgtools/utils/helpers/custom_exception.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:abgtools/constant.dart';
import 'package:http_parser/http_parser.dart';

Future<dynamic?> getArticlePage(String filter, int page, int limit) async {
  var result = Uri.https(uri, 'abgTools/articlepage.php', {
    "search": filter,
    "page": "$page",
    "limit": "$limit",
  });
  var response = await http.get(result,
      headers: {"Authorization": "Bearer ${authService.env!.token}"});
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
  var result = Uri.https(uri, 'abgTools/articlecount.php', {"search": filter});

  var response = await http.get(result,
      headers: {"Authorization": "Bearer ${authService.env!.token}"});
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

Future<String> getImage(String id) async {
  var result = Uri.https(uri, 'abgTools/getImage.php', {"id": id});

  var response = await http.get(result,
      headers: {"Authorization": "Bearer ${authService.env!.token}"});
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

Future<int> postArticleApi(ArticleModel article) async {
  var url = Uri.https(uri, 'abgTools/newarticle.php');
  var bodyjson = jsonEncode(article);
  var response = await http.post(url, body: bodyjson, headers: {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': '*/*',
    'Authorization': 'Bearer ${authService.env!.token}',
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
  var url = Uri.https(uri, 'abgTools/updatearticle.php');
  var jsonBody = jsonEncode(article);

  var response = await http.put(url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'Authorization': 'Bearer ${authService.env!.token}',
      },
      body: jsonBody);
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

Future<String> deleteArticleApi(int id) async {
  var url = Uri.https(uri, '/abgTools/deletearticle.php', {"id": "$id"});
  var response = await http.delete(url, headers: {
    'Authorization': 'Bearer ${authService.env!.token}',
  });

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

Future<String> importArticleApi(List<ArticleModel> article) async {
  var url = Uri.https(uri, '/abgTools/importarticle.php');
  var response = await http.post(url, body: jsonEncode(article), headers: {
    'Content-Type': 'application/json',
    'Accept': '*/*',
    'Authorization': 'Bearer ${authService.env!.token}',
  });
  if (response.statusCode == 200) {
    return response.body;
  }
  if (response.statusCode == 400 || response.statusCode == 404) {
    print("NotifyException : ${response.body}");
    throw NotifyException(response.body);
  }
  if (response.statusCode == 401) {
    throw UnauthorizedException();
  }

  //andled regulare error
  throw Exception(response.body);
}

Future<String> uploadImageApi(List<int> source, int id, String namefile) async {
  var url = Uri.https(uri, '/abgTools/uploadimage.php', {"id": id.toString()});

  var request = http.MultipartRequest("POST", url);
  request.headers.addAll({
    'Content-Type': 'multipart/form-data',
    'Accept': '*/*',
    'Authorization': 'Bearer ${authService.env!.token}',
  });

  request.files.add(http.MultipartFile.fromBytes('file', source,
      contentType: MediaType('application', 'octet-stream'),
      filename: '$namefile'));
  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
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
