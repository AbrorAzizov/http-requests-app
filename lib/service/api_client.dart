import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/cat.dart';

class ApiClient {
  static const String baseUrl = 'https://caf87f3112f7c9c85796.free.beeceptor.com/api/users/';

  static Future<List<Cat>> getData() async {
    try {
      final uri = Uri.parse(baseUrl);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final cats = jsonList.map((e) => Cat.fromJson(e)).toList();
        return cats;
      } else {
        debugPrint('error StatusCode ${response.statusCode}');
        return [];
      }
    } catch (e) {
      debugPrint('error in getData: $e');
      return [];
    }
  }

  static Future<void> submitData(
      {required String title, required String url, required description}) async {
    try {
      final uri = Uri.parse(baseUrl);
      final body = {
        "url": url,
        "info": {
          "body": description,
          "title": title,
        }
      };

      final response = await http.post(uri,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      // checking
      if (response.statusCode == 201) {
        debugPrint("successful submition");
      } else {
        debugPrint("Error in statusCode: ${response.statusCode}");
      }
    } catch(e,stack){
      debugPrint('error in post $e \n $stack');
    }
  }

  static Future<void> deleteData(String id) async {
    // making url ready
    try{
      final url = "$baseUrl/$id";
      final uri = Uri.parse(url);
      //response
      final response = await http.delete(uri);

      if (response.statusCode == 200 || response.statusCode == 204) {
        debugPrint('deleted');
      } else {
        debugPrint('error ${response.statusCode}');
      }
    } catch (e,stack){
      debugPrint('delete error: $e \n $stack');
    }
  }

  static Future<void> editData({
    required String id,
    required String title,
    required String description,
    required String url,}) async {
    try {
      final url = Uri.parse("$baseUrl/$id");
      final body = {
        "url": url,
        "info": {
          "body": description,
          "title": title,
        }
      };
      final request = await http.put(url,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      if (request.statusCode == 200 || request.statusCode == 204){
        debugPrint('Edited successfully');
      }else{
        debugPrint('StatusCodeError ${request.statusCode}');
      }
    } catch (e,stack){
      debugPrint('error in editData: $e \n $stack');
    }
  }

}
