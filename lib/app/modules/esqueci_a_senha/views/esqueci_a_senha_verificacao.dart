import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vistoria_mobile/app/modules/login_page/views/header_widget.dart';
import 'package:vistoria_mobile/app/utils/theme_helper.dart';

import '../controllers/esqueci_a_senha_controller.dart';

class EsqueciASenhaVerificacaoView extends GetView<EsqueciASenhaController> {
  final double _headerHeight = Get.size.height / 3;
  final _chaveFormulario = GlobalKey<FormState>();
  @override
  EsqueciASenhaController controller = Get.find<EsqueciASenhaController>();
  final TextEditingController pinController = TextEditingController();

  EsqueciASenhaVerificacaoView({super.key});
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
                child: HeaderWidget(
                    _headerHeight, true, Icons.privacy_tip_outlined),
              ),
              SafeArea(
                child: Container(
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
                              'Verificação',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                              // textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Digite o código de verificação que acabamos de enviar para seu endereço de e-mail.',
                              style: TextStyle(
                                  // fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                              // textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      Form(
                        key: _chaveFormulario,
                        child: Column(
                          children: <Widget>[
                            PinCodeTextField(
                                pinTheme: PinTheme(
                                  activeColor: Colors.black,
                                  inactiveColor: Colors.grey,
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(10),
                                  fieldHeight: 50,
                                  fieldWidth: 40,
                                  activeFillColor: Colors.white,
                                ),
                                controller: pinController,
                                enableActiveFill: false,
                                obscureText: false,
                                animationType: AnimationType.fade,
                                keyboardType: TextInputType.number,
                                length: 4,
                                appContext: context,
                                onChanged: (value) {
                                  debugPrint(value);
                                  //print(length.length);
                                  if (value.length == 4) {
                                    controller.pinSuccess.value = true;
                                  }
                                }),
                            /*  OTPTextField(
                              length: 4,
                              width: 300,
                              fieldWidth: 50,
                              style: TextStyle(fontSize: 30),
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldStyle: FieldStyle.box,
                              onCompleted: (pin) {
                                controller.pinSuccess.value = true;
                                print(pin);
                              },
                            ), */
                            const SizedBox(height: 50.0),
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Se você não recebeu um código! ",
                                    style: TextStyle(
                                      color: Colors.black38,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Reenviar',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        await controller.reenviar();
                                      },
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40.0),
                            Obx(() => Container(
                                  decoration: controller.pinSuccess.value
                                      ? ThemeHelper()
                                          .buttonBoxDecoration(context)
                                      : ThemeHelper().buttonBoxDecoration(
                                          context, "#AAAAAA", "#757575"),
                                  child: ElevatedButton(
                                    style: ThemeHelper().buttonStyle(),
                                    onPressed: controller.pinSuccess.value
                                        ? () {
                                            controller.verificarCodigo(
                                                pinController.text);
                                            //Get.offAndToNamed(Routes.USUARIO);
                                            /*  Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                                ProfilePage()),
                                                    (Route<dynamic> route) =>
                                                        false); */
                                          }
                                        : null,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 10, 40, 10),
                                      child: Text(
                                        "Confirmar".toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
