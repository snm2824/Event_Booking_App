import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_geodata_app/input_values.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _len;
  var _bre;
  var _new;
  final con = new TextEditingController();
  final con2 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          title: Text('Input values'),
        ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: con,
                      decoration: InputDecoration(hintText: 'Enter Height'),
                    ),
                    TextField(
                      controller: con2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: 'Enter Width'),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(
                            () {
                              _len = con.text;
                              _bre = con2.text;
                              _new = _len * _bre;
                            },
                          );
                        },
                        child: Text('Submit')),
                    Text('Toal cost is $_len*$_bre'),
                  ],
                ))) //s trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
