import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:greenwaydispatch/loginAndSignup/login_model/LogIn.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:chopper/chopper.dart';
import 'package:greenwaydispatch/loginAndSignUp/login_api_service/login_api_service.dart';

class UserRepository {
  Future<String> authenticate({
    @required String phoneNumber,
    @required String password,
  }) async {
    dynamic user = await loginUser(phoneNumber, password);
    String token = jsonEncode(user);
    print(token);
    return token;
  }

  Future<String> getUsername() async {
    var box = Hive.box('token');
    var token = box.get('user');
    var res = jsonDecode(token);
    return res['phoneNumber'];
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    Box<Dispatch> getOrdersBox = Hive.box<Dispatch>('getDispatches');
    getOrdersBox.clear();
    var box = Hive.box('token');
    box.clear();
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    var box = Hive.box('token');
    box.put('user', token);
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    var box = Hive.box('token');
    var token = box.get('user');
    if (token != null) {
      return true;
    }
    return false;
  }
}

Future<dynamic> loginUser(String phoneNumber, String password) async {
//  var queryParams = {
//    'action': 'auth',
//    'username': phoneNumber,
//    'password': password,
//  };
  Map<String, dynamic> body = {
    "phone_number": phoneNumber,
    "password": password
  };

  final Response response = await LoginApiService.create().getResult(body);

  final Login _login = Login.fromJson(response.body);

  try {
    final Response response = await LoginApiService.create().getResult(body);

    final Login _login = Login.fromJson(response.body);

    return _login;
  } catch (e) {
    throw (e);
  }
}
//  var baseurl = Uri.https(
//      "script.google.com",
//      "Truncated",
//      queryParams);
//  var response = await http.get(
//    baseurl,
//    headers: {"Accept": "application/json"},
//  );

//  var data = await json.decode(response.body);
//  print('saving user using a web service ' + phoneNumber);
//  print(data['row']);
//  bool status = int.parse(_login['row']['code']) == 200 ? true : false;
//  // setState(() => user = data['row']['user']);
//  var res = data['row']['res'];
//  if (status) {
//    var user = _login;
//    print(user);
//    return user;
//  } else {
//    // print(res);
//    // print("throwinng ...");
//    throw (res);
//  }
//}
