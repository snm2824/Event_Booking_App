import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color rectColor = Color(0xff000000);
Size rectSize = Size(200, 150);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TutorialKart',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter - www.tutorialkart.com'),
      ),
      body: ListView(children: <Widget>[
        Text(
          'My Canvas',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        Container(
          width: 400,
          height: 400,
          child: CustomPaint(
            painter: OpenPainter(),
          ),
        ),
        RaisedButton(
          child: Text('Repaint Canvas'),
          onPressed: () {
            setState(() {
              rectColor = Color(0xff885599);
              rectSize = Size(200, 250);
            });
          },
        ),
      ]),
    );
  }
}

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = rectColor
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(100, 100) & rectSize, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
