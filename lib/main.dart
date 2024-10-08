import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vistoria_mobile/app/utils/getstorages.dart';
import 'package:vistoria_mobile/app/utils/themaapp.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await inicializacaoGetStorage();

  runApp(
    GetMaterialApp(
      title: "Vistoria",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemaApp(),
    ),
  );
}
