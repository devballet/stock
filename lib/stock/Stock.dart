import 'package:flutter/material.dart';
import "package:scoped_model/scoped_model.dart";
import 'package:stock/model/StockDTO.dart';
import 'package:stock/model/StockModel.dart' show StockModel, stockModel;
import 'package:stock/stock/StockDetail.dart';
import 'package:stock/stock/StockList.dart';

class Stock extends StatelessWidget {
  
  //-------------------------------------
  // function 명 : Stock
  // function desc : 생성자
  //-------------------------------------
  Stock(){
    //stockModel.loadData("notes", NotesDBWorker.db);
    SelectTempData();
  }

  //-------------------------------------
  // function 명 :   SelectTempData
  // function desc : 임시데이터를 만든다.
  //-------------------------------------
  SelectTempData()
  {
    return;
    stockModel.stockList.clear();
    

    StockDTO dto2 = new StockDTO();
    dto2.name = "엘지전자";
    dto2.code = "2";

    for(int i=0; i< 10; i++)
    {
      StockDTO dto = new StockDTO();
      dto.name = "삼성전자";
      dto.code = "1";
      stockModel.stockList.add(dto);
    }

    stockModel.stockList.add(dto2);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<StockModel>(
      model: stockModel,
      child: ScopedModelDescendant(
        builder: (BuildContext inContext, Widget inChild, StockModel inModel){
            return IndexedStack(
            index : inModel.stackIndex,
            children : [
              StockList(),
              StockDetail(),
            ] /* End IndexedStack children. */
          );
        },
      ),

    );
  }
}