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
  VistoriaRepository vistoriaProvider = VistoriaRepository();

  // Variável observável para manter o valor selecionado do dropdown de tipo de veículo
  var veiculoTipoSelecionado = Rxn<VeiculoTipo>();

  // Lista de tipos permissionários filtrados
  var tipoPermissionariosFiltrados = <TipoPermissionario>[].obs;

  var vistorias = <Vistoria>[].obs; // Lista de vistorias observáveis
  var vistoriaMobileDTOs =
      <vistoriaMobileDTO>[].obs; // Lista de vistorias observáveis

  // Controle para travar o dropdown de tipo de veículo
  var isVeiculoTipoLocked = false.obs;

  final chassiController = TextEditingController();
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

  Future<void> fetchVistorias() async {
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
    var mockData = await vistoriaProvider.getvistoriaMobileDTO();
    vistoriaMobileDTOs
        .addAll(mockData); // Adiciona os dados na lista observável
  }

  Future<VeiculoDetran> getInforVeiculoDetran(String placa) async {
    try {
      limparCampos();
      isLoading.value = true;
      VeiculoDetran dadosVeiculo =
          await vistoriaProvider.getPlaca(placa: placa);
      esconderCampos();
      // Atualiza os controladores de texto com os dados retornados
      chassiController.text = dadosVeiculo.chassi ?? "";
      marcaModeloController.text = dadosVeiculo.marcaModelo ?? '';
      anoController.text = dadosVeiculo.anoFabricacao.toString() ?? '';
      corController.text = dadosVeiculo.cor ?? '';
      tipoVeiculoController.text = dadosVeiculo.tipo ?? '';
      kmController.text = '';

      // Atualiza o tipo de veículo selecionado
      var tipoEncontrado = vistoriaMobileDTOs.first.veiculoTipos?.firstWhere(
        (veiculoTipo) => veiculoTipo.veiTipDesc?.trim() == dadosVeiculo.tipo,
        orElse: () => VeiculoTipo(veiTipCod: 0, veiTipDesc: ''),
      );

      if (tipoEncontrado != null) {
        veiculoTipoSelecionado.value = tipoEncontrado;

        isVeiculoTipoLocked.value = true;

        // Filtra os tipos permissionários de acordo com o tipo de veículo
        filtrarTipoPermissionarios(dadosVeiculo.tipo!);
      } else {
        isVeiculoTipoLocked.value = false;
      }
      return dadosVeiculo;
    } catch (e) {
      esconderCampos();
      RecarregarDropwndoTipo.value = false;
      Get.snackbar('Erro', 'Erro ao buscar veículo');
      return VeiculoDetran();
    }
    finally{
      isLoading.value = false;
    }
  }

  void updateVisibility(String tipoPermissao, String tipoVeiculo) {
    showDadosVeiculo.value = true; // Mostrar sempre que tiver dados do veículo
    showCarAndMotoFields.value = true; // Mostrar sempre o CarAndMotoFields

    // Lógica para mostrar campos específicos
    if (tipoPermissao == "2" ||
        (tipoPermissao == "7" &&
            (tipoVeiculo == "MOTOCICLETA" || tipoVeiculo == "MOTONETA"))) {
      // Mostrar campos relacionados a motos
      showMotoFields.value = true;
      showCarFields.value = false;
    } else {
      // Mostrar campos relacionados a carros
      showCarFields.value = true;
      showMotoFields.value = false;
    }
  }

  void esconderCampos() {
    showDadosVeiculo.value = false;
    showCarAndMotoFields.value = false;
    showMotoFields.value = false;
    showCarFields.value = false;
    RecarregarDropwndoTipo.value = true;
  }

  void limparCampos() {
    RecarregarDropwndoTipo.value = false;
    chassiController.clear();
    marcaModeloController.clear();
    anoController.clear();
    corController.clear();
    tipoVeiculoController.clear();
    kmController.clear();
    selectedImage.value = null;
    camposMap.clear();
  }

  // Função para filtrar os tipos permissionários com base no tipo de veículo
  void filtrarTipoPermissionarios(String tipoVeiculo) {
    tipoPermissionariosFiltrados.value.clear(); // Limpa a lista

    switch (tipoVeiculo.trim()) {
      case 'CAMINHONETE':
      case 'CAMIONETA':
      case 'AUTOMOVEL':
        tipoPermissionariosFiltrados.value = [
          TipoPermissionario(codTipoPermissao: 1, descricao: 'TAXI'),
          TipoPermissionario(codTipoPermissao: 4, descricao: 'COLETIVO'),
          TipoPermissionario(codTipoPermissao: 5, descricao: 'ESCOLAR'),
          TipoPermissionario(codTipoPermissao: 6, descricao: 'ESPECIAIS'),
        ];
        break;
      case 'MOTOCICLETA':
      case 'MOTONETA':
        tipoPermissionariosFiltrados.value = [
          TipoPermissionario(codTipoPermissao: 2, descricao: 'MOTO - TAXI'),
          TipoPermissionario(codTipoPermissao: 7, descricao: 'ESPECIAIS'),
        ];
        break;
      case 'ONIBUS':
      case 'MICROONIBUS':
      case 'UTILITARIO':
        tipoPermissionariosFiltrados.value = [
          TipoPermissionario(codTipoPermissao: 4, descricao: 'COLETIVO'),
          TipoPermissionario(codTipoPermissao: 5, descricao: 'ESCOLAR'),
        ];
        break;
      case 'CAMINHAO':
      case 'REBOQUE':
      case 'SEMI-REBOQUE':
        tipoPermissionariosFiltrados.value = [
          TipoPermissionario(
            codTipoPermissao: 3,
            descricao: 'CARGA',
          ),
          TipoPermissionario(codTipoPermissao: 4, descricao: 'COLETIVO'),
          TipoPermissionario(codTipoPermissao: 7, descricao: 'ESPECIAIS'),
        ];
        break;
      default:
        tipoPermissionariosFiltrados
            .clear(); // Limpa se não houver correspondência
    }
  }

  final count = 0.obs;

  @override
  void onInit() async {
    await fetchVistorias();
    await fetchVistoriasMobileDTO();
    super.onInit();
  }

  void increment() => count.value++;
}
