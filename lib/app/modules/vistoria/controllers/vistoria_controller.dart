import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/data/models/vistoriaMobileDTO.dart';

import 'package:vistoria_mobile/app/data/repository/vistoria_repository.dart';

import '../../../data/models/vistoria.dart';

class VistoriaController extends GetxController {
  //TODO: Implement VistoriaController
  VistoriaRepository vistoriaProvider = VistoriaRepository();
  var selectedImage =
      Rx<File?>(null); // Variável reativa para armazenar a imagem selecionada
  final ImagePicker _picker = ImagePicker();

  var camposMap = <dynamic, dynamic>{}.obs;

  // Função para atualizar dinamicamente os valores
  void updateCampo(String campo, dynamic valor) {
    camposMap[campo] = valor;
  }

  // Função para adicionar campos dinamicamente (usado ao inicializar o widget)
  void addCamposDinamicamente(List<Map<dynamic, String>> campos) {
    for (var campo in campos) {
      // Se o campo ainda não estiver no mapa, adicione com valor inicial
      if (!camposMap.containsKey(campo['campo'])) {
        camposMap[campo['campo']] =
            false; // Inicializa com false (para checkboxes)
      }
      if (!camposMap.containsKey(campo['obs'])) {
        camposMap[campo['obs']] =
            ''; // Inicializa com string vazia (para observações)
      }
    }
  }

  // Função para gerar o JSON a partir do mapa
  Map<String, dynamic> generateJson() {
    var camposMapd = {
      "vistorium": {
        "vistoriaId": 0,
        "idPermissionario": 0,
        "codTipoPemissao": null,
        "dataVistoria": "0001-01-01T00:00:00",
        "placa": camposMap["placa"],
        "chassi": camposMap["chassi"],
        "marcaModelo": camposMap["marcaModelo"],
        "ano": camposMap["ano"],
        "cor": camposMap["cor"],
        "tipo": camposMap["tipo"],
        "km": camposMap["km"],
        ...camposMap // Mapa dinâmico contendo os campos e observações
      }
    };
    return camposMapd;
  }

  var vistorias = <Vistoria>[].obs; // Lista de vistorias observáveis
  var vistoriaMobileDTOs =
      <vistoriaMobileDTO>[].obs; // Lista de vistorias observáveis

  Future<void> fetchVistorias() async {
    // Suponha que aqui você está pegando os dados de uma API ou serviço
    var mockData = await vistoriaProvider.getVistorias();

    vistorias.addAll(mockData); // Adiciona os dados na lista observável
  }

  // Função para escolher imagem
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> fetchVistoriasMobileDTO() async {
    // Suponha que aqui você está pegando os dados de uma API ou serviço
    var mockData = await vistoriaProvider.getvistoriaMobileDTO();

    vistoriaMobileDTOs
        .addAll(mockData); // Adiciona os dados na lista observável
  }

  final count = 0.obs;
  @override
  void onInit() async {
    await fetchVistorias();
    await fetchVistoriasMobileDTO();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
