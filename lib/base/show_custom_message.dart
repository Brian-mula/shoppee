import 'package:flutter/material.dart';
import 'package:get/get.dart';

void CustomSnackBar(String message,
    {bool isError = true, String title = "Error"}) {
  Get.snackbar(title, message,
      backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
}
