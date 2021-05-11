import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stock/core/OHLCGraphNew.dart';
import 'package:stock/core/coreLibrary.dart';
import 'package:stock/core/widgets.dart';
import 'package:stock/datatable/aiDTO.dart';
import 'package:stock/datatable/resultDataDTO.dart';
import 'package:stock/model/StockDTO.dart';
import 'package:stock/model/PracticeModel.dart'
    show PracticeModel, practiceModel;
import 'package:stock/model/StockValueDTO.dart';
import 'package:flutter_candlesticks/flutter_candlesticks.dart';
import 'package:stock/popup/BuyPopup.dart';
import 'package:stock/popup/PracticeInputPopup.dart';
import 'package:stock/stock/PracticeBuy.dart';
// import 'package:stock/stock/PracticeBuy2.dart';
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
  PracticeBuy buyAi1 = new PracticeBuy();
  PracticeBuy buyAi2 = new PracticeBuy();
  PracticeBuy buyAi3 = new PracticeBuy();
  PracticeBuy buyAi4 = new PracticeBuy();
  //PracticeBuy2 buy2 = new PracticeBuy2();
  //const StockDetailInfo({Key key}) : super(key: key);
  PracticeDetailValue() {}
  final ScrollController _scrollController = ScrollController();
  StockValueDTO lastSelectedDTO;
  //클리어
  void Clear() {
    if (practiceModel.stockValueList != null) {
      //초기화
      // practiceModel.stockValueList.forEach((item){
      //   item.isBuy1 = false;
      //   item.buyValue = null;
      //   item.currentPercent = "";
      // });

    }

    if (practiceModel.tempStockValueList != null) {
      practiceModel.tempStockValueList.clear();
      sampleData.clear();
      practiceModel.setNoti();
      dataCount = 0;
      lastSelectedDTO = null;
    }
  }

  //주식정보 추가
  void AddStockValue() {}

  bool isBuy = false;
  //구매
  void Buy(BuildContext context) {
    if (lastSelectedDTO == null) return;
    ResultData inputData = new ResultData();
    inputData.resultObject = lastSelectedDTO;

    Widget itemPopup = BuyPopup(context, inputData);

    showPopup(context, itemPopup, "구매").then<void>((Object value) {
      if (value != null) {
        ResultData resultData = value as ResultData;
        int buyCount = int.parse(resultData.resultString);
        //int price = int.parse(resultData.resultString2);

        //buy1.buyCount = buy1.buyCount + buyCount;
        //buy1.price = buy1.price + price;

        buy1.AddBuyStock(buyCount);
        buy1.Calc();
      }
    });

    // buy1.buyReadyValue = buy1.buyReadyValue + 50000;

    // buy2.buyReadyValue = buy2.buyReadyValue + 50000;
    // practiceModel.setNoti();
  }

