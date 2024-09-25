
import 'package:vistoria_mobile/app/data/models/TipoPermissionario .dart';
import 'package:vistoria_mobile/app/data/models/VeiculoTipo.dart';
import 'package:vistoria_mobile/app/data/models/vistoria.dart';

class vistoriaMobileDTO {
  List<TipoPermissionario>? tipoPermissionario;
  List<VeiculoTipo>? veiculoTipos;
  Vistoria? vistorium;

  vistoriaMobileDTO.vistoriaMobileDTO({this.tipoPermissionario, this.veiculoTipos, this.vistorium});

  factory vistoriaMobileDTO.fromJson(Map<String, dynamic> json) {
    return vistoriaMobileDTO.vistoriaMobileDTO(
      tipoPermissionario: (json['tipoPermissionario'] as List?)
          ?.map((e) => TipoPermissionario.fromJson(e))
          .toList(),
      veiculoTipos: (json['veiculoTipos'] as List?)
          ?.map((e) => VeiculoTipo.fromJson(e))
          .toList(),
      vistorium: json['vistorium'] != null
          ? Vistoria.fromJson(json['vistorium'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tipoPermissionario':
          tipoPermissionario?.map((e) => e.toJson()).toList(),
      'veiculoTipos': veiculoTipos?.map((e) => e.toJson()).toList(),
      'vistorium': vistorium?.toJson(),
    };
  }
}


  