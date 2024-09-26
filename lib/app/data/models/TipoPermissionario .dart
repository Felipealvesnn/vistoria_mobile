import 'package:vistoria_mobile/app/data/models/vistoria.dart';

class TipoPermissionario {
  int? codTipoPermissao;
  String? descricao;
  String? reportAlvara;
  List<Vistoria> vistorias; // Relacionamento "muitos para um"

  // Construtor
  TipoPermissionario({
    this.codTipoPermissao,
    this.descricao,
    this.reportAlvara,
    this.vistorias = const [],
  });

  // Método para converter JSON para a classe Dart
  factory TipoPermissionario.fromJson(Map<String, dynamic> json) {
    return TipoPermissionario(
      codTipoPermissao: json['codTipoPemissao'] ?? 0,
      descricao: json['descricao'],
      reportAlvara: json['reportAlvara'],
      // vistorias: (json['vistoria'] as List<dynamic>)
      //     .map((item) => Vistorium.fromJson(item))
      //     .toList(),
    );
  }

  // Método para converter a classe Dart para JSON
  Map<String, dynamic> toJson() {
    return {
      'codTipoPermissao': codTipoPermissao,
      'descricao': descricao,
      'reportAlvara': reportAlvara,
      'vistorias': vistorias.map((v) => v.toJson()).toList(),
    };
  }
}
