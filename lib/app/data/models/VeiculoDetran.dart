import 'dart:convert';

// Modelo principal
class VeiculoDetran {
  final String? placa;
  final String? chassi;
  final String? renavam;
  final String? marcaModelo;
  final String? cor;
  final String? tipo;
  final String? especie;
  final String? categoria;
  final String? anoFabricacao;
  final String? anoModelo;
  final String? situacaoCodigo;
  final String? situacaoDescricao;
  final String? uf;
  final String? municipio;
  final String? proprietario;
  final String? cpfCnpjProprietario;
  final String? ultimoAnoExercicio;
  final String? debitoLicenciamento;
  final String? debitoIpva;
  final String? multasValor;
  final String? multasQuantidade;
  final String? restricoesQuantidade;
  final String? observacaoQuantidade;
  final String? inspecaoQuantidade;
  final String? combustivelDescricao;
  final bool? isPessoaFisica;
  final bool? isVeiculoClonado;
  final bool? isVeiculoSuspeitoClonagem;
  final List<Restricao>? veiculoRestricoes;
  final List<dynamic>? veiculoObservacoes;
  final List<dynamic>? veiculoInspecoes;
  final Retorno? retorno;
  final dynamic imagem;
  final dynamic blits;
  final dynamic blitzID;

  VeiculoDetran({
    this.placa,
    this.chassi,
    this.renavam,
    this.marcaModelo,
    this.cor,
    this.tipo,
    this.especie,
    this.categoria,
    this.anoFabricacao,
    this.anoModelo,
    this.situacaoCodigo,
    this.situacaoDescricao,
    this.uf,
    this.municipio,
    this.proprietario,
    this.cpfCnpjProprietario,
    this.ultimoAnoExercicio,
    this.debitoLicenciamento,
    this.debitoIpva,
    this.multasValor,
    this.multasQuantidade,
    this.restricoesQuantidade,
    this.observacaoQuantidade,
    this.inspecaoQuantidade,
    this.combustivelDescricao,
    this.isPessoaFisica,
    this.isVeiculoClonado,
    this.isVeiculoSuspeitoClonagem,
    this.veiculoRestricoes,
    this.veiculoObservacoes,
    this.veiculoInspecoes,
    this.retorno,
    this.imagem,
    this.blits,
    this.blitzID,
  });

  Map<String, dynamic> toMap() {
    return {
      'placa': placa,
      'chassi': chassi,
      'renavam': renavam,
      'marcaModelo': marcaModelo,
      'cor': cor,
      'tipo': tipo,
      'especie': especie,
      'categoria': categoria,
      'anoFabricacao': anoFabricacao,
      'anoModelo': anoModelo,
      'situacaoCodigo': situacaoCodigo,
      'situacaoDescricao': situacaoDescricao,
      'uf': uf,
      'municipio': municipio,
      'proprietario': proprietario,
      'cpfCnpjProprietario': cpfCnpjProprietario,
      'ultimoAnoExercicio': ultimoAnoExercicio,
      'debitoLicenciamento': debitoLicenciamento,
      'debitoIpva': debitoIpva,
      'multasValor': multasValor,
      'multasQuantidade': multasQuantidade,
      'restricoesQuantidade': restricoesQuantidade,
      'observacaoQuantidade': observacaoQuantidade,
      'inspecaoQuantidade': inspecaoQuantidade,
      'combustivelDescricao': combustivelDescricao,
      'isPessoaFisica': isPessoaFisica,
      'isVeiculoClonado': isVeiculoClonado,
      'isVeiculoSuspeitoClonagem': isVeiculoSuspeitoClonagem,
      'veiculoRestricoes': veiculoRestricoes?.map((x) => x?.toMap())?.toList(),
      'veiculoObservacoes': veiculoObservacoes,
      'veiculoInspecoes': veiculoInspecoes,
      'retorno': retorno?.toJson(),
      'imagem': imagem,
      'blits': blits,
      'blitzID': blitzID,
    };
  }

