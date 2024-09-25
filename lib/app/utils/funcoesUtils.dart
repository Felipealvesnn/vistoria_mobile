// ignore: file_names

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vistoria_mobile/app/data/models/Usuario.dart';
import 'package:vistoria_mobile/app/modules/home/controllers/home_controller.dart';
import 'package:vistoria_mobile/app/utils/getstorages.dart';




Usuario getUsuario() {
  Usuario usuarioLogado = Usuario();
  if (Storagers.boxUserLogado.read('user') != null) {
    final usu = Storagers.boxUserLogado.read('user');

    usuarioLogado = usu is Usuario ? usu : Usuario.fromJson(usu);
  } else {
    HomeController.logout();
  }
  return usuarioLogado;
}

void showSnackBarCuida(String title, String message, Color backgroundColor) {
  Get.snackbar(
    title,
    message,
    icon: Icon(Icons.error_outline, color: Colors.white),
    colorText: Colors.white,
    backgroundColor: backgroundColor,
    duration: Duration(seconds: 4),
    snackPosition: SnackPosition.TOP,
  );
}






