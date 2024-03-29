import 'package:flutter/material.dart';
import 'package:stock/component/DetailInfoItem.dart';
import 'package:stock/page/StockInfoPopup.dart';
import 'package:stock/stock/Practice.dart';
import 'package:stock/stock/stock.dart';
import 'package:stock/model/ManuDTO.dart';
import 'package:stock/page/SearchStockMain.dart';
import 'package:http/http.dart' as http;

void main() async {
  /*
  String url = "https://192.168.0.56:3000/";

  var response = await http.get(url);
  var statusCode = response.statusCode;
  var responseHeaders = response.headers;
  var responseBody = response.body;

  print("statusCode : ${statusCode}");
  print("responseHeaders : ${responseHeaders}");
  print("responseBody : ${responseBody}");
  */

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Menu(),
        //'/': (context) => StockInfo(),
        '/search': (context) => SearchStockMain(),
        '/virtualinvestment': (context) => Practice(),
      },
    ),
  );
}

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<MenuDTO> menu = [];
  @override
  void initState() {
    menu = getMenuList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff06171e),
      appBar: AppBar(
        title: Text("Hello Guest"),
        backgroundColor: Color(0xffecc78a),
      ),
      body: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, menu[index].url);
            },
            child: Container(
              // This is the back container which will show next cell colour on the rounded edge
              color: index + 1 < menu.length
                  ? menu[index + 1]
                      .color // get next row background as back container background
                  : Colors
                      .transparent, // Otherwise keep it transparent to prevent out of bounds error
              child: Container(
                height: 180,
                decoration: new BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(85.0)),
                  color: menu[index].color,
                ),
                child: Center(
                  child: Text(
                    menu[index].title,
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
