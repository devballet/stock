import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stock/core/OHLCGraphNew.dart';
import 'package:stock/core/widgets.dart';
import 'package:stock/model/StockDTO.dart';
import 'package:stock/model/PracticeModel.dart'
    show PracticeModel, practiceModel;
import 'package:stock/model/StockValueDTO.dart';
import 'package:flutter_candlesticks/flutter_candlesticks.dart';
import 'package:stock/stock/PracticeBuy.dart';
import 'package:stock/stock/PracticeBuy2.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class PracticeDetailValue extends StatelessWidget {
  final int maxHeight = 160;
  int count = 0;
  PracticeBuy buy1 = new PracticeBuy();
  PracticeBuy2 buy2 = new PracticeBuy2();
  //const StockDetailInfo({Key key}) : super(key: key);
  PracticeDetailValue() {}
  final ScrollController _scrollController = ScrollController();
  StockValueDTO lastSelectedDTO;
  //클리어
  void Clear() {
    if (practiceModel.tempStockValueList != null) {
      practiceModel.tempStockValueList.clear();
      sampleData.clear();
      practiceModel.setNoti();
      dataCount = 0;
      lastSelectedDTO = null;
    }
  }

  bool isBuy = false;
  //구매
  void Buy() {
    buy1.buyReadyValue = buy1.buyReadyValue + 50000;

    buy2.buyReadyValue = buy2.buyReadyValue + 50000;
    practiceModel.setNoti();
  }

