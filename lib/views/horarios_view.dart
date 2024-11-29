import 'package:flutter/material.dart';
import '../models/monitor.dart';

class HorariosView extends StatelessWidget {
  final Monitor monitor;

  const HorariosView({super.key, required this.monitor});

  @override
  Widget build(BuildContext context) {

    final horariosAgrupados = monitor.getHorariosAgrupados();
    return Scaffold(
      appBar: AppBar(
        title: Text('Horários - ${monitor.nome}'),
      ),
      body: ListView.builder(
        itemCount: horariosAgrupados.keys.length,
        itemBuilder: (context, index) {
          final dia = horariosAgrupados.keys.elementAt(index);
          final horarios = horariosAgrupados[dia];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dia,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: horarios!.map((horario) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          horario,
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                  }).toList(),
                 ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
