import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_app_assignment/screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'shared_pref.dart';

class AuthController extends GetxController {
  TextEditingController emailIDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    try {
      Map body = {
        "email": emailIDController.text.toString(),
        "password": passwordController.text.toString()
      };
      const loginUrl = 'https://reqres.in/api/login/';
      var response = await http.post(Uri.parse(loginUrl), body: body);

      //  print(response.body.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> value = json.decode(response.body);

        print(value);
        print("TOKEN" + value['token'].toString());
        SharedPrefrence().setToken(value['token'].toString());
        SharedPrefrence().setEmail(emailIDController.text.toString());

        emailIDController.clear();
        passwordController.clear();
        Get.off(HomeScreen());
      } else {
        throw jsonDecode(response.body)["error"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      Get.back();

      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }
}
