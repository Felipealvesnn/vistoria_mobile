import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/data/models/TipoPermissionario%20.dart';
import 'package:vistoria_mobile/app/data/models/VeiculoDetran.dart';
import 'package:vistoria_mobile/app/data/models/VeiculoTipo.dart';
import 'package:vistoria_mobile/app/data/models/vistoriaMobileDTO.dart';
import 'package:vistoria_mobile/app/data/repository/vistoria_repository.dart';
import '../../../data/models/vistoria.dart';

class VistoriaController extends GetxController {
  final VistoriaRepository vistoriaProvider = VistoriaRepository();

  // Observables and Controllers
  var veiculoTipoSelecionado = Rxn<VeiculoTipo>();
  var tipoPermissionariosFiltrados = <TipoPermissionario>[].obs;
  var vistorias = <Vistoria>[].obs;
  var vistoriaMobileDTOs = <vistoriaMobileDTO>[].obs;

  // Lock for VeiculoTipo dropdown
  var isVeiculoTipoLocked = false.obs;

  final chassiController = TextEditingController();
  final placaController = TextEditingController();
  final marcaModeloController = TextEditingController();
  final anoController = TextEditingController();
  final corController = TextEditingController();
  final tipoVeiculoController = TextEditingController();
  final kmController = TextEditingController();

  var isLoading = false.obs;
  var showDadosVeiculo = false.obs;
  var showMotoFields = false.obs;
  var showCarFields = false.obs;
  var showCarAndMotoFields = false.obs;
  var RecarregarDropwndoTipo = false.obs;

  var selectedImages = RxList<File>([]);

  final ImagePicker _picker = ImagePicker();

