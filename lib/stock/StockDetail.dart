import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stock/core/widgets.dart';
import 'package:stock/model/StockDTO.dart';
import 'package:stock/model/StockModel.dart' show StockModel, stockModel;
import 'package:stock/stock/StockDetailInfo.dart';
import 'package:stock/stock/StockDetailNoti.dart';
import 'package:stock/stock/StockDetailValue.dart';

class StockDetail extends StatelessWidget {
  //const StockDetail({Key key}) : super(key: key);

  //-------------------------------------
  // function 명 : StockDetail
  // function desc : 생성자
  //-------------------------------------
  StockDetail() {
    if (stockModel.selectedDTO != null) {}
    //  if (selectedRow = null)
    //  {

    //  }
  }

  @override
  Widget build(BuildContext context) {
    StockDTO selectedRow = stockModel.selectedDTO;

    
    //여기서 데이터를 조회한다.
    if (stockModel.lastSelectedCode != selectedRow.code) {
      stockModel.SelectValue(context, selectedRow.code);
      stockModel.lastSelectedCode = stockModel.selectedDTO.code; //마지막 선택된 code
    }

    return ScopedModel<StockModel>(
      model: stockModel,
      child: ScopedModelDescendant<StockModel>(
        builder: (BuildContext inContext, Widget inChild, StockModel inModel) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                      elevation: 8,
                      child: Container(
                        height: 200,
                        color: Colors.black38,
                        child: StockDetailInfo(),
                      )),
                  Card(
                      elevation: 8,
                      child: Container(
                        height: 300,
                        color: Colors.black38,
                        child: Column(
                          children: [
                            SimpleTitleLevel1(
                              title: "차트",
                            ),
                            Expanded(
                              child: StockDetailValue(),
                            ),
                          ],
                        ),
                      )),
                  Card(
                      elevation: 8,
                      child: Container(
                        height: 200,
                        color: Colors.black38,
                        child: Column(
                          children: [
                            SimpleTitleLevel1(
                              title: "게시판",
                            ),
                            Expanded(
                              child: StockDetailNoti(),
                            ),
                          ],
                        ),
                      )),
                  Card(
                      elevation: 8,
                      child: Container(
                        height: 100,
                        color: Colors.red,
                      )),
                  Card(
                      elevation: 8,
                      child: Container(
                        height: 100,
                        color: Colors.red,
                      )),
                  Card(
                      elevation: 8,
                      child: Container(
                        height: 100,
                        color: Colors.red,
                      )),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Row(children: [
                  FlatButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        // Hide soft keyboard.
                        FocusScope.of(inContext).requestFocus(FocusNode());
                        // Go back to the list view.
                        inModel.setStackIndex(0);
                      }),
                  Spacer(),
                  FlatButton(child: Text("Save"), onPressed: () {})
                ])),
          );
        },
      ),
    );
  }
}
