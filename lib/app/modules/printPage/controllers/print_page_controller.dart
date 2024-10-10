import 'package:get/get.dart';
import 'package:vistoria_mobile/app/data/models/vistoria.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:vistoria_mobile/app/modules/printPage/components/TestPrintVistoria.dart';
import 'package:vistoria_mobile/app/utils/getstorages.dart';

class PrintPageController extends GetxController {
  var selectedPrinter = Rx<String?>(null);
  var tempSelectedPrinter =
      Rx<String?>(null); // Impressora temporária para o dropdown
  var availablePrinters = <String>[].obs;
  var isConnectedToPrinter = false.obs;
  var isConnecting = false.obs;
  var isLoading = true.obs;
  late Vistoria vistoria;
  var isBluetoothOn = false.obs;
  final BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? selectedDevice;

  @override
  void onInit() async {
    super.onInit();
    vistoria = Get.arguments as Vistoria;
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
      print('Erro ao verificar status do Bluetooth: $e');
    }
  }

  Future<void> handleConnectedDevice() async {
    try {
      var nomeIMpressora = Storagers.boxInicial.read('printer');
      if (nomeIMpressora != null) {
        selectedPrinter.value = nomeIMpressora;
        tempSelectedPrinter.value = nomeIMpressora;
        selectedDevice = _devices
            .firstWhere((device) => device.name == selectedPrinter.value);
        isConnectedToPrinter.value = true;
      }
    } catch (e) {
      print('Erro ao manusear dispositivos conectados: $e');
    }
  }

  Future<void> attemptReconnect() async {
    if (selectedDevice != null) {
      try {
        await connectToDevice(selectedDevice!);
      } catch (e) {
        isConnectedToPrinter.value = false;
      }
    } else {
      Get.snackbar('impressora', 'Nenhuma impressora conectada');
    }
  }

  Future<void> scanForPrinters() async {
    try {
      _devices = await bluetooth.getBondedDevices();
      availablePrinters.value = _devices
          .where((device) => device.name != null)
          .map((device) => device.name!)
          .toList();

      bluetooth.onStateChanged().listen((state) {
        switch (state) {
          case BlueThermalPrinter.CONNECTED:
            isConnectedToPrinter.value = true;
            break;
          case BlueThermalPrinter.DISCONNECTED:
            isConnectedToPrinter.value = false;
            Future.delayed(const Duration(seconds: 1), () {
              availablePrinters.value = [];
              // Limpe o valor da impressora selecionada se a lista for esvaziada
              if (!availablePrinters.contains(tempSelectedPrinter.value)) {
                tempSelectedPrinter.value =
                    null; // ou defina um valor padrão, se necessário
              }
            });

            break;
          default:
            print(state);
            break;
        }
      });
    } catch (e) {
      _devices = [];
      print('Erro ao escanear impressoras: $e');
    }
  }

  Future<void> connectToPrinter() async {
    try {
      if (tempSelectedPrinter.value == null) {
        Get.snackbar('Impressora', 'Nenhuma impressora selecionada');
        return;
      }

      isConnecting.value = true;
      if (tempSelectedPrinter.value != null &&
          tempSelectedPrinter.value != 'Não disponível') {
        selectedDevice = _devices
            .firstWhere((device) => device.name == tempSelectedPrinter.value);
        if (selectedDevice != null) {
          if (isConnectedToPrinter.value) {
            await disconnectPrinter();
          }
          await connectToDevice(selectedDevice!);
        } else {
          print('Dispositivo não encontrado.');
        }
      } else {
        print('Nenhuma impressora disponível para conectar.');
      }
    } catch (e) {
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
        Get.snackbar('impressora', 'Conectado à impressora ${device.name}');
        Storagers.boxInicial.write('printer', device.name);
        selectedPrinter.value =
            tempSelectedPrinter.value; // Atualiza a impressora conectada
        isConnectedToPrinter.value = true;
      } else {
        isConnectedToPrinter.value = true;
        Get.snackbar(
            'impressora', 'Impressora já conectada: ${selectedPrinter.value}');
      }
    } catch (error) {
      isConnectedToPrinter.value = false;
      Get.snackbar('Error', 'Erro ao conectar');
    }
  }

  Future<void> disconnectPrinter() async {
    try {
      await bluetooth.disconnect();
      isConnectedToPrinter.value = false;
      selectedPrinter.value = null;
      print('Impressora desconectada com sucesso.');
    } catch (e) {
      print('Erro ao desconectar: $e');
    }
  }

  void printDocument() {
    if (isConnectedToPrinter.value) {
      print('Imprimindo documento...');
      TestPrintVistoria.printVistoria(vistoria);
    } else {
      print('Nenhuma impressora conectada.');
    }
  }
}
