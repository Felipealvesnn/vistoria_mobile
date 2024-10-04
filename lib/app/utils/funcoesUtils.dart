// ignore: file_names

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

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

// void pickImage(ImageSource source, {double percentage = 0.5}) async {
//     if (selectedImages.length >= 5) {
//       // Adicione uma lógica para mostrar uma mensagem ou alerta de limite de imagens
//       Get.snackbar('Limite atingido', 'Você só pode adicionar até 3 imagens.');
//       return;
//     }

//     final pickedFile = await ImagePicker().pickImage(source: source);
//     if (pickedFile != null) {
//       // Obter o nome da foto
//       String fileName = path.basename(pickedFile.path);

//       // Carregar a imagem como um Uint8List
//       File imageFile = File(pickedFile.path);
//       List<int> imageBytes = await imageFile.readAsBytes();

//       // Converter para Uint8List
//       Uint8List uint8List = Uint8List.fromList(imageBytes);

//       // Decodificar a imagem
//       img.Image originalImage = img.decodeImage(uint8List)!;

//       // Calcular a nova largura e altura com base na porcentagem
//       int newWidth = (originalImage.width * percentage).toInt();
//       int newHeight = (originalImage.height * percentage).toInt();

//       // Redimensionar a imagem mantendo a proporção com base na porcentagem
//       img.Image resizedImage =
//           img.copyResize(originalImage, width: newWidth, height: newHeight);

//       // Salvar a imagem redimensionada em um novo arquivo temporário
//       File resizedFile = File(pickedFile.path)
//         ..writeAsBytesSync(img.encodeJpg(resizedImage));

//       // Adiciona o arquivo redimensionado à lista de imagens selecionadas
//       selectedImages.add(resizedFile);

//       print('Nome da foto: $fileName'); // Exibe o nome da foto
//     }
//   }
