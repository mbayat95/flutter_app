import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _response = '';

  Future<void> _sendData() async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/data'), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'data': _controller.text,
      }),
    );

    setState(() {
      _response = response.body;
    });
  }

  Future<void> _getData() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/api/data'), 
    );

    setState(() {
      _response = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Enter Data'),
            ),
            ElevatedButton(
              onPressed: _sendData,
              child: Text('Send Data'),
            ),
            ElevatedButton(
              onPressed: _getData,
              child: Text('Get Data'),
            ),
            Text(_response),
          ],
        ),
      ),
    );
  }
}
