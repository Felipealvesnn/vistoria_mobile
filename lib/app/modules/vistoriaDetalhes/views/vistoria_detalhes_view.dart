import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/vistoria_detalhes_controller.dart';

class VistoriaDetalhesView extends GetView<VistoriaDetalhesController> {
  const VistoriaDetalhesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VistoriaDetalhesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'VistoriaDetalhesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
