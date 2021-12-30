import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Page1(),
    );
  }
}

class Page1 extends StatefulWidget {
  Page1({Key key}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {

  static double maxImageRadius = 200.0;
  static double minImageRadius = 10.0;

  Random seed = Random();
  double imageRadius;

  @override
  void initState() {
    setState(() {
      imageRadius = randomNumberMinMax(minImageRadius.toInt(), maxImageRadius.toInt()).toDouble();
    });
    super.initState();
  }

  int randomNumberMinMax(int min, int max){
    int randomminmax = min + Random().nextInt(max - min);
    //generate random number within minimum and maximum value
    return randomminmax;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Page2(lastRadiusImage: imageRadius,)));
            },
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/image.jpg"),
              radius: imageRadius,
            ),
          )
        )
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "remove1",
              onPressed: () {
                int randomNumber = randomNumberMinMax(10, 30); 
                setState(() {
                  if (imageRadius - randomNumber.toDouble() > minImageRadius) {
                    imageRadius -= randomNumber.toDouble();
                  }
                });
              },
              child: const Icon(Icons.remove),
            ), 
            FloatingActionButton(
              heroTag: "remove2",
              onPressed: () {
                int randomNumber = randomNumberMinMax(10, 30); 
                setState(() {
                  if (imageRadius + randomNumber.toDouble() < maxImageRadius) {
                    imageRadius += randomNumber.toDouble();
                  }
                });
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      )
    );
  }
}

class Page2 extends StatefulWidget {
  Page2({Key key, this.lastRadiusImage}) : super(key: key);
  final double lastRadiusImage;

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  Random seed = Random();
  double imageRadius;

  double maxImageRadius = 200.0;
  double minImageRadius = 10.0;
  double reduced = 800.0;

  int randomNumberMinMax(int min, int max){
    int randomMinMax = min + Random().nextInt(max - min);
    //generate random number within minimum and maximum value
    return randomMinMax;
  }

  @override
  void initState() {
    setState(() {
      imageRadius = reduced - widget.lastRadiusImage + randomNumberMinMax(minImageRadius.toInt(), maxImageRadius.toInt()).toDouble();
    });
    print(imageRadius);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Page1()));
            },
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/image.jpg"),
              radius: imageRadius,
            ),
          )
        )
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "remove3",
              onPressed: () {
                int randomNumber = randomNumberMinMax(10, 30); 
                setState(() {
                  if (imageRadius - randomNumber.toDouble() > minImageRadius) {
                    double normalValue = reduced - widget.lastRadiusImage +imageRadius - randomNumber.toDouble();
                    imageRadius -= randomNumber.toDouble(); // Заменить после = весь текст на normalValue, а перед равно убрать +
                  }
                });
                print(imageRadius);
              },
              child: const Icon(Icons.remove),
            ), 
            FloatingActionButton(
              heroTag: "remove4",
              onPressed: () {
                int randomNumber = randomNumberMinMax(10, 30); 
                setState(() {
                  if (imageRadius + randomNumber.toDouble() < maxImageRadius) {
                    double normalValue = reduced - widget.lastRadiusImage +imageRadius + randomNumber.toDouble();
                    imageRadius += randomNumber.toDouble(); // Заменить после = весь текст на normalValue, а перед равно убрать +
                  }
                });
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      )
    );
  }
}