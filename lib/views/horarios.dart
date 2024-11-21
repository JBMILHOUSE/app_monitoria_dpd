import 'package:flutter/material.dart';
import '../models/monitor.dart';

class HorariosView extends StatelessWidget {
  final Monitor monitor;

  HorariosView({required this.monitor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horários - ${monitor.nome}'),
      ),
      body: ListView.builder(
        itemCount: monitor.horarios.keys.length,
        itemBuilder: (context, index) {
          final dia = monitor.horarios.keys.elementAt(index);
          final horarios = monitor.horarios[dia]!;
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                dia,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: horarios
                    .map((horario) => Text('- $horario'))
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
