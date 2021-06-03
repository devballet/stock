import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock/model/ManuDTO.dart';
import 'package:stock/model/StockDTO.dart';
import 'package:stock/model/StockModel.dart' show StockModel;

class SearchStockMain extends StatefulWidget {
  @override
  _SearchStockMainState createState() => _SearchStockMainState();
}

class _SearchStockMainState extends State<SearchStockMain> {
  Color _themeColor;

  List<StockDTO> all = [];
  List<StockDTO> temp = [];
  List<StockDTO> filter = [];
  void runFilter(String keyword) {
    temp = [];
    if (keyword.isEmpty) {
      temp = all;
    } else {
      temp = all
          .where((element) =>
              element.name.toUpperCase().contains(keyword.toUpperCase()))
          .toList();
    }
    setState(() {
      filter = temp;
    });
  }

  @override
  void initState() {
    _themeColor = getMainThemeColor('/search');
    StockModel().getAllCompanyInfo().then((value) {
      setState(() {
        filter = value;
        all = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("종목검색"),
        backgroundColor: _themeColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 15),
              onChanged: (value) => runFilter(value),
              decoration: InputDecoration(
                hintText: "종목명",
                suffixIcon: Icon(
                  Icons.search,
                  color: _themeColor,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _themeColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _themeColor,
                    width: 2.5,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: filter.length > 0
                  ? ListView.builder(
                      itemCount: filter.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(filter[index].code),
                        elevation: 4,
                        margin: EdgeInsets.symmetric(
                          vertical: 7.0,
                          horizontal: 4.0,
                        ),
                        child: ListTile(
                            leading: Text(
                              filter[index].code,
                            ),
                            title: Text(filter[index].name),
                            subtitle: Text(filter[index].market),
                            trailing: GestureDetector(
                              onTap: () {
                                filter[index].isfavorite =
                                    !filter[index].isfavorite;
                                StockModel.saveFavorite();
                                setState(() {});
                              },
                              child: Icon(
                                Icons.star,
                                color: filter[index].isfavorite
                                    ? Colors.lightGreen
                                    : Colors.grey,
                              ),
                            )),
                      ),
                    )
                  : Text("No Result"),
            )
          ],
        ),
      ),
    );
  }
}
