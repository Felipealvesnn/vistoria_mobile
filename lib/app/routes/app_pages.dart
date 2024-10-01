import 'package:get/get.dart';

import '../modules/WELCOME/bindings/welcome_binding.dart';
import '../modules/WELCOME/views/welcome_view.dart';
import '../modules/configuracoes/bindings/configuracoes_binding.dart';
import '../modules/configuracoes/views/configuracoes_view.dart';
import '../modules/esqueci_a_senha/bindings/esqueci_a_senha_binding.dart';
import '../modules/esqueci_a_senha/views/esqueci_a_senha_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login_page/bindings/login_page_binding.dart';
import '../modules/login_page/views/login_page_view.dart';
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
      page: () => LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.CONFIGURACOES,
      page: () => const ConfiguracoesView(),
      binding: ConfiguracoesBinding(),
    ),
  ];
}
