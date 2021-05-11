import 'package:flutter/material.dart';
import 'package:stock/core/coreLibrary.dart';
import 'package:stock/core/widgets.dart';
import 'package:stock/datatable/resultDataDTO.dart';
import 'package:flutter/gestures.dart' as prefix0;
import 'package:stock/model/PracticeInputDTO.dart';
import 'package:stock/model/StockValueDTO.dart';

ResultData resultData = new ResultData();
Widget BuyPopup(BuildContext context, ResultData inputData) {
  int selectedType = 1;
  int buyCount = 1; //구매개수
  String message = "test";
  int inputValue = 1;
  int price = 0;
  CoreLibrary core = new CoreLibrary();
  //String priceMessage = "";

  String close = ""; //종가

  if (inputData != null) {
    if (inputData.resultObject != null && inputData.resultObject is StockValueDTO) {
      StockValueDTO inputDTO = inputData.resultObject as StockValueDTO;
      close = inputDTO.close;
    }
  }


  //구매 개수 변경시
  void onBuyCountChanged()
  {
    price = buyCount * int.parse(close);
  }

  void SetMessage() {
    message = "";
    // if (days.toString().length > 0) {
    //   message = message + "연속" + days.toString() + "거래일 동안 ";
    // }

    if (selectedType == 1) //퍼센트
    {
      message = message + "퍼센트가 ";
    } else if (selectedType == 2) //가격
    {
      message = message + "가격이 ";
    }

    if (inputValue.toString().length > 0) {
      message = message + inputValue.toString();
    }

    message = message + "상승한 경우 다음날 투자";
  }

  resultData = new ResultData();

  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    setState(() => SetMessage());

    //StockValueDTO inputData =  inputData.resultObject;
    //
    String priceWithComma = core.numberWithComma(price);
    
    String closeWithComma = core.numberWithComma(int.parse(close));

    return SafeArea(
      top: false,
      bottom: false,
      child: Form(
        // key: _formKey,
        //autovalidate: _autovalidate,
        //onWillPop: _warnUserAboutInvalidData,
        child: Scrollbar(
          child: SingleChildScrollView(
            dragStartBehavior: prefix0.DragStartBehavior.down,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              //color: HexColor("#FFF6F4"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 10.0),
                  JnSimpleTitle(title: "단가 : $closeWithComma",),
                  
                
                  
                  //Text("구매가격 : $close"),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: "",
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '수량',
                      //prefixText: '\$',
                      suffixText: '주',
                      suffixStyle: TextStyle(color: Colors.green),
                    ),
                    onChanged: (String value) {
                      buyCount = int.parse(value);
                      setState(() => onBuyCountChanged());
                    },
                    maxLines: 1,
                  ),
                  const SizedBox(height: 10.0),
                  JnSimpleTitle(title: "구매금액 : $priceWithComma",),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SimpleOutlineButton(
                        isTokenIconVisible: false,
                        buttonText: "확인",
                        onPressed: () {
                          

                          
                          resultData.resultString = buyCount.toString();
                          resultData.resultString2 = price.toString();

                          Navigator.pop<ResultData>(
                            context, resultData);

                        },
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      SimpleOutlineButton(
                        isTokenIconVisible: false,
                        buttonText: "취소",
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Text("$message"),
                  // const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  });
}
