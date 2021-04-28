import 'package:flutter/material.dart';
import 'package:stock/stock/Practice.dart';
import 'package:stock/stock/stock.dart';

List<Color> themeColors = [
  Color(0xfff39805),
  Color(0xfff37806),
  Color(0xff044f4d),
  Color(0xff123b3a),
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      color: Color(0xffecc78a),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: AppBar(
              elevation: 20,
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.list), text: "목록"),
                  Tab(icon: Icon(Icons.my_library_books), text: "가상투자"),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Stock(),
              Practice(),
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: _incrementCounter,
          //   tooltip: 'Increment',
          //   child: Icon(Icons.add),
          // ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}
