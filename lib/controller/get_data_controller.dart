import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DataController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    fetchMeal();
  }

  RxBool isLoading = false.obs;
  List meal = [].obs;
  fetchMeal() async {
    isLoading(true);
    try {
      const apiUrl =
          "https://www.themealdb.com/api/json/v1/1/search.php?s=Arrabiata";
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        String jsonstr = response.body;
        var json = jsonDecode(jsonstr);
        meal = json["meals"];
        print(meal);
        update();
      } else {
        throw Exception('Failed to load meal');
      }
    } catch (error) {
      Get.back();

      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    } finally {
      isLoading(false);
    }
  }
}
