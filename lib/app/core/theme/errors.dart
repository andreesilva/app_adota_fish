import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> errors(dynamic error) async {
  if ((error.toString() == 'Connection failed') ||
      (error.toString() == 'Network is unreachable') ||
      (error.toString() == 'Connection timed out')) {
    ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(const SnackBar(
      content: Text('Sem conexão de rede'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 15),
    ));
  } else if (error.toString() == 'Connection refused') {
    //change(null, status: RxStatus.error('Falha no servidor'));
    ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(const SnackBar(
      content: Text('Falha no servidor'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 15),
    ));
    print(error.toString());
  } else {
    print(error.toString());

    //change(null, status: RxStatus.error(error.toString()));
  }
}
