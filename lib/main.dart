import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConversionApp());
}

class TemperatureConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TemperatureConversionHomePage(),
    );
  }
}

class TemperatureConversionHomePage extends StatefulWidget {
  @override
  _TemperatureConversionHomePageState createState() =>
      _TemperatureConversionHomePageState();
}

class _TemperatureConversionHomePageState
    extends State<TemperatureConversionHomePage> {
  String _conversionType = 'F to C';
  TextEditingController _inputController = TextEditingController();
  String _result = '';
  List<String> _history = [];

  void _convertTemperature() {
    double inputValue = double.tryParse(_inputController.text) ?? 0.0;
    double resultValue;
    String historyEntry;

    if (_conversionType == 'F to C') {
      resultValue = (inputValue - 32) * 5 / 9;
      historyEntry = 'F to C: $inputValue => ${resultValue.toStringAsFixed(2)}';
    } else {
      resultValue = inputValue * 9 / 5 + 32;
      historyEntry = 'C to F: $inputValue => ${resultValue.toStringAsFixed(2)}';
    }

    setState(() {
      _result = resultValue.toStringAsFixed(2);
      _history.add(historyEntry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Conversion App'),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('F to C'),
                    leading: Radio<String>(
                      value: 'F to C',
                      groupValue: _conversionType,
                      onChanged: (String? value) {
                        setState(() {
                          _conversionType = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('C to F'),
                    leading: Radio<String>(
                      value: 'C to F',
                      groupValue: _conversionType,
                      onChanged: (String? value) {
                        setState(() {
                          _conversionType = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter temperature',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: Text('Convert'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Result: $_result',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: ListTile(
                      title: Text(
                        _history[index],
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
