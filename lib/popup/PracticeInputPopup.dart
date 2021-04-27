import 'package:flutter/material.dart';
import 'package:stock/core/widgets.dart';
import 'package:stock/datatable/resultDataDTO.dart';
import 'package:flutter/gestures.dart' as prefix0;
import 'package:stock/model/PracticeInputDTO.dart';

ResultData resultData = new ResultData();
Widget PracticeInputPopup(BuildContext context, ResultData inputData) {
  int selectedType = 1;
  int days = 1;
  String message = "test";
  int inputValue = 1;

  void SetMessage() {
    message = "";
    if (days.toString().length > 0) {
      message = message + "연속" + days.toString() + "거래일 동안 ";
    }

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
                  const SizedBox(height: 24.0),
                  TextFormField(
                    initialValue: "1",
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '연속 거래일',
                      //prefixText: '\$',
                      suffixText: '일',
                      suffixStyle: TextStyle(color: Colors.green),
                    ),
                    onChanged: (String value) {
                      days = int.parse(value);
                      setState(() => SetMessage());
                    },
                    maxLines: 1,
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: selectedType,
                        activeColor: Color(0xFF6200EE),
                        onChanged: (int value) {
                          setState(() => selectedType = value);
                          setState(() => SetMessage());
                        },
                      ),
                      Text("퍼센트"),
                      Radio(
                        value: 2,
                        groupValue: selectedType,
                        activeColor: Color(0xFF6200EE),
                        onChanged: (int value) {
                          setState(() => selectedType = value);
                          setState(() => SetMessage());
                        },
                      ),
                      Text("가격"),
                    ],
                  ),
                  TextFormField(
                    initialValue: "1",
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '조건',
                      //prefixText: '\$',
                      suffixText: '일',
                      suffixStyle: TextStyle(color: Colors.green),
                    ),
                    onChanged: (String value) {
                      inputValue = int.parse(value);
                      setState(() => SetMessage());
                    },
                    maxLines: 1,
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SimpleOutlineButton(
                        isTokenIconVisible: false,
                        buttonText: "확인",
                        onPressed: () {
                          PracticeInputDTO result = new PracticeInputDTO();
                          result.days = days.toString();
                          result.type = selectedType.toString();
                          result.value = inputValue.toString();
                          result.message = message.toString();

                          resultData.resultObject = result;

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
                  SizedBox(
                    height: 10,
                  ),
                  Text("$message"),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  });
}
