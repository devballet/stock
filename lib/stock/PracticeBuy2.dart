import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stock/model/PracticeModel.dart'
    show PracticeModel, practiceModel;
import 'package:stock/model/StockValueDTO.dart';

class PracticeBuy2 extends StatelessWidget {
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
              
            ],
          );
        }));
  }
}
