import 'package:vistoria_mobile/app/data/models/TipoPermissionario%20.dart';

class Vistoria {
  int? vistoriaId;
  int? idPermissionario;
  int? codTipoPermissao;
  DateTime? dataVistoria;
  String? placa;
  String? chassi;
  String? marcaModelo;
  String? ano;
  String? cor;
  String? tipo;
  int? km;
  bool? parachoques;
  String? parachoquesObs;
  bool? retrovisores;
  String? retrovisoresObs;
  bool? limpadorParabrisa;
  String? limpadorParabrisaObs;
  bool? lavadorParabrisa;
  String? lavadorParabrisaObs;
  bool? parasol;
  String? parasolObs;
  bool? faroisPrincipaisDianteiros;
  String? faroisPrincipaisDianteirosObs;
  bool? faroletes;
  String? faroletesObs;
  bool? lanternasPosicaoTraseira;
  String? lanternasPosicaoTraseiraObs;
  bool? lanternasFreio;
  String? lanternasFreioObs;
  bool? lanternasDirecao;
  String? lanternasDirecaoObs;
  bool? lanternaMarchaRe;
  String? lanternaMarchaReObs;
  bool? lanternaPlacaTraseira;
  String? lanternaPlacaTraseiraObs;
  bool? buzina;
  String? buzinaObs;
  bool? pneus;
  String? pneusObs;
  bool? extintor;
  String? extintorObs;
  bool? cintoSeguranca;
  String? cintoSegurancaObs;
  bool? step;
  String? stepObs;
  bool? chaveRoda;
  String? chaveRodaObs;
  bool? higieneSeguranca;
  String? higieneSegurancaObs;
  bool? bancosHigieneSeguranca;
  String? bancosHigieneSegurancaObs;
  TipoPermissionario? codTipoPemissaoNavigation;

  Vistoria({
    this.codTipoPemissaoNavigation,
    this.vistoriaId,
    this.idPermissionario,
    this.codTipoPermissao,
    this.dataVistoria,
    this.placa,
    this.chassi,
    this.marcaModelo,
    this.ano,
    this.cor,
    this.tipo,
    this.km,
    this.parachoques,
    this.parachoquesObs,
    this.retrovisores,
    this.retrovisoresObs,
    this.limpadorParabrisa,
    this.limpadorParabrisaObs,
    this.lavadorParabrisa,
    this.lavadorParabrisaObs,
    this.parasol,
    this.parasolObs,
    this.faroisPrincipaisDianteiros,
    this.faroisPrincipaisDianteirosObs,
    this.faroletes,
    this.faroletesObs,
    this.lanternasPosicaoTraseira,
    this.lanternasPosicaoTraseiraObs,
    this.lanternasFreio,
    this.lanternasFreioObs,
    this.lanternasDirecao,
    this.lanternasDirecaoObs,
    this.lanternaMarchaRe,
    this.lanternaMarchaReObs,
    this.lanternaPlacaTraseira,
    this.lanternaPlacaTraseiraObs,
    this.buzina,
    this.buzinaObs,
    this.pneus,
    this.pneusObs,
    this.extintor,
    this.extintorObs,
    this.cintoSeguranca,
    this.cintoSegurancaObs,
    this.step,
    this.stepObs,
    this.chaveRoda,
    this.chaveRodaObs,
    this.higieneSeguranca,
    this.higieneSegurancaObs,
    this.bancosHigieneSeguranca,
    this.bancosHigieneSegurancaObs,
  });

