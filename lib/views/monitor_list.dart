import 'package:flutter/material.dart';
import 'package:app_monitoria_dpd/services/monitor_service.dart';
import '../models/monitor.dart';
import 'horarios_view.dart';

class MonitorList extends StatefulWidget {
  const MonitorList({super.key});

  @override
  _MonitorListState createState() => _MonitorListState();
}

class _MonitorListState extends State<MonitorList> {
  late Future<List<Monitor>> futMonitor;

  @override
  void initState() {
    super.initState();

    // busca api em services
    futMonitor = MonitorApiService.fetchMonitores();
  }

  @override
  Widget build(BuildContext context) {

    // lista de monitores 
    // final List<Monitor> monitores = DUMMY_MONITORES.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Monitores DPD'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), // usar filtro
            onPressed: () {},
          )
        ],
      ),
       body: FutureBuilder<List<Monitor>>(
        future: futMonitor,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum monitor encontrado.'));
          } else {
            final monitores = snapshot.data!;
            return ListView.builder(
              itemCount: monitores.length,
              itemBuilder: (context, index) {
                final monitor = monitores[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: monitor.avatar.isNotEmpty
                        ? NetworkImage(monitor.avatar)
                        : null,
                    child: monitor.avatar.isEmpty ? Icon(Icons.person) : null,
                  ),
                  title: Text(monitor.nome),
                  subtitle:
                      Text('${monitor.horarios.length} horários disponíveis'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HorariosView(monitor: monitor),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}