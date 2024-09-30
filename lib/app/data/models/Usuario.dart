import 'dart:convert';

import 'dart:convert';

class Usuario {
  double? usuarioId;
  String? usuNome;
  double? usuCPF;
  String? usuRg;
  String? usuLogin;
  String? usuSenha;
  bool? usuAtivo;
  String? usuEmail;
  String? usuFoneRes;
  String? usuFoneCom;
  String? usuFoneCel;
  int? usuCodLogradouro;
  int? usuCodBairro;
  String? usuComplemento;
  String? usuNumResidencia;
  String? usuCEP;
  int? usuCodCidade;
  int? usuCodUF;
  int? usuCodPais;
  DateTime? usuDataCadastro;
  String? usuTrocarSenhaPrimeiroAcesso;
  int? agenteCod;
  String? usuEndereco;
  int? docCod;
  String? foto;
  String? usuNomeSocial;
  bool? permConsultar;
  bool? permInserir;
  bool? permAlterar;
  bool? permApagar;
  String? usuMatriculaFuncionario;

  Usuario({
    this.usuarioId,
    this.usuNome,
    this.usuCPF,
    this.usuRg,
    this.usuLogin,
    this.usuSenha,
    this.usuAtivo,
    this.usuEmail,
    this.usuFoneRes,
    this.usuFoneCom,
    this.usuFoneCel,
    this.usuCodLogradouro,
    this.usuCodBairro,
    this.usuComplemento,
    this.usuNumResidencia,
    this.usuCEP,
    this.usuCodCidade,
    this.usuCodUF,
    this.usuCodPais,
    this.usuDataCadastro,
    this.usuTrocarSenhaPrimeiroAcesso,
    this.agenteCod,
    this.usuEndereco,
    this.docCod,
    this.foto,
    this.usuNomeSocial,
    this.permConsultar,
    this.permInserir,
    this.permAlterar,
    this.permApagar,
    this.usuMatriculaFuncionario,
  });

  Map<String, dynamic> toMap() {
    return {
      'usuarioId': usuarioId,
      'usuNome': usuNome,
      'usuCPF': usuCPF,
      'usuRg': usuRg,
      'usuLogin': usuLogin,
      'usuSenha': usuSenha,
      'usuAtivo': usuAtivo,
      'usuEmail': usuEmail,
      'usuFoneRes': usuFoneRes,
      'usuFoneCom': usuFoneCom,
      'usuFoneCel': usuFoneCel,
      'usuCodLogradouro': usuCodLogradouro,
      'usuCodBairro': usuCodBairro,
      'usuComplemento': usuComplemento,
      'usuNumResidencia': usuNumResidencia,
      'usuCEP': usuCEP,
      'usuCodCidade': usuCodCidade,
      'usuCodUF': usuCodUF,
      'usuCodPais': usuCodPais,
      'usuDataCadastro': usuDataCadastro?.toIso8601String(),
      'usuTrocarSenhaPrimeiroAcesso': usuTrocarSenhaPrimeiroAcesso,
      'agenteCod': agenteCod,
      'usuEndereco': usuEndereco,
      'docCod': docCod,
      'foto': foto,
      'usuNomeSocial': usuNomeSocial,
      'permConsultar': permConsultar,
      'permInserir': permInserir,
      'permAlterar': permAlterar,
      'permApagar': permApagar,
      'usuMatriculaFuncionario': usuMatriculaFuncionario,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      usuarioId: map['usuarioId'] ?? 0.0,
      usuNome: map['usuNome'],
      usuCPF: map['usuCPF'],
      usuRg: map['usuRg'],
      usuLogin: map['usuLogin'],
      usuSenha: map['usuSenha'],
      usuAtivo: map['usuAtivo'],
      usuEmail: map['usuEmail'],
      usuFoneRes: map['usuFoneRes'],
      usuFoneCom: map['usuFoneCom'],
      usuFoneCel: map['usuFoneCel'],
      usuCodLogradouro: map['usuCodLogradouro'],
      usuCodBairro: map['usuCodBairro'],
      usuComplemento: map['usuComplemento'],
      usuNumResidencia: map['usuNumResidencia'],
      usuCEP: map['usuCEP'],
      usuCodCidade: map['usuCodCidade'],
      usuCodUF: map['usuCodUF'],
      usuCodPais: map['usuCodPais'],
      usuDataCadastro: map['usuDataCadastro'] != null
          ? DateTime.parse(map['usuDataCadastro'])
          : null,
      usuTrocarSenhaPrimeiroAcesso: map['usuTrocarSenhaPrimeiroAcesso'],
      agenteCod: map['agenteCod'],
      usuEndereco: map['usuEndereco'],
      docCod: map['docCod'],
      foto: map['foto'],
      usuNomeSocial: map['usuNomeSocial'],
      permConsultar: map['permConsultar'],
      permInserir: map['permInserir'],
      permAlterar: map['permAlterar'],
      permApagar: map['permApagar'],
      usuMatriculaFuncionario: map['usuMatriculaFuncionario'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) =>
      Usuario.fromMap(json.decode(source));
}

class usuarioDtop {
  Usuario? usuario;
  String? token;
  usuarioDtop({this.usuario, this.token});

  Map<String, dynamic> toMap() {
    return {
      'usuario': usuario!.toMap(),
      'token': token,
    };
  }

  factory usuarioDtop.fromMap(Map<String, dynamic> map) {
    return usuarioDtop(
      usuario: Usuario.fromMap(map['usuario']),
      token: map['token'],
    );
  }
}
