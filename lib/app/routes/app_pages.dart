import 'package:get/get.dart';
import 'package:vistoria_mobile/app/modules/esqueci_a_senha/bindings/esqueci_a_senha_binding.dart';
import 'package:vistoria_mobile/app/modules/esqueci_a_senha/views/esqueci_a_senha_view.dart';
import 'package:vistoria_mobile/app/modules/login_page/bindings/login_page_binding.dart';
import 'package:vistoria_mobile/app/modules/login_page/views/login_page_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

import '../modules/vistoria/bindings/vistoria_binding.dart';
import '../modules/vistoria/views/vistoria_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ESQUECI_A_SENHA,
      page: () => EsqueciASenhaView(),
      binding: EsqueciASenhaBinding(),
    ),
    GetPage(
      name: _Paths.VISTORIA,
      page: () => const VistoriaView(),
      binding: VistoriaBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () =>  LoginPageView(),
      binding: LoginPageBinding(),
    ),
  ];
}
