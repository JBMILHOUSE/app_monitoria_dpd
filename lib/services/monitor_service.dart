import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/monitor.dart';

class MonitorApiService {
  static const String _baseUrl = 'http://localhost:3333';

  // Método para buscar monitores
  static Future<List<Monitor>> fetchMonitores() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/monitores'));
      print('Status code: ${response.statusCode}');
       print('body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Decodifica o JSON para uma lista de monitores
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Monitor.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao buscar monitores: ${response.statusCode}');
      }
    } catch (e) {
        print('Erro na API: $e');
      return [];
    }
  }
}