import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock/core/coreLibrary.dart';
import 'package:stock/model/BaseModel.dart';
import 'package:stock/model/NoteDTO.dart';
import 'package:stock/model/PracticeInputDTO.dart';
import 'package:stock/model/StockDTO.dart';
import 'package:stock/model/StockValueDTO.dart';

class StockModel extends BaseModel {
  List<StockDTO> stockList = [];
  List<StockValueDTO> stockValueList = [];

  //가상투자 관련
  List<PracticeInputDTO> inputList = [];

  List<NoteDTO> notiList = [];

  StockDTO selectedDTO;
  String color;
  String selectedCode;
  String lastSelectedCode;
  RangeValues currentRangeValues = RangeValues(40, 80);

  void setColor(String inColor) {
    print("## NotesModel.setColor(): inColor = $inColor");
    color = inColor;
    notifyListeners();
  }

  static void saveFavorite() {}
  //전체
  Future<List<StockDTO>> getAllCompanyInfo() async {
    List<StockDTO> allStockList = [];
    allStockList.add(StockDTO(
        code: "032640", name: "LG유플러스", market: "KOSPI", isfavorite: true));
    allStockList.add(StockDTO(
        code: "051900", name: "LG생활건강", market: "KOSPI", isfavorite: true));
    allStockList.add(StockDTO(
        code: "322222", name: "THREE", market: "KOSDAQ", isfavorite: false));
    allStockList.add(StockDTO(
        code: "444444", name: "FOUR", market: "KOSDAQ", isfavorite: true));
    allStockList.add(StockDTO(
        code: "555555", name: "FIVE", market: "KOSDAQ", isfavorite: false));

    //서버 작업 완료되면 주석 풀기
    /*
    var map = new Map<String, dynamic>();

    map["search"] = "";

    dynamic result =
        await CallService(buildContext, "SelectComp", map).then((returnValue) {
      print(returnValue);
      if (returnValue != null) {
        //Map map = returnValue;
        var titleList = json.decode(returnValue["compData"]);
        if (map.containsKey("name")) {}

        for (int i = 0; i < titleList.length; i++) {
          var item = titleList[i];

          StockDTO dto = new StockDTO();
          dto.name = item["name"];
          dto.code = item["code"];
          stockModel.stockList.add(dto);
        }

        stockModel.setNoti();
      }
    });
    */
    return allStockList;
  }

  //-------------------------------------
  // function 명 : SelectComp
  // function desc : 회사명 조회
  //-------------------------------------
  void SelectComp(BuildContext buildContext, String searchName) async {
    var map = new Map<String, dynamic>();

    map["search"] = searchName;
    stockModel.stockList.clear();

    //return;
    dynamic result =
        await CallService(buildContext, "SelectComp", map).then((returnValue) {
      print(returnValue);
      if (returnValue != null) {
        //Map map = returnValue;
        var titleList = json.decode(returnValue["compData"]);
        if (map.containsKey("name")) {}

        for (int i = 0; i < titleList.length; i++) {
          var item = titleList[i];

          StockDTO dto = new StockDTO();
          dto.name = item["name"];
          dto.code = item["code"];
          stockModel.stockList.add(dto);
        }

        stockModel.setNoti();
      }
    });
  }

  //-------------------------------------
  // function 명 : SelectValue
  // function desc : 주식 데이터 조회
  //-------------------------------------
  void SelectValue(BuildContext buildContext, String code) async {
    var map = new Map<String, dynamic>();

    map["code"] = code;
    stockModel.stockValueList.clear();

    //return;
    dynamic result =
        await CallService(buildContext, "SelectValue", map).then((returnValue) {
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

          stockModel.stockValueList.add(dto);
        }

        stockModel.setNoti();
      }
    });
  }
} /* End class. */

StockModel stockModel = StockModel();
