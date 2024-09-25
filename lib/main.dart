import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vistoria_mobile/app/utils/getstorages.dart';
import 'package:vistoria_mobile/app/utils/themaapp.dart';

import 'app/routes/app_pages.dart';

void main() {
  inicializacaoGetStorage();
  runApp(
    GetMaterialApp(
      title: "Vistoria",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemaApp(),
    ),
  );
}


