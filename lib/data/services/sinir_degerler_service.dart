import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sinir_degerler_response.dart';

class SinirDegerlerService {
  static const String _apiUrl =
      'https://tsrcekapws.kik.gov.tr/KikServisleri/MobilCihazBilgiServisi.svc/Rest/SinirDegerler';

  Future<SinirDegerlerResponse> fetchSinirDegerler() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return SinirDegerlerResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
