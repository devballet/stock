import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock/core/coreLibrary.dart';
import 'package:stock/model/BaseModel.dart';
import 'package:stock/model/NoteDTO.dart';
import 'package:stock/model/PracticeInputDTO.dart';
import 'package:stock/model/StockDTO.dart';
import 'package:stock/model/StockValueDTO.dart';

class PracticeModel extends BaseModel {

  //가상투자 관련
  List<PracticeInputDTO> inputList = new List<PracticeInputDTO>();
  List<StockValueDTO> stockValueList = new List<StockValueDTO>();
  List<StockValueDTO> tempStockValueList = new List<StockValueDTO>();
  


  List<NoteDTO> notiList = new List<NoteDTO>();

  StockDTO selectedDTO;
  String color;
  String selectedCode;
  String lastSelectedCode;
  RangeValues currentRangeValues = RangeValues(40, 80);

  int count = 0;

  void setColor(String inColor) {
    print("## NotesModel.setColor(): inColor = $inColor");
    color = inColor;
    notifyListeners();

  }

  //-------------------------------------
  // function 명 : SelectValue
  // function desc : 주식 데이터 조회
  //-------------------------------------
  void SelectValue(BuildContext buildContext, String code) async
  {
    var map = new Map<String, dynamic>();

    map["code"] = code;
    practiceModel.stockValueList.clear();
   

   //return;
    dynamic result = await CallService(buildContext, "SelectValue", map).then((returnValue) {
      print(returnValue);
      if (returnValue != null) {
        //Map map = returnValue;
        var resultList = json.decode(returnValue["result"]);
        if (map.containsKey("name")) {}

        for (int i = 0; i < resultList.length; i++) {
          var item = resultList[i];

          StockValueDTO dto = new StockValueDTO();
          dto.code = item["code"];
          dto.date = item["date"];

          dto.open = item["open"];
          dto.high = item["high"];
          dto.low = item["low"];
          dto.close = item["close"];
          dto.valume = item["valume"];
          dto.value = item["value"];
          dto.percent = item["percent"];
  
          practiceModel.stockValueList.add(dto);
        }

        practiceModel.setNoti();

      }
    });

  }
} /* End class. */
PracticeModel practiceModel = PracticeModel();
