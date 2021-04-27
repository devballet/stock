import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stock/model/PracticeModel.dart'
    show PracticeModel, practiceModel;
import 'package:stock/model/StockValueDTO.dart';

class PracticeBuy extends StatelessWidget {
  //const PracticeBuy({Key key}) : super(key: key);

  final int maxHeight = 160;
  final ScrollController _scrollController = ScrollController();

  //스크롤을 마지막으로 이동한다.
  void ScrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      } else {}
    });
  }
  double buyReadyValue = 0;
  double totalValue = 0;
  //계산 로직!!!!
  void Calc(StockValueDTO item) {
    if (buyReadyValue != 0) {
      totalValue = totalValue + buyReadyValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PracticeModel>(
        model: practiceModel,
        child: ScopedModelDescendant<PracticeModel>(builder:
            (BuildContext inContext, Widget inChild, PracticeModel inModel) {
          return Row(
            children: [
              Container(
                  color: Colors.red,
                  width: 100,
                  child: Card(
                    //shadowColor: Colors.blue,
                    color: Colors.white,
                    //margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 2,
                    child: Column(
                      children: [Text("$totalValue"), Text("$buyReadyValue"), Text("test")],
                    ),
                  )),
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
                                  practiceModel.tempStockValueList[inIndex];

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

                              return isVisible
                                  ? Container(
                                      //color: Colors.brown,
                                      color: isBuy ? Colors.green[500] : null,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text("$percent"),
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
