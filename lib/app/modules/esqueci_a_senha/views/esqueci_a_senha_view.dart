import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vistoria_mobile/app/modules/login_page/views/header_widget.dart';
import 'package:vistoria_mobile/app/routes/app_pages.dart';
import 'package:vistoria_mobile/app/utils/theme_helper.dart';

import '../controllers/esqueci_a_senha_controller.dart';

class EsqueciASenhaView extends GetView<EsqueciASenhaController> {
  final double _headerHeight = Get.size.height / 3;
  @override
  EsqueciASenhaController controller = Get.find<EsqueciASenhaController>();
  final _chaveFormulario = GlobalKey<FormState>();

  EsqueciASenhaView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: _headerHeight,
                  child:
                      HeaderWidget(_headerHeight, true, Icons.password_rounded),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Esqueceu a senha?',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                              // textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Digite o endereço de e-mail associado à sua conta.',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                              // textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Enviaremos um código por e-mail para verificar sua autenticidade.',
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 15,
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Form(
                          key: _chaveFormulario,
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  decoration: ThemeHelper().textInputDecoration(
                                      "Email", "Informe seu email"),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Email não pode ser vazio";
                                    } else if (!RegExp(
                                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                        .hasMatch(val)) {
                                      return "Digite um endereço de e-mail válido";
                                    }
                                    controller.email.value = val;
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: ThemeHelper()
                                      .buttonBoxDecoration(context),
                                  child: Obx(
                                    () => ElevatedButton(
                                      //style: ThemeHelper().buttonStyle(),
                                      onPressed: controller
                                              .botaoEmailEnviado.value
                                          ? () async {
                                              if (_chaveFormulario.currentState!
                                                  .validate()) {
                                                await controller.resetPassword(
                                                    controller.email.value);

                                                /*    Navigator.pushReplacement(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => ForgotPasswordVerificationPage()),
                                                                            ); */
                                              }
                                            }
                                          : null,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            40, 10, 40, 10),
                                        child: controller
                                                .botaoEmailEnviado.value
                                            ? Text(
                                                "Enviar".toUpperCase(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : const CircularProgressIndicator(
                                                backgroundColor: Colors.white,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(text: "Lembrou sua senha? "),
                                    TextSpan(
                                      text: 'Login',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.offAllNamed(Routes.LOGIN);
                                          /* Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => LoginPage()),
                                          ); */
                                        },
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
