class Monitor {
  final String nome;
  final String avatar;
  final List<Horario> horarios;

  Monitor({
    required this.nome,
    required this.avatar,
    required this.horarios,
  });

  // Método para converter JSON em Monitor
  factory Monitor.fromJson(Map<String, dynamic> json) {
    // Decodifica a lista de horários
    final horarios = (json['horarios'] as List<dynamic>).map((item) {
      return Horario.fromJson(item);
    }).toList();

    return Monitor(
      nome: json['nome'],
      avatar: json['avatar'] ?? '',
      horarios: horarios,
    );
  }

  // Método para agrupar os horários por dia
  Map<String, List<String>> getHorariosAgrupados() {
    final Map<String, List<String>> agrupados = {};

    for (final horario in horarios) {
      if (!agrupados.containsKey(horario.dia)) {
        agrupados[horario.dia] = [];
      }
      agrupados[horario.dia]!.add(horario.hora);
    }

    return agrupados;
  }
}

class Horario {
  final String dia;
  final String hora;

  Horario({required this.dia, required this.hora});

  // Método para converter JSON em Horario
  factory Horario.fromJson(Map<String, dynamic> json) {
    return Horario(
      dia: json['dia'],
      hora: json['hora'],
    );
  }
}