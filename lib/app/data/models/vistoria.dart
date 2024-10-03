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
  double? km;
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
  bool? velocimetro;
  String? velocimetroObs;
  bool? ruidoMotor;
  String? ruidoMotorObs;
  bool? redutoresTemperatura;
  String? redutoresTemperaturaObs;
  bool? mataCachorro;
  String? mataCachorroObs;
  bool? cortaPipa;
  String? cortaPipaObs;
  bool? capacetes;
  String? capacetesObs;
  bool? colete;
  String? coleteObs;
  bool? potenciaMinimaMaxima;
  String? potenciaMinimaMaximaObs;
  bool? cinlindroGas;
  String? cilindroGasObs;
  bool? tacografo;
  String? tacografoObs;
  bool? requerPrefDiretTributario01;
  bool? requerPrefDiretTributario02;
  bool? requerPrefDiretTributario03;
  bool? requerPrefDiretTributario04;
  bool? requerPrefDiretTributario05;
  bool? requerPrefDiretTributario06;
  bool? bateria;
  String? bateriaObs;
  bool? adesivacao;
  String? adesivacaoObs;
  bool? macaco;
  String? macacoObs;
  bool? triangulo;
  String? trianguloObs;
  bool? vidros;
  String? vidrosObs;
  bool? docVeiculoProp;
  String? docVeiculoPropObs;
  bool? kitTracao;
  String? kitTracaoObs;
  bool? chavesIgnicaoBau;
  String? chavesIgnicaoBauObs;
  bool? freioServico;
  String? freioServicoObs;
  bool? freioEstacionamento;
  String? freioEstacionamentoObs;
  bool? motorPartida;
  String? motorPartidaObs;
  bool? luzIndicadoraDirecaoDianteira;
  String? luzIndicadoraDirecaoDianteiraObs;
  bool? luzIndicadoraDirecaoTraseira;
  String? luzIndicadoraDirecaoTraseiraObs;
  bool? indicadoresPainel;
  String? indicadoresPainelObs;
  bool? nivelOleoMotor;
  String? nivelOleoMotorObs;
  bool? nivelFluidoFreio;
  String? nivelFluidoFreioObs;
  bool? nivelAgua;
  String? nivelAguaObs;
  bool? pinturaFaixaHorizontal;
  String? pinturaFaixaHorizontalObs;
  String? observacao;
  int? usuarioId;
  String? agenteCod;
  String? statusVistoria;
  String? reprovadoObs;
  TipoPermissionario? codTipoPemissaoNavigation;
  List<FotosVistorium>? FotosVistoria;

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
    this.velocimetro,
    this.velocimetroObs,
    this.ruidoMotor,
    this.ruidoMotorObs,
    this.redutoresTemperatura,
    this.redutoresTemperaturaObs,
    this.mataCachorro,
    this.mataCachorroObs,
    this.cortaPipa,
    this.cortaPipaObs,
    this.capacetes,
    this.capacetesObs,
    this.colete,
    this.coleteObs,
    this.potenciaMinimaMaxima,
    this.potenciaMinimaMaximaObs,
    this.cinlindroGas,
    this.cilindroGasObs,
    this.tacografo,
    this.tacografoObs,
    this.requerPrefDiretTributario01,
    this.requerPrefDiretTributario02,
    this.requerPrefDiretTributario03,
    this.requerPrefDiretTributario04,
    this.requerPrefDiretTributario05,
    this.requerPrefDiretTributario06,
    this.bateria,
    this.bateriaObs,
    this.adesivacao,
    this.adesivacaoObs,
    this.macaco,
    this.macacoObs,
    this.triangulo,
    this.trianguloObs,
    this.vidros,
    this.vidrosObs,
    this.docVeiculoProp,
    this.docVeiculoPropObs,
    this.kitTracao,
    this.kitTracaoObs,
    this.chavesIgnicaoBau,
    this.chavesIgnicaoBauObs,
    this.freioServico,
    this.freioServicoObs,
    this.freioEstacionamento,
    this.freioEstacionamentoObs,
    this.motorPartida,
    this.motorPartidaObs,
    this.luzIndicadoraDirecaoDianteira,
    this.luzIndicadoraDirecaoDianteiraObs,
    this.luzIndicadoraDirecaoTraseira,
    this.luzIndicadoraDirecaoTraseiraObs,
    this.indicadoresPainel,
    this.indicadoresPainelObs,
    this.nivelOleoMotor,
    this.nivelOleoMotorObs,
    this.nivelFluidoFreio,
    this.nivelFluidoFreioObs,
    this.nivelAgua,
    this.nivelAguaObs,
    this.pinturaFaixaHorizontal,
    this.pinturaFaixaHorizontalObs,
    this.observacao,
    this.usuarioId,
    this.agenteCod,
    this.statusVistoria,
    this.FotosVistoria,
    this.reprovadoObs,
  });

  // Método para converter de JSON para a classe Dart
  factory Vistoria.fromJson(Map<dynamic, dynamic> json) {
    return Vistoria(
      codTipoPemissaoNavigation: json['codTipoPemissaoNavigation'] != null
          ? TipoPermissionario.fromJson(json['codTipoPemissaoNavigation'])
          : null,
      vistoriaId: json['vistoriaId'],
      idPermissionario: json['idPermissionario'],
      codTipoPermissao: json['codTipoPermissao'],
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
      velocimetro: json['velocimetro'],
      velocimetroObs: json['velocimetroObs'],
      ruidoMotor: json['ruidoMotor'],
      ruidoMotorObs: json['ruidoMotorObs'],
      redutoresTemperatura: json['redutoresTemperatura'],
      redutoresTemperaturaObs: json['redutoresTemperaturaObs'],
      mataCachorro: json['mataCachorro'],
      mataCachorroObs: json['mataCachorroObs'],
      cortaPipa: json['cortaPipa'],
      cortaPipaObs: json['cortaPipaObs'],
      capacetes: json['capacetes'],
      capacetesObs: json['capacetesObs'],
      colete: json['colete'],
      coleteObs: json['coleteObs'],
      potenciaMinimaMaxima: json['potenciaMinimaMaxima'],
      potenciaMinimaMaximaObs: json['potenciaMinimaMaximaObs'],
      cinlindroGas: json['cinlindroGas'],
      cilindroGasObs: json['cilindroGasObs'],
      tacografo: json['tacografo'],
      tacografoObs: json['tacografoObs'],
      requerPrefDiretTributario01: json['requerPrefDiretTributario01'],
      requerPrefDiretTributario02: json['requerPrefDiretTributario02'],
      requerPrefDiretTributario03: json['requerPrefDiretTributario03'],
      requerPrefDiretTributario04: json['requerPrefDiretTributario04'],
      requerPrefDiretTributario05: json['requerPrefDiretTributario05'],
      requerPrefDiretTributario06: json['requerPrefDiretTributario06'],
      bateria: json['bateria'],
      bateriaObs: json['bateriaObs'],
      adesivacao: json['adesivacao'],
      adesivacaoObs: json['adesivacaoObs'],
      macaco: json['macaco'],
      macacoObs: json['macacoObs'],
      triangulo: json['triangulo'],
      trianguloObs: json['trianguloObs'],
      vidros: json['vidros'],
      vidrosObs: json['vidrosObs'],
      docVeiculoProp: json['docVeiculoProp'],
      docVeiculoPropObs: json['docVeiculoPropObs'],
      kitTracao: json['kitTracao'],
      kitTracaoObs: json['kitTracaoObs'],
      chavesIgnicaoBau: json['chavesIgnicaoBau'],
      chavesIgnicaoBauObs: json['chavesIgnicaoBauObs'],
      freioServico: json['freioServico'],
      freioServicoObs: json['freioServicoObs'],
      freioEstacionamento: json['freioEstacionamento'],
      freioEstacionamentoObs: json['freioEstacionamentoObs'],
      motorPartida: json['motorPartida'],
      motorPartidaObs: json['motorPartidaObs'],
      luzIndicadoraDirecaoDianteira: json['luzIndicadoraDirecaoDianteira'],
      luzIndicadoraDirecaoDianteiraObs:
          json['luzIndicadoraDirecaoDianteiraObs'],
      luzIndicadoraDirecaoTraseira: json['luzIndicadoraDirecaoTraseira'],
      luzIndicadoraDirecaoTraseiraObs: json['luzIndicadoraDirecaoTraseiraObs'],
      indicadoresPainel: json['indicadoresPainel'],
      indicadoresPainelObs: json['indicadoresPainelObs'],
      nivelOleoMotor: json['nivelOleoMotor'],
      nivelOleoMotorObs: json['nivelOleoMotorObs'],
      nivelFluidoFreio: json['nivelFluidoFreio'],
      nivelFluidoFreioObs: json['nivelFluidoFreioObs'],
      nivelAgua: json['nivelAgua'],
      nivelAguaObs: json['nivelAguaObs'],
      pinturaFaixaHorizontal: json['pinturaFaixaHorizontal'],
      pinturaFaixaHorizontalObs: json['pinturaFaixaHorizontalObs'],
      observacao: json['observacao'],
      usuarioId: json['usuarioId'],
      agenteCod: json['agenteCod'],
      statusVistoria: json['statusVistoria'],
      reprovadoObs: json['reprovadoObs'],
      FotosVistoria: json['FotosVistoria'] != null
          ? List<FotosVistorium>.from(json['FotosVistoria']
              .map((item) => FotosVistorium.fromJson(item)))
          : [],
    );
  }

  // Método para converter a classe Dart para JSON
  Map<String, dynamic> toJson() {
    return {
      'vistoriaId': vistoriaId,
      'idPermissionario': idPermissionario,
      'codTipoPemissao': codTipoPermissao,
      'dataVistoria': dataVistoria?.toIso8601String(),
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
      'velocimetro': velocimetro,
      'velocimetroObs': velocimetroObs,
      'ruidoMotor': ruidoMotor,
      'ruidoMotorObs': ruidoMotorObs,
      'redutoresTemperatura': redutoresTemperatura,
      'redutoresTemperaturaObs': redutoresTemperaturaObs,
      'mataCachorro': mataCachorro,
      'mataCachorroObs': mataCachorroObs,
      'cortaPipa': cortaPipa,
      'cortaPipaObs': cortaPipaObs,
      'capacetes': capacetes,
      'capacetesObs': capacetesObs,
      'colete': colete,
      'coleteObs': coleteObs,
      'potenciaMinimaMaxima': potenciaMinimaMaxima,
      'potenciaMinimaMaximaObs': potenciaMinimaMaximaObs,
      'cinlindroGas': cinlindroGas,
      'cilindroGasObs': cilindroGasObs,
      'tacografo': tacografo,
      'tacografoObs': tacografoObs,
      'requerPrefDiretTributario01': requerPrefDiretTributario01,
      'requerPrefDiretTributario02': requerPrefDiretTributario02,
      'requerPrefDiretTributario03': requerPrefDiretTributario03,
      'requerPrefDiretTributario04': requerPrefDiretTributario04,
      'requerPrefDiretTributario05': requerPrefDiretTributario05,
      'requerPrefDiretTributario06': requerPrefDiretTributario06,
      'bateria': bateria,
      'bateriaObs': bateriaObs,
      'adesivacao': adesivacao,
      'adesivacaoObs': adesivacaoObs,
      'macaco': macaco,
      'macacoObs': macacoObs,
      'triangulo': triangulo,
      'trianguloObs': trianguloObs,
      'vidros': vidros,
      'vidrosObs': vidrosObs,
      'docVeiculoProp': docVeiculoProp,
      'docVeiculoPropObs': docVeiculoPropObs,
      'kitTracao': kitTracao,
      'kitTracaoObs': kitTracaoObs,
      'chavesIgnicaoBau': chavesIgnicaoBau,
      'chavesIgnicaoBauObs': chavesIgnicaoBauObs,
      'freioServico': freioServico,
      'freioServicoObs': freioServicoObs,
      'freioEstacionamento': freioEstacionamento,
      'freioEstacionamentoObs': freioEstacionamentoObs,
      'motorPartida': motorPartida,
      'motorPartidaObs': motorPartidaObs,
      'luzIndicadoraDirecaoDianteira': luzIndicadoraDirecaoDianteira,
      'luzIndicadoraDirecaoDianteiraObs': luzIndicadoraDirecaoDianteiraObs,
      'luzIndicadoraDirecaoTraseira': luzIndicadoraDirecaoTraseira,
      'luzIndicadoraDirecaoTraseiraObs': luzIndicadoraDirecaoTraseiraObs,
      'indicadoresPainel': indicadoresPainel,
      'indicadoresPainelObs': indicadoresPainelObs,
      'nivelOleoMotor': nivelOleoMotor,
      'nivelOleoMotorObs': nivelOleoMotorObs,
      'nivelFluidoFreio': nivelFluidoFreio,
      'nivelFluidoFreioObs': nivelFluidoFreioObs,
      'nivelAgua': nivelAgua,
      'nivelAguaObs': nivelAguaObs,
      'pinturaFaixaHorizontal': pinturaFaixaHorizontal,
      'pinturaFaixaHorizontalObs': pinturaFaixaHorizontalObs,
      'observacao': observacao,
      'usuarioId': usuarioId,
      'agenteCod': agenteCod,
      'statusVistoria': statusVistoria,
      'reprovadoObs': reprovadoObs,
    };
  }
}

class FotosVistorium {
  double fotoVistoriaId;
  double? vistoriaId;
  String? nomeFoto;
  Vistoria? vistoria;

  FotosVistorium({
    required this.fotoVistoriaId,
    this.vistoriaId,
    this.nomeFoto,
    this.vistoria,
  });

  // Método para converter um Map (JSON) em um objeto FotosVistorium
  factory FotosVistorium.fromJson(Map<String, dynamic> json) {
    return FotosVistorium(
      fotoVistoriaId: json['fotoVistoriaId'] ?? 0,
      vistoriaId: json['vistoriaId'],
      nomeFoto: json['nomeFoto'],
      // vistoria: json['vistoria'] != null ? Vistoria.fromJson(json['vistoria']) : null,
    );
  }

  // Método para converter um objeto FotosVistorium em um Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'fotoVistoriaId': fotoVistoriaId,
      'vistoriaId': vistoriaId,
      'nomeFoto': nomeFoto,
      'vistoria': vistoria?.toJson(),
    };
  }
}