  // Método para converter de JSON para a classe Dart
  factory Vistoria.fromJson(Map<String, dynamic> json) {
    return Vistoria(
      codTipoPemissaoNavigation: json['codTipoPemissaoNavigation'] != null
          ? TipoPermissionario.fromJson(json['codTipoPemissaoNavigation'])
          : null,
      vistoriaId: json['vistoriaId'],
      idPermissionario: json['idPermissionario'],
      codTipoPermissao: json['codTipoPemissao'],
      dataVistoria: DateTime.parse(json['dataVistoria']),
      placa: json['placa'],
      chassi: json['chassi'],
      marcaModelo: json['marcaModelo'],
      ano: json['ano'],
      cor: json['cor'],
      tipo: json['tipo'],
      km: json['km'],
      parachoques: json['parachoques'],
      parachoquesObs: json['parachoquesObs'],
      retrovisores: json['retrovisores'],
      retrovisoresObs: json['retrovisoresObs'],
      limpadorParabrisa: json['limpadorParabrisa'],
      limpadorParabrisaObs: json['limpadorParabrisaObs'],
      lavadorParabrisa: json['lavadorParabrisa'],
      lavadorParabrisaObs: json['lavadorParabrisaObs'],
      parasol: json['parasol'],
      parasolObs: json['parasolObs'],
      faroisPrincipaisDianteiros: json['faroisPrincipaisDianteiros'],
      faroisPrincipaisDianteirosObs: json['faroisPrincipaisDianteirosObs'],
      faroletes: json['faroletes'],
      faroletesObs: json['faroletesObs'],
      lanternasPosicaoTraseira: json['lanternasPosicaoTraseira'],
      lanternasPosicaoTraseiraObs: json['lanternasPosicaoTraseiraObs'],
      lanternasFreio: json['lanternasFreio'],
      lanternasFreioObs: json['lanternasFreioObs'],
      lanternasDirecao: json['lanternasDirecao'],
      lanternasDirecaoObs: json['lanternasDirecaoObs'],
      lanternaMarchaRe: json['lanternaMarchaRe'],
      lanternaMarchaReObs: json['lanternaMarchaReObs'],
      lanternaPlacaTraseira: json['lanternaPlacaTraseira'],
      lanternaPlacaTraseiraObs: json['lanternaPlacaTraseiraObs'],
      buzina: json['buzina'],
      buzinaObs: json['buzinaObs'],
      pneus: json['pneus'],
      pneusObs: json['pneusObs'],
      extintor: json['extintor'],
      extintorObs: json['extintorObs'],
      cintoSeguranca: json['cintoSeguranca'],
      cintoSegurancaObs: json['cintoSegurancaObs'],
      step: json['step'],
      stepObs: json['stepObs'],
      chaveRoda: json['chaveRoda'],
      chaveRodaObs: json['chaveRodaObs'],
      higieneSeguranca: json['higieneSeguranca'],
      higieneSegurancaObs: json['higieneSegurancaObs'],
      bancosHigieneSeguranca: json['bancosHigieneSeguranca'],
      bancosHigieneSegurancaObs: json['bancosHigieneSegurancaObs'],
    );
  }

  // Método para converter a classe Dart para JSON
  Map<String, dynamic> toJson() {
    return {
      'vistoriaId': vistoriaId,
      'idPermissionario': idPermissionario,
      'codTipoPemissao': codTipoPermissao,
      'dataVistoria': dataVistoria!.toIso8601String(),
      'placa': placa,
      'chassi': chassi,
      'marcaModelo': marcaModelo,
      'ano': ano,
      'cor': cor,
      'tipo': tipo,
      'km': km,
      'parachoques': parachoques,
      'parachoquesObs': parachoquesObs,
      'retrovisores': retrovisores,
      'retrovisoresObs': retrovisoresObs,
      'limpadorParabrisa': limpadorParabrisa,
      'limpadorParabrisaObs': limpadorParabrisaObs,
      'lavadorParabrisa': lavadorParabrisa,
      'lavadorParabrisaObs': lavadorParabrisaObs,
      'parasol': parasol,
      'parasolObs': parasolObs,
      'faroisPrincipaisDianteiros': faroisPrincipaisDianteiros,
      'faroisPrincipaisDianteirosObs': faroisPrincipaisDianteirosObs,
      'faroletes': faroletes,
      'faroletesObs': faroletesObs,
      'lanternasPosicaoTraseira': lanternasPosicaoTraseira,
      'lanternasPosicaoTraseiraObs': lanternasPosicaoTraseiraObs,
      'lanternasFreio': lanternasFreio,
      'lanternasFreioObs': lanternasFreioObs,
      'lanternasDirecao': lanternasDirecao,
      'lanternasDirecaoObs': lanternasDirecaoObs,
      'lanternaMarchaRe': lanternaMarchaRe,
      'lanternaMarchaReObs': lanternaMarchaReObs,
      'lanternaPlacaTraseira': lanternaPlacaTraseira,
      'lanternaPlacaTraseiraObs': lanternaPlacaTraseiraObs,
      'buzina': buzina,
      'buzinaObs': buzinaObs,
      'pneus': pneus,
      'pneusObs': pneusObs,
      'extintor': extintor,
      'extintorObs': extintorObs,
      'cintoSeguranca': cintoSeguranca,
      'cintoSegurancaObs': cintoSegurancaObs,
      'step': step,
      'stepObs': stepObs,
      'chaveRoda': chaveRoda,
      'chaveRodaObs': chaveRodaObs,
      'higieneSeguranca': higieneSeguranca,
      'higieneSegurancaObs': higieneSegurancaObs,
      'bancosHigieneSeguranca': bancosHigieneSeguranca,
      'bancosHigieneSegurancaObs': bancosHigieneSegurancaObs,
    };
  }
}
