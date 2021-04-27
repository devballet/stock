import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stock/model/StockDTO.dart';
import 'package:stock/model/StockModel.dart' show StockModel, stockModel;
import 'package:stock/model/StockValueDTO.dart';

class StockDetailValue extends StatelessWidget {
  final int maxHeight = 160;
  //const StockDetailInfo({Key key}) : super(key: key);
  StockDetailValue() {}



  // InitData(){
  //   if ( stockModel != null && stockModel.selectedDTO != null)
  //   {
  //     StockDTO selectedDTO = stockModel.selectedDTO;
  //     selectedDTO.name;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<StockModel>(
      model: stockModel,
      child: ScopedModelDescendant<StockModel>(
        builder: (BuildContext inContext, Widget inChild, StockModel inModel) {
          if (inModel.selectedDTO == null) {
            return Center(
              child: Text("Error"),
            );
          } else {
            int count = 0;
            if (inModel.stockValueList != null) {
              count = inModel.stockValueList.length;
            }

            return Container(
              color: Colors.black45,
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
                          scrollDirection: Axis.horizontal,
                          itemCount: inModel.stockValueList.length,
                          itemBuilder:
                              (BuildContext inBuildContext, int inIndex) {
                            StockValueDTO row =
                                stockModel.stockValueList[inIndex];

                            String percent = row.percent;
                            String yyyy = row.date.substring(0,4);
                            String date = row.date.substring(4,6) + "-" + row.date.substring(6,8);
                            if (percent == null) {
                              percent = "0";
                            }

                            
                            
                            
                            double iPer = double.parse(percent);
                            double height = iPer * maxHeight /15;
                            if ( height < 0)
                            {
                              height = height * -1;
                            }
                            if ( height > maxHeight)
                            {
                              height = height;
                            }
                            
                            
                            
                            
                            bool isPlus = iPer > 0 ? true : false;

                            bool isVisible = true;

                            return isVisible ? 
                            Container(
                              //color: Colors.brown,
                              color: iPer > 1 ? Colors.green[500] : null ,
                              child: Column(
                                
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("$percent"),
                                  Container(
                                      width: 40,
                                      padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                                      //row.percent
                                      child: Container(
                                        height: height,
                                        width: 30,
                                        color: isPlus ? Colors.red : Colors.blue,
                                      )),
                                  
                                  Text("$yyyy"),
                                  Text("$date"),
                                ],
                              ),
                            ) : Container();
                          }),
                    ),
                  ),
                  Expanded(
                    //height: 200,
                      child: Card(
                        elevation: 2,
                        child: Container(
                          child: Column(
                            children: [
                              //기간 선택 슬라이더
                              RangeSlider(
                                values: inModel.currentRangeValues,
                                min: 0,
                                max: 100,
                                divisions: 10,
                                
                                onChanged: (RangeValues values) {
                                  // Demo(function: () {
                                  //   setState(() {});      //PASSING SET STATE
                                  // });
                                  inModel.currentRangeValues = values;
                                  inModel.setNoti();
                                },
                                labels: RangeLabels('${inModel.currentRangeValues.start}', '${inModel.currentRangeValues.end}'),
                              ),

                              
                            ],
                          ),
                        ),
                      ),
                    ),

                ],
              ),
            );
          }
        },
      ),
    );
  }
}
