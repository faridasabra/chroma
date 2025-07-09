import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> getPredictedSubCategory({
  required String baseColour,
  required String season,
  required String gender,
  required String usage,
}) async {
  final url = Uri.parse('http://192.168.197.1:5000/predict');

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "baseColour": baseColour,
      "season": season,
      "gender": gender,
      "usage": usage,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['predicted_subCategory'];
  } else {
    throw Exception('Failed to get prediction: ${response.body}');
  }
}
