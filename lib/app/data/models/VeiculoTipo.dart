class VeiculoTipo {
  int? veiTipCod;
  String? veiTipDesc;
  String? veiTipCodSnt;
  int? idGrupoTipoVeic;
  List<Veiculo> veiculos;

  // Construtor
  VeiculoTipo({
    this.veiTipCod,
    this.veiTipDesc,
    this.veiTipCodSnt,
    this.idGrupoTipoVeic,
    this.veiculos = const [],
  });

  // Método para converter JSON para a classe Dart
  factory VeiculoTipo.fromJson(Map<String, dynamic> json) {
    return VeiculoTipo(
      veiTipCod: json['veiTipCod'],
      veiTipDesc: json['veiTipDesc'],
      veiTipCodSnt: json['veiTipCodSnt'],
      idGrupoTipoVeic: json['idGrupoTipoVeic'],
      //veiculos: (json['veiculos'] as List<dynamic>)
          // .map((item) => Veiculo.fromJson(item))
          // .toList(),
    );
  }

  // Método para converter a classe Dart para JSON
  Map<String, dynamic> toJson() {
    return {
      'veiTipCod': veiTipCod,
      'veiTipDesc': veiTipDesc,
      'veiTipCodSnt': veiTipCodSnt,
      'idGrupoTipoVeic': idGrupoTipoVeic,
      'veiculos': veiculos.map((v) => v.toJson()).toList(),
    };
  }
}

class Veiculo {
  // Defina a estrutura da classe Veiculo baseada no seu modelo
  // Como exemplo:
  int veiculoId;
  String? placa;

  Veiculo({
    required this.veiculoId,
    this.placa,
  });

  factory Veiculo.fromJson(Map<String, dynamic> json) {
    return Veiculo(
      veiculoId: json['veiculoId'],
      placa: json['placa'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'veiculoId': veiculoId,
      'placa': placa,
    };
  }
}