//다음 거래일 이동
  void Next(int days) {
    for (int i = 0; i < days; i++) {
      if (practiceModel.stockValueList != null) {
        //int dataCount = this.data.length;
        StockValueDTO orgItem =
            practiceModel.stockValueList.elementAt(dataCount);

        lastSelectedDTO = orgItem;
        String date = orgItem.date;
        //String close = item.close;

        double open = double.parse(orgItem.open);
        double high = double.parse(orgItem.high);
        double low = double.parse(orgItem.low);
        double valume = double.parse(orgItem.valume);
        double close = double.parse(orgItem.close);

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

        StockValueDTO item = orgItem.Clone();
        buy1.lastSelectedDTO = item;
        buy1.AddStock(item);

        buy1.Calc();
        buy1.ScrollToEnd();

        //AI 버전...시작

        StockValueDTO item2 = orgItem.Clone();
        buyAi1.lastSelectedDTO = item2;
        buyAi1.AddStock(item2);

        AiDTO aiDTO1 = new AiDTO();
        aiDTO1.ifdayUp = true;
        aiDTO1.days = 1;

        buyAi1.AiMethod(aiDTO1); //판단!!!!!!!!!!!!!!!!!!
        buyAi1.Calc();
        buyAi1.ScrollToEnd();

        StockValueDTO item3 = orgItem.Clone();
        buyAi2.lastSelectedDTO = item3;
        buyAi2.AddStock(item3);

        AiDTO aiDTO2 = new AiDTO();
        aiDTO2.ifdayDown = true;
        aiDTO2.days = 1;
        buyAi2.AiMethod(aiDTO2); //판단!!!!!!!!!!!!!!!!!!
        buyAi2.Calc();
        buyAi2.ScrollToEnd();

        StockValueDTO item4 = orgItem.Clone();
        buyAi3.lastSelectedDTO = item4;
        buyAi3.AddStock(item4);

        AiDTO aiDTO3 = new AiDTO();
        aiDTO3.ifdayUp = true;
        aiDTO3.days = 3;
        buyAi3.AiMethod(aiDTO3); //판단!!!!!!!!!!!!!!!!!!
        buyAi3.Calc();
        buyAi3.ScrollToEnd();

        StockValueDTO item5 = orgItem.Clone();
        buyAi4.lastSelectedDTO = item5;
        buyAi4.AddStock(item5);

        AiDTO aiDTO4 = new AiDTO();
        aiDTO4.ifdayUp = true;
        aiDTO4.days = 4;
        buyAi4.AiMethod(aiDTO4); //판단!!!!!!!!!!!!!!!!!!
        buyAi4.Calc();
        buyAi4.ScrollToEnd();

        practiceModel.setNoti();
      }
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
    String codeName = "LG전자?";
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
                          buy1.Clear();
                          buyAi1.Clear();
                          buyAi2.Clear();
                          buyAi3.Clear();
                          buyAi4.Clear();
                        }),
                    Spacer(),
                    FlatButton(
                        child: Text("다음거래일"),
                        onPressed: () {
                          Next(1);
                        }),
                    Spacer(),
                    FlatButton(
                        child: Text("+7"),
                        onPressed: () {
                          Next(7);
                        }),
                    Spacer(),
                    FlatButton(
                        child: Text("구매"),
                        onPressed: () {
                          Buy(inContext);
                        })
                  ])),
              body: Container(
                color: Colors.black45,
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 2,
                              child: Container(
                                  height: 30,
                                  child: Center(
                                      child: JnSimpleText(
                                    title: "$codeName",
                                  ))),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      //height: 350,
                      child: Card(
                        elevation: 2,
                        child: Container(
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
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Row(
                        children: [
                          Spacer(),
                          FlatButton(
                            color: Colors.red[400],
                            child: Column(children: [
                              Text("가상투자1"),
                              Text(buyAi1.currentPercent + "%")
                            ]),
                            onPressed: () {
                              inModel.aiIndex = 0;
                              inModel.setNoti();
                            },
                          ),
                          Spacer(),
                          FlatButton(
                            color: Colors.red[400],
                            child: Column(children: [
                              Text("가상투자2"),
                              Text(buyAi2.currentPercent + "%")
                            ]),
                            onPressed: () {
                              inModel.aiIndex = 1;
                              inModel.setNoti();
                            },
                          ),
                          Spacer(),
                          FlatButton(
                            color: Colors.red[400],
                            child: Column(children: [
                              Text("가상투자3"),
                              Text(buyAi3.currentPercent + "%")
                            ]),
                            onPressed: () {
                              inModel.aiIndex = 2;
                              inModel.setNoti();
                            },
                          ),
                          Spacer(),
                          FlatButton(
                            color: Colors.red[400],
                            child: Column(children: [
                              Text("가상투자4"),
                              Text(buyAi4.currentPercent + "%")
                            ]),
                            onPressed: () {
                              inModel.aiIndex = 3;
                              inModel.setNoti();
                            },
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Container(
                          height: 150,
                          child: buy1,
                        ),
                    IndexedStack(
                      index: inModel.aiIndex,
                      children: [
                        Container(
                          height: 150,
                          child: buyAi1,
                        ),
                        Container(
                          height: 150,
                          child: buyAi2,
                        ),
                        Container(
                          height: 150,
                          child: buyAi3,
                        ),
                        Container(
                          height: 150,
                          child: buyAi4,
                        ),
                      ],
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