//다음 거래일 이동
  void Next() {
    if (practiceModel.stockValueList != null) {
      //int dataCount = this.data.length;
      StockValueDTO item = practiceModel.stockValueList.elementAt(dataCount);
      lastSelectedDTO = item;
      String date = item.date;
      //String close = item.close;

      double open = double.parse(item.open);
      double high = double.parse(item.high);
      double low = double.parse(item.low);
      double valume = double.parse(item.valume);
      double close = double.parse(item.close);

      dynamic temp = {
        "open": open,
        "high": high,
        "low": low,
        "close": close,
        "volumeto": valume
      };

      sampleData.add(temp);

      dataCount++;

      //item.isBuy1 = false;

      practiceModel.tempStockValueList.add(item);
      buy1.Calc(lastSelectedDTO);
      buy1.ScrollToEnd();

      buy2.Calc(lastSelectedDTO);
      buy2.ScrollToEnd();

      practiceModel.setNoti();
    }
  }

  List sampleData = [
    // {"open": 50.0, "high": 100.0, "low": 40.0, "close": 80, "volumeto": 5000.0},
    // {"open": 80.0, "high": 90.0, "low": 55.0, "close": 65, "volumeto": 4000.0},
    // {"open": 65.0, "high": 120.0, "low": 60.0, "close": 90, "volumeto": 7000.0},
    // {"open": 90.0, "high": 95.0, "low": 85.0, "close": 80, "volumeto": 2000.0},
    // {"open": 80.0, "high": 85.0, "low": 40.0, "close": 50, "volumeto": 3000.0},
    // {"open": 50.0, "high": 100.0, "low": 40.0, "close": 80, "volumeto": 5000.0},
    // {"open": 80.0, "high": 90.0, "low": 55.0, "close": 65, "volumeto": 4000.0},
    // {"open": 65.0, "high": 120.0, "low": 60.0, "close": 90, "volumeto": 7000.0},
    // {"open": 90.0, "high": 95.0, "low": 85.0, "close": 80, "volumeto": 2000.0},
    // {"open": 80.0, "high": 85.0, "low": 40.0, "close": 50, "volumeto": 3000.0},
    // {"open": 50.0, "high": 100.0, "low": 40.0, "close": 80, "volumeto": 5000.0},
    // {"open": 80.0, "high": 90.0, "low": 55.0, "close": 65, "volumeto": 4000.0},
    // {"open": 65.0, "high": 120.0, "low": 60.0, "close": 90, "volumeto": 7000.0},
    // {"open": 90.0, "high": 95.0, "low": 85.0, "close": 80, "volumeto": 2000.0},
    // {"open": 80.0, "high": 85.0, "low": 40.0, "close": 50, "volumeto": 3000.0},
  ];

  int dataCount = 0;

  @override
  Widget build(BuildContext context) {
    String code = "034220";
    if (practiceModel.lastSelectedCode != code) {
      practiceModel.SelectValue(context, code);
      practiceModel.lastSelectedCode = code; //마지막 선택된 code
    }

    return ScopedModel<PracticeModel>(
      model: practiceModel,
      child: ScopedModelDescendant<PracticeModel>(
        builder:
            (BuildContext inContext, Widget inChild, PracticeModel inModel) {
          if (inModel.stockValueList == null) {
            return Center(
              child: Text("Error"),
            );
          } else {
            int count = 0;
            if (inModel.stockValueList != null) {
              count = inModel.stockValueList.length;
            }

            return Scaffold(
              bottomNavigationBar: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Row(children: [
                    FlatButton(
                        child: Text("초기화"),
                        onPressed: () {
                          Clear();
                        }),
                    Spacer(),
                    FlatButton(
                        child: Text("다음거래일"),
                        onPressed: () {
                          Next();
                        }),
                    Spacer(),
                    FlatButton(
                        child: Text("구매"),
                        onPressed: () {
                          Buy();
                        })
                  ])),
              body: Container(
                color: Colors.black45,
                child: Column(
                  children: [
                    //buy1,

                    // Container(
                    //   height: 150,
                    //   child: Card(
                    //     //shadowColor: Colors.blue,
                    //     color: Colors.white,
                    //     //margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(10.0)),
                    //     elevation: 2,
                    //     child: ListView.builder(
                    //         controller: _scrollController,
                    //         scrollDirection: Axis.horizontal,
                    //         itemCount: inModel.tempStockValueList.length,
                    //         itemBuilder:
                    //             (BuildContext inBuildContext, int inIndex) {
                    //           StockValueDTO row =
                    //               practiceModel.tempStockValueList[inIndex];

                    //           String percent = row.percent;
                    //           String yyyy = row.date.substring(0, 4);
                    //           String date = row.date.substring(4, 6) +
                    //               "-" +
                    //               row.date.substring(6, 8);
                    //           if (percent == null) {
                    //             percent = "0";
                    //           }

                    //           double iPer = double.parse(percent);
                    //           double height = iPer * maxHeight / 15;
                    //           if (height < 0) {
                    //             height = height * -1;
                    //           }
                    //           if (height > maxHeight) {
                    //             height = height;
                    //           }

                    //           bool isPlus = iPer > 0 ? true : false;

                    //           bool isVisible = true;

                    //           return isVisible
                    //               ? Container(
                    //                   //color: Colors.brown,
                    //                   color: iPer > 1 ? Colors.green[500] : null,
                    //                   child: Column(
                    //                     mainAxisAlignment: MainAxisAlignment.end,
                    //                     children: [
                    //                       Text("$percent"),
                    //                       Container(
                    //                           width: 40,
                    //                           padding:
                    //                               EdgeInsets.fromLTRB(1, 1, 1, 1),
                    //                           //row.percent
                    //                           child: Container(
                    //                             height: height,
                    //                             width: 30,
                    //                             color: isPlus
                    //                                 ? Colors.red
                    //                                 : Colors.blue,
                    //                           )),
                    //                       Text("$yyyy"),
                    //                       Text("$date"),
                    //                     ],
                    //                   ),
                    //                 )
                    //               : Container();
                    //         }),
                    //   ),
                    // ),
                    Container(
                      height: 400,
                      child: Card(
                        elevation: 2,
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                height: 300,
                                //color: Colors.red,
                                child: OHLCVGraphNew(
                                    data: sampleData,
                                    fallbackHeight: 100,
                                    lineWidth: 1,
                                    increaseColor: Colors.red,
                                    decreaseColor: Colors.blue,
                                    enableGridLines: true,
                                    labelPrefix: "",
                                    volumeProp: 0.2),
                              ),
                              // SimpleOutlineButton(
                              //   buttonText: "입력1",
                              //   isTokenIconVisible: false,
                              //   onPressed: () {
                              //     if (practiceModel.stockValueList != null) {
                              //       //int dataCount = this.data.length;
                              //       StockValueDTO item = practiceModel
                              //           .stockValueList
                              //           .elementAt(dataCount);
                              //       lastSelectedDTO = item;
                              //       String date = item.date;
                              //       //String close = item.close;

                              //       double open = double.parse(item.open);
                              //       double high = double.parse(item.high);
                              //       double low = double.parse(item.low);
                              //       double valume = double.parse(item.valume);
                              //       double close = double.parse(item.close);

                              //       dynamic temp = {
                              //         "open": open,
                              //         "high": high,
                              //         "low": low,
                              //         "close": close,
                              //         "volumeto": valume
                              //       };
                              //       sampleData.add(temp);
                              //       dataCount++;

                              //       //item.isBuy1 = true;

                              //       practiceModel.tempStockValueList.add(item);
                              //       //buy1.Calc();
                              //       buy1.ScrollToEnd();

                              //       practiceModel.setNoti();
                              //     }
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: buy2,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
