import 'package:get/get.dart';
import 'package:vistoria_mobile/app/data/models/vistoria.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:vistoria_mobile/app/modules/printPage/components/TestPrintVistoria.dart';
import 'package:vistoria_mobile/app/utils/getstorages.dart';

class PrintPageController extends GetxController {
  // Impressora selecionada pelo usuário
  final selectedPrinter = Rx<String?>(null);
  // Lista de impressoras disponíveis
  final availablePrinters = <String>[].obs;
  // Estados observáveis
  final isConnectedToPrinter = false.obs;
  final isConnecting = false.obs;
  final isLoading = true.obs;
  final isPrinting = false.obs;
  late Vistoria vistoria;
  final bluetooth = BlueThermalPrinter.instance;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? selectedDevice;

  @override
  void onInit() {
    super.onInit();
    vistoria = Get.arguments as Vistoria;
    initialize();
  }

  Future<void> initialize() async {
    isLoading.value = true;
    await scanForPrinters();
    await checkBluetoothStatus();
    isLoading.value = false;
  }

  Future<void> checkBluetoothStatus() async {
    try {
      bool? isConnected = await bluetooth.isConnected;
      if (isConnected == true) {
        await handleConnectedDevice();
      } else {
        await attemptReconnect();
      }
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao verificar status do Bluetooth');
      print('Erro ao verificar status do Bluetooth: $e');
    }
  }

  Future<void> handleConnectedDevice() async {
    try {
      var printerName = Storagers.boxInicial.read('printer');
      if (printerName != null) {
        selectedPrinter.value = printerName;
        selectedDevice = _devices
            .firstWhere((device) => device.name == selectedPrinter.value);
        isConnectedToPrinter.value = true;
      }
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao recuperar impressora conectada');
      print('Erro ao manusear dispositivos conectados: $e');
    }
  }

  Future<void> attemptReconnect() async {
    if (selectedDevice != null) {
      try {
        await connectToDevice(selectedDevice!);
      } catch (e) {
        isConnectedToPrinter.value = false;
        Get.snackbar('Erro', 'Não foi possível reconectar à impressora');
      }
    } else {
      Get.snackbar('Impressora', 'Nenhuma impressora conectada');
    }
  }

  Future<void> scanForPrinters() async {
    try {
      _devices = await bluetooth.getBondedDevices();
      availablePrinters.value = _devices
          .where((device) => device.name != null)
          .map((device) => device.name!)
          .toList();

      if (availablePrinters.isEmpty) {
        selectedPrinter.value = null;
      }

      bluetooth.onStateChanged().listen((state) async {
        switch (state) {
          case BlueThermalPrinter.CONNECTED:
            isConnectedToPrinter.value = true;
            break;
          case BlueThermalPrinter.DISCONNECTED:
            isConnectedToPrinter.value = false;
            //Future.delayed(const Duration(seconds: 1), () {
              selectedPrinter.value = null;
              // availablePrinters.value = [];
            //});
            break;
          case BlueThermalPrinter.STATE_TURNING_OFF:
            isConnectedToPrinter.value = false;
            availablePrinters.value = [];
            selectedPrinter.value = null;
            break;
          case BlueThermalPrinter.STATE_TURNING_ON:
            await scanForPrinters();
            break;
          default:
            print('Estado Bluetooth: $state');
            break;
        }
      });
    } catch (e) {
      _devices = [];
      availablePrinters.value = [];
      Get.snackbar('Erro', 'Erro ao escanear impressoras');
      print('Erro ao escanear impressoras: $e');
    }
  }

  Future<void> connectToPrinter() async {
    if (selectedPrinter.value == null) {
      Get.snackbar('Impressora', 'Nenhuma impressora selecionada');
      return;
    }

    isConnecting.value = true;
    try {
      selectedDevice =
          _devices.firstWhere((device) => device.name == selectedPrinter.value);
      if (selectedDevice != null) {
        if (isConnectedToPrinter.value) {
          await disconnectPrinter();
        }
        await connectToDevice(selectedDevice!);
      } else {
        Get.snackbar('Erro', 'Dispositivo não encontrado');
        print('Dispositivo não encontrado.');
      }
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao conectar: $e');
      print('Erro ao conectar: $e');
    } finally {
      isConnecting.value = false;
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      bool? isConnected = await bluetooth.isConnected;
      if (isConnected == false) {
        await bluetooth.connect(device);
        Get.snackbar('Impressora', 'Conectado à impressora ${device.name}');
        Storagers.boxInicial.write('printer', device.name);
        isConnectedToPrinter.value = true;
      } else {
        isConnectedToPrinter.value = true;
        Get.snackbar(
            'Impressora', 'Impressora já conectada: ${selectedPrinter.value}');
      }
    } catch (error) {
      isConnectedToPrinter.value = false;
      Get.snackbar('Erro', 'Erro ao conectar à impressora');
      print('Erro ao conectar à impressora: $error');
    }
  }

  Future<void> disconnectPrinter() async {
    try {
      await bluetooth.disconnect();
      isConnectedToPrinter.value = false;
      //  selectedPrinter.value = null;
      Get.snackbar('Impressora', 'Impressora desconectada com sucesso');
      print('Impressora desconectada com sucesso.');
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao desconectar impressora');
      print('Erro ao desconectar: $e');
    }
  }

  Future<void> printDocument() async {
    if (isConnectedToPrinter.value) {
      isPrinting.value = true;
      try {
        await TestPrintVistoria.printVistoria(vistoria);
        Get.snackbar('Impressão', 'Documento impresso com sucesso');
      } catch (e) {
        Get.snackbar('Erro', 'Erro ao imprimir documento');
        print('Erro ao imprimir documento: $e');
      } finally {
        isPrinting.value = false;
      }
    } else {
      Get.snackbar('Impressora', 'Nenhuma impressora conectada');
      print('Nenhuma impressora conectada.');
    }
  }
}
