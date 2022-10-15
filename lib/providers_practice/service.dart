import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:new_shopapp/providers_practice/datamodel.dart';
import 'package:provider/provider.dart';


Future<DataModel?> getSinglePostData() async {
  DataModel? result;
  try {
    final response = await http.get(
      Uri.parse("https://nut-case.s3.amazonaws.com/coursessc.json"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },);
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = DataModel.fromJson(item);
    } else {
      print("error");
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}