//2021.05.xx
//박해나 작성
//종목검색 화면
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock/core/coreLibrary.dart';
import 'package:stock/model/ManuDTO.dart';
import 'package:stock/model/StockDTO.dart';
import 'package:stock/model/StockModel.dart' show StockModel;
import 'package:stock/page/StockInfoPopup.dart';

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
              flex: 1,
              child: filter.length > 0
                  ? ListView(
                      children: List.generate(
                        filter.length,
                        (i) => AnimatedListItem(
                          i,
                          filter[i],
                          key: ValueKey(filter[i].code),
                        ),
                      ),
                    )
                  : Text("No Result"),
            ),
            // Visibility(
            //   visible: true,
            //   child: StockInfo(),
            // )
          ],
        ),
      ),
    );
  }
}

class AnimatedListItem extends StatefulWidget {
  final int index;
  final StockDTO item;

  AnimatedListItem(this.index, this.item, {Key key}) : super(key: key);

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem> {
  bool _animate = false;
  static bool _isStart = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isStart
        ? Future.delayed(Duration(milliseconds: widget.index * 300), () {
            setState(() {
              _animate = true;
              _isStart = false;
            });
          })
        : _animate = true;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 1000),
      opacity: _animate ? 1 : 0,
      curve: Curves.easeInOutQuart,
      child: AnimatedPadding(
        duration: Duration(milliseconds: 1000),
        padding: _animate
            ? const EdgeInsets.all(4.0)
            : const EdgeInsets.only(top: 10),
        child: Container(
          constraints: BoxConstraints.expand(height: 100),
          child: Card(
            key: ValueKey(widget.item.code),
            elevation: 4,
            margin: EdgeInsets.symmetric(
              vertical: 7.0,
              horizontal: 4.0,
            ),
            child: ListTile(
              leading: Text(
                widget.item.code,
              ),
              title: Text(widget.item.name),
              subtitle: Text(widget.item.market),
              trailing: GestureDetector(
                onTap: () {
                  widget.item.isfavorite = !widget.item.isfavorite;
                  StockModel.saveFavorite();
                },
                child: Icon(
                  Icons.star,
                  color:
                      widget.item.isfavorite ? Colors.lightGreen : Colors.grey,
                ),
              ),
              onTap: () {
                showGeneralDialog(
                  context: context,
                  barrierLabel: "Hello there",
                  barrierDismissible: true,
                  transitionDuration:
                      Duration(milliseconds: 500), //This is time
                  barrierColor: Colors.black
                      .withOpacity(0.5), // Add this property is color
                  pageBuilder: (BuildContext context, Animation animation,
                      Animation secondaryAnimation) {
                    return StockInfo();
                  },
                );
                // showGeneralDialog(
                //     barrierColor: Colors.black.withOpacity(0.5),
                //     transitionBuilder: (context, a1, a2, widget) {
                //       return Transform.scale(
                //         scale: a1.value,
                //         child: Opacity(
                //           opacity: a1.value,
                //           child: AlertDialog(
                //             shape: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(16.0)),
                //             title: Text('Hello!!'),
                //             content: Text('How are you?'),
                //           ),
                //         ),
                //       );
                //     },
                //     transitionDuration: Duration(milliseconds: 200),
                //     barrierDismissible: true,
                //     barrierLabel: '',
                //     context: context,
                //     pageBuilder: (context, animation1, animation2) {});
                //selectItem();
                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return Container(
                //       height: 300,
                //       child: StockInfo(),
                //     );
                //   },
                // );
              },
            ),
          ),
        ),
      ),
    );
  }

  void selectItem() {}
}
