import 'dart:convert';
import 'package:flutter_scale/models/news_model.dart';
import 'package:flutter_scale/utils/constants.dart';
import 'package:flutter_scale/utils/utility.dart';
import 'package:http/http.dart' as http;

class CallAPI {
// set Header
  _setHeader() =>
      {'Content-type': 'application/json', 'Accept': 'application/json'};

  //Login API Method
  loginAPI(data) async {
    //check network
    if (await Utility.checkNetwork() == '') {
      return http.Response(
          jsonEncode({'status': 'error', 'message': 'No Internet Connection'}),
          400);
    } else {
      return await http.post(
        Uri.parse(baseURLAPI + 'login'),
        body: jsonEncode(data),
        headers: _setHeader(),
      );
    }
  }

  //Read Last News API Method
  Future<List<NewsModel>?> getLastNews() async {
    if (await Utility.checkNetwork() == '') {
      return null;
    } else {
      final respones = await http.get(
        Uri.parse(baseURLAPI + 'lastnews'),
        headers: _setHeader(),
      );

      if (respones.body != null) {
        return newsModelFromJson(respones.body);
      } else {
        return null;
      }
    }
  }
}
