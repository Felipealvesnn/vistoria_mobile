import 'dart:convert';

class Usuario {
  String? nome;
  String? email;
  String? senha;
  String? token;
  String? cpf;
  String? telefone;
  String? dataNascimento;
  String? sexo;
  String? foto;
  Usuario({
    this.nome,
    this.email,
    this.senha,
    this.token,
    this.cpf,
    this.telefone,
    this.dataNascimento,
    this.sexo,
    this.foto,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'senha': senha,
      'token': token,
      'cpf': cpf,
      'telefone': telefone,
      'dataNascimento': dataNascimento,
      'sexo': sexo,
      'foto': foto,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
      token: map['token'],
      cpf: map['cpf'],
      telefone: map['telefone'],
      dataNascimento: map['dataNascimento'],
      sexo: map['sexo'],
      foto: map['foto'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) =>
      Usuario.fromMap(json.decode(source));
}
