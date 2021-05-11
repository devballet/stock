import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stock/core/coreLibrary.dart';
import 'package:stock/core/widgets.dart';
import 'package:stock/datatable/aiDTO.dart';
import 'package:stock/model/PracticeModel.dart';
//show PracticeModel, practiceModel;
import 'package:stock/model/StockValueDTO.dart';

class PracticeBuy extends StatelessWidget {
  //const PracticeBuy({Key key}) : super(key: key);

  PracticeModel myModel = new PracticeModel();
  final int maxHeight = 160;
  final ScrollController _scrollController = ScrollController();
  StockValueDTO lastSelectedDTO;
  CoreLibrary core = new CoreLibrary();

  //스크롤을 마지막으로 이동한다.
  void ScrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      } else {}
    });
  }

  //주식정보 추가
  void AddStock(StockValueDTO item) {
    myModel.tempStockValueList.add(item);
    myModel.setNoti();
  }

  double buyReadyValue = 0;
  double totalValue = 0;

  int buyCount = 0;
  int price = 0;
  //int currentPrice = 0; //평가금액
  //double currnetPercent = 0; //수익률
  String currentPercent = ""; //수익률
  int currentPrice = 0; //현재금액
  int resultPrice = 0; //평가손익

  int count = 0;
  //Ai판단 메소드
  void AiMethod(AiDTO aiDTO) {
    if (aiDTO == null) return;

    int listCount = myModel.tempStockValueList.length;

    bool isBuy = false;
    //1. A 거래일 하락시 구매
    if (aiDTO.ifdayDown) {
      int ifDayDownCount = 0;
      for (int i = listCount - 1; i >= 0; i--) {
        StockValueDTO item = myModel.tempStockValueList[i];
        if (double.parse(item.percent) < 0) {
          ifDayDownCount++;
        } else {
          break;
        }

        if (ifDayDownCount >= aiDTO.days) {
          isBuy = true;
          break;
        }
      }
    }

    //2.  A 거래일 상승시 구매
    if (aiDTO.ifdayUp) {
      int ifDayUpCount = 0;
      for (int i = listCount - 1; i >= 0; i--) {
        StockValueDTO item = myModel.tempStockValueList[i];
        if (double.parse(item.percent) > 0) {
          ifDayUpCount++;
        } else {
          break;
        }

        if (ifDayUpCount >= aiDTO.days) {
          isBuy = true;
          break;
        }
      }
    }

    //3. A거래일 합산 퍼센트 B이하일때 구매
    if (aiDTO.ifDayPercentDown) {
      if (listCount >= aiDTO.days) {
        for (int i = listCount - 1; i >= 0; i--) {
          StockValueDTO item = myModel.tempStockValueList[i];

          // if (ifDayUpCount >= aiDTO.days) {
          //   isBuy = true;
          //   break;
          // }
        }
      }

      int ifDayCount = 0;
    }

    if (isBuy == true) {
      AddBuyStock(20);
    }
  }

  //신규 주식 추가시
  void AddBuyStock(int count) {
    int price = count * int.parse(lastSelectedDTO.close);

    this.buyCount = buyCount + count;
    this.price = this.price + price;
  }

  //계산 로직!!!!
  void Calc() {
    if (lastSelectedDTO == null) return;

    lastSelectedDTO.buyValue = buyCount;

    currentPrice = int.parse(lastSelectedDTO.close) * buyCount;

    double per = (currentPrice / price * 100) - 100;
    this.currentPercent = per.toStringAsFixed(2);
    resultPrice = currentPrice - price; //평가금액

    //그래프에 표시하기 위한 정보를 넣어준다.
    if (buyCount > 0) {
      //lastSelectedDTO.isBuy1 = true;
      lastSelectedDTO.buyValue = buyCount;
      lastSelectedDTO.currentPercent = currentPercent;
    }

    myModel.setNoti();
  }

  void Clear() {
    this.buyCount = 0;
    this.price = 0; //매수금액
    this.currentPercent = ""; //수익률
    this.currentPrice = 0; //현재금액
    this.resultPrice = 0; //평가손익

    if (myModel.tempStockValueList != null) {
      myModel.tempStockValueList.clear();
      myModel.setNoti();
      lastSelectedDTO = null;
    }

    myModel.setNoti();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PracticeModel>(
        model: myModel,
        child: ScopedModelDescendant<PracticeModel>(builder:
            (BuildContext inContext, Widget inChild, PracticeModel inModel) {
          String currentPriceWithComma = core.numberWithComma(currentPrice);
          String resultPriceWithComma = core.numberWithComma(resultPrice);
          String priceWithComma = core.numberWithComma(price);

          bool isUp = false;
          if (resultPrice > 0) {
            isUp = true;
          }
          return Row(
            children: [
              Expanded(
                child: Container(
                    //color: Colors.red,
                    width: 300,
                    child: Card(
                      //shadowColor: Colors.blue,
                      color: Colors.white,
                      //margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 2,
                      child: Column(
                        children: [
                          JnSimpleTitle(
                            fontSize: 16,
                            title: "매수금액 : $priceWithComma",
                          ),
                          JnSimpleTitle(
                            fontSize: 16,
                            title: "현재가격 : $currentPriceWithComma",
                          ),
                          JnSimpleTitle(
                            fontSize: 16,
                            title: "보유수량 : $buyCount",
                          ),
                          JnSimpleTitle(
                            selectedColor:
                                isUp == true ? Colors.red : Colors.blue,
                            title: "수익률 : $currentPercent%",
                          ),
                          JnSimpleTitle(
                            selectedColor:
                                isUp == true ? Colors.red : Colors.blue,
                            title: "평가손익 : $resultPriceWithComma",
                          ),
                        ],
                      ),
                    )),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      child: Card(
                        //shadowColor: Colors.blue,
                        color: Colors.white,
                        //margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        elevation: 2,
                        child: ListView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: inModel.tempStockValueList.length,
                            itemBuilder:
                                (BuildContext inBuildContext, int inIndex) {
                              StockValueDTO row =
                                  inModel.tempStockValueList[inIndex];

                              String percent = row.percent;
                              String yyyy = row.date.substring(0, 4);
                              String date = row.date.substring(4, 6) +
                                  "-" +
                                  row.date.substring(6, 8);
                              if (percent == null) {
                                percent = "0";
                              }

                              double iPer = double.parse(percent);
                              double height = iPer * maxHeight / 15;
                              if (height < 0) {
                                height = height * -1;
                              }
                              if (height > maxHeight) {
                                height = height;
                              }

                              bool isPlus = iPer > 0 ? true : false;

                              bool isVisible = true;

                              bool isBuy = false;
                              if (row.isBuy1 == true) {
                                isBuy = true;
                              }
                              String buyValue = "";
                              if (row.buyValue != null) {
                                buyValue = row.buyValue.toString();
                              }

                              return isVisible
                                  ? Container(
                                      //color: Colors.brown,
                                      color: isBuy ? Colors.green[500] : null,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            height: 30,
                                            child: Text("$buyValue"),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(),
                                          ),
                                          Container(
                                            height: 20,
                                            child: Text("$percent"),
                                          ),
                                          Container(
                                              width: 40,
                                              padding: EdgeInsets.fromLTRB(
                                                  1, 1, 1, 1),
                                              //row.percent
                                              child: Container(
                                                height: height,
                                                width: 30,
                                                color: isPlus
                                                    ? Colors.red
                                                    : Colors.blue,
                                              )),
                                          Text("$yyyy"),
                                          Text("$date"),
                                        ],
                                      ),
                                    )
                                  : Container();
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