  var camposMap = <dynamic, dynamic>{}.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchVistorias();
    await fetchVistoriasMobileDTO();
  }

  // Updates a specific field dynamically in the map
  void updateCampo(String campo, dynamic valor) {
    camposMap[campo] = valor;
  }

  // Generates the JSON from the map
  Future<Map<dynamic, dynamic>> generateJson() async {
    // falta [agenteCod]
    //[statusVistoria]

    List<Map<String, dynamic>> fotosVistoria = [];

    // Itera sobre as imagens selecionadas, transforma em base64 e adiciona ao JSON
    for (var image in selectedImages) {
      // Lê o arquivo como bytes
      List<int> imageBytes = await image.readAsBytes();
      // Converte para base64
      String base64Image = base64Encode(imageBytes);

      fotosVistoria.add({"NomeFoto": base64Image});
    }

    var vistoria = {
      "vistoriaId": 0,
      "idPermissionario": 0,
      "codTipoPemissao": camposMap["codTipoPermissao"],
      "dataVistoria": "0001-01-01T00:00:00",
      "placa": camposMap["placa"],
      "chassi": camposMap["chassi"],
      "marcaModelo": camposMap["marcaModelo"],
      "ano": camposMap["ano"],
      "cor": camposMap["cor"],
      "tipo": camposMap["tipo"],
      "km": camposMap["km"],
      ...camposMap, // Mapa dinâmico contendo os campos e observações
      "FotosVistoria": fotosVistoria // Adiciona as fotos ao JSON
    };
    // await vistoriaProvider.postVistoria(vistoria);
    return vistoria;
  }

  // Fetch vistorias data
  Future<void> fetchVistorias() async {
    try {
      final mockData = await vistoriaProvider.getVistorias();
      vistorias.addAll(mockData);
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao buscar vistorias');
    }
  }

  // Fetch vistoriasMobileDTO data
  Future<void> fetchVistoriasMobileDTO() async {
    try {
      final mockData = await vistoriaProvider.getvistoriaMobileDTO();
      vistoriaMobileDTOs.addAll(mockData);
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao buscar tipos de veículos');
    }
  }

  // Select an image from the device
  void pickImage(ImageSource source) async {
    if (selectedImages.length >= 3) {
      // Adicione uma lógica para mostrar uma mensagem ou alerta de limite de imagens
      Get.snackbar('Limite atingido', 'Você só pode adicionar até 3 imagens.');
      return;
    }
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      selectedImages.add(File(pickedFile.path));
    }
  }

  // Fetch vehicle information from Detran
  Future<VeiculoDetran> getInforVeiculoDetran(String placa) async {
    try {
      limparCampos();
      isLoading.value = true;
      VeiculoDetran dadosVeiculo =
          await vistoriaProvider.getPlaca(placa: placa);

      updateFieldsWithVeiculoDetran(dadosVeiculo);
      filterVeiculoTipo(dadosVeiculo.tipo);

      return dadosVeiculo;
    } catch (e) {
      hideAllFields();
      RecarregarDropwndoTipo.value = false;
      Get.snackbar('Erro', 'Erro ao buscar veículo');
      return VeiculoDetran();
    } finally {
      isLoading.value = false;
    }
  }

  // Update visibility of fields based on conditions
  void updateVisibility(String tipoPermissao, String tipoVeiculo) {
    showDadosVeiculo.value = true; // Always show vehicle data
    showCarAndMotoFields.value = true;

    if (tipoPermissao == "2" ||
        (tipoPermissao == "7" &&
            (tipoVeiculo == "MOTOCICLETA" || tipoVeiculo == "MOTONETA"))) {
      showMotoFields.value = true;
      showCarFields.value = false;
    } else {
      showCarFields.value = true;
      showMotoFields.value = false;
    }
  }

  // Filter permission types based on vehicle type
  void filtrarTipoPermissionarios(String tipoVeiculo) {
    // Define um mapa para associar tipos de veículos aos tipos de permissionários
    final Map<String, List<String>> tipoVeiculoMap = {
      'CAMINHONETE': ['TAXI', 'COLETIVO', 'ESCOLAR', 'ESPECIAIS'],
      'CAMIONETA': ['TAXI', 'COLETIVO', 'ESCOLAR', 'ESPECIAIS'],
      'AUTOMOVEL': ['TAXI', 'COLETIVO', 'ESCOLAR', 'ESPECIAIS'],
      'MOTOCICLETA': ['MOTO - TAXI', 'ESPECIAIS'],
      'MOTONETA': ['MOTO - TAXI', 'ESPECIAIS'],
      'ONIBUS': ['COLETIVO', 'ESCOLAR'],
      'MICROONIBUS': ['COLETIVO', 'ESCOLAR'],
      'UTILITARIO': ['COLETIVO', 'ESCOLAR'],
      'CAMINHAO': ['CARGA', 'COLETIVO', 'ESPECIAIS'],
      'REBOQUE': ['CARGA', 'COLETIVO', 'ESPECIAIS'],
      'SEMI-REBOQUE': ['CARGA', 'COLETIVO', 'ESPECIAIS']
    };

    // Remove espaços e busca os tipos de permissionários associados ao tipo de veículo
    final trimmedTipoVeiculo = tipoVeiculo.trim();
    final tiposPermissionarios = tipoVeiculoMap[trimmedTipoVeiculo];

    // Atualiza a lista de tipos permissionários com base no tipo de veículo encontrado
    if (tiposPermissionarios != null) {
      addPermissionarioToList(tiposPermissionarios);
    } else {
      tipoPermissionariosFiltrados
          .clear(); // Limpa a lista se não encontrar correspondência
    }
  }

  // Helper to add permissionários to list based on descriptions
  void addPermissionarioToList(List<String> descriptions) {
    tipoPermissionariosFiltrados.value = descriptions.map((descricao) {
      return TipoPermissionario(
        codTipoPermissao: getCodTipoPermissaoByDescricao(descricao),
        descricao: descricao,
      );
    }).toList();
  }

  // Helper to find codTipoPermissao by description
  int? getCodTipoPermissaoByDescricao(String descricao) {
    for (var dto in vistoriaMobileDTOs) {
      for (var tipoPermissionario in dto.tipoPermissionario ?? []) {
        if (tipoPermissionario.descricao == descricao) {
          return tipoPermissionario.codTipoPermissao;
        }
      }
    }
    return null;
  }

  // Updates fields with VeiculoDetran data
  void updateFieldsWithVeiculoDetran(VeiculoDetran dadosVeiculo) {
    chassiController.text = dadosVeiculo.chassi ?? "";
    marcaModeloController.text = dadosVeiculo.marcaModelo ?? '';
    anoController.text = dadosVeiculo.anoFabricacao?.toString() ?? '';
    corController.text = dadosVeiculo.cor ?? '';
    tipoVeiculoController.text = dadosVeiculo.tipo ?? '';
    kmController.text = '';

    updateCampo("chassi", chassiController.text);
    updateCampo("marcaModelo", marcaModeloController.text);
    updateCampo("ano", anoController.text);
    updateCampo("cor", corController.text);
    updateCampo("tipo", tipoVeiculoController.text);
    updateCampo("km", kmController.text);
  }

  // Filter VeiculoTipo and update lock status
  void filterVeiculoTipo(String? tipoVeiculo) {
    if (tipoVeiculo != null) {
      final tipoEncontrado = vistoriaMobileDTOs.first.veiculoTipos?.firstWhere(
        (veiculoTipo) => veiculoTipo.veiTipDesc?.trim() == tipoVeiculo,
        orElse: () => VeiculoTipo(veiTipCod: 0, veiTipDesc: ''),
      );

      veiculoTipoSelecionado.value = tipoEncontrado;
      isVeiculoTipoLocked.value = tipoEncontrado != null;

      filtrarTipoPermissionarios(tipoVeiculo);
    }
  }

  // Clears and hides all form fields
  void hideAllFields() {
    showDadosVeiculo.value = false;
    showCarAndMotoFields.value = false;
    showMotoFields.value = false;
    showCarFields.value = false;
    RecarregarDropwndoTipo.value = true;
  }

  // Resets all form fields and controllers
  void limparCampos() {
    hideAllFields();
    chassiController.clear();
    marcaModeloController.clear();
    anoController.clear();
    corController.clear();
    tipoVeiculoController.clear();
    kmController.clear();
    selectedImages.clear();
    camposMap.clear();
  }
}
