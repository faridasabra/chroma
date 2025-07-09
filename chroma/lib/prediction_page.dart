import 'package:flutter/material.dart';
import 'package:chroma/api_services.dart';

class PredictionPage extends StatefulWidget {
  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  String result = 'No prediction yet';

  void getPrediction() async {
    try {
      String subCategory = await getPredictedSubCategory(
        baseColour: 'Blue',
        season: 'Summer',
        gender: 'Women',
        usage: 'Casual',
      );

      setState(() {
        result = 'Predicted subCategory: $subCategory';
      });
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CHROMA Style Predictor')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(result, textAlign: TextAlign.center),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: getPrediction,
              child: Text('Get Prediction'),
            ),
          ],
        ),
      ),
    );
  }
}