  factory VeiculoDetran.fromJson(Map<String, dynamic> map) {
    return VeiculoDetran(
      placa: map['placa'],
      chassi: map['chassi'],
      renavam: map['renavam'],
      marcaModelo: map['marcaModelo'],
      cor: map['cor'],
      tipo: map['tipo'],
      especie: map['especie'],
      categoria: map['categoria'],
      anoFabricacao: map['anoFabricacao']??"",
      anoModelo: map['anoModelo']??"",
      situacaoCodigo: map['situacaoCodigo'],
      situacaoDescricao: map['situacaoDescricao'],
      uf: map['uf'],
      municipio: map['municipio'],
      proprietario: map['proprietario'],
      cpfCnpjProprietario: map['cpfCnpjProprietario'],
      ultimoAnoExercicio: map['ultimoAnoExercicio'],
      debitoLicenciamento: map['debitoLicenciamento'],
      debitoIpva: map['debitoIpva'],
      multasValor: map['multasValor'],
      multasQuantidade: map['multasQuantidade'],
      restricoesQuantidade: map['restricoesQuantidade'],
      observacaoQuantidade: map['observacaoQuantidade'],
      inspecaoQuantidade: map['inspecaoQuantidade'],
      combustivelDescricao: map['combustivelDescricao'],
      isPessoaFisica: map['isPessoaFisica'],
      isVeiculoClonado: map['isVeiculoClonado'],
      isVeiculoSuspeitoClonagem: map['isVeiculoSuspeitoClonagem'],
      veiculoRestricoes: map['veiculoRestricoes'] != null ? List<Restricao>.from(map['veiculoRestricoes']?.map((x) => Restricao.fromJson(x))) : null,
      veiculoObservacoes: List<dynamic>.from(map['veiculoObservacoes']??[]),
      veiculoInspecoes: List<dynamic>.from(map['veiculoInspecoes']?? []),
      retorno: map['retorno'] != null ? Retorno.fromJson(map['retorno']) : null,
      imagem: map['imagem'] ?? null,
      blits: map['blits'] ?? null,
      blitzID: map['blitzID'] ?? null,
    );
  }

  String toJson() => json.encode(toMap());

 
}





// Modelo de Restrição
class Restricao {
  final String codigo;
  final String descricao;
  final String motivoInclusao;
  final String dataInclusao;
  final String? nomeComprador;
  final String? cpfCnpjComprador;

  Restricao({
    required this.codigo,
    required this.descricao,
    required this.motivoInclusao,
    required this.dataInclusao,
    this.nomeComprador,
    this.cpfCnpjComprador,
  });

  

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'descricao': descricao,
      'motivoInclusao': motivoInclusao,
      'dataInclusao': dataInclusao,
      'nomeComprador': nomeComprador,
      'cpfCnpjComprador': cpfCnpjComprador,
    };
  }

  factory Restricao.fromJson(Map<String, dynamic> map) {
    return Restricao(
      codigo: map['codigo'] ?? '',
      descricao: map['descricao'] ?? '',
      motivoInclusao: map['motivoInclusao'] ?? '',
      dataInclusao: map['dataInclusao'] ?? '',
      nomeComprador: map['nomeComprador'],
      cpfCnpjComprador: map['cpfCnpjComprador'],
    );
  }

  String toJson() => json.encode(toMap());

 //factory Restricao.fromJson(String source) => Restricao.fromMap(json.decode(source));
}

// Modelo de Retorno
class Retorno {
  final int codigo;
  final String descricao;

  Retorno({required this.codigo, required this.descricao});

 

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'descricao': descricao,
    };
  }

  factory Retorno.fromJson(Map<String, dynamic> map) {
    return Retorno(
      codigo: map['codigo'] ?? 0,
      descricao: map['descricao'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  //factory Retorno.fromJson(String source) => Retorno.fromMap(json.decode(source));
}
