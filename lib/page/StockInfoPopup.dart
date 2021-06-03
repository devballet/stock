// 2021.06.02
// 박해나 작성
// 종목 선택시 세부 정보 보여주기 위한 화면

import 'package:flutter/material.dart';
import 'package:stock/component/DetailInfoItem.dart';
import 'package:stock/model/StockInfoDTO.dart';

class StockInfo extends StatelessWidget {
  StockInfoDTO data = dummyCreate();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 3,
        ),
        child: Container(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '${data.name} (${data.code}) | ${data.type}',
                    // '한세실업(105630) | KOSPI',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          '${data.price}',
                          style: TextStyle(fontSize: 35),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '${data.updownprc} (${data.updownper}%)',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )),
              ),
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          DetailInfoItem(
                              name: '시가',
                              value: data.tddOpnprc,
                              isNumber: true),
                          DetailInfoItem(
                              name: '고가', value: data.tddHgprc, isNumber: true),
                          DetailInfoItem(
                              name: '저가', value: data.tddLwprc, isNumber: true),
                          DetailInfoItem(
                              name: '52주(종가)\r\n최고',
                              value: data.wk52HgstPrc,
                              isNumber: true),
                          DetailInfoItem(
                              name: '52주(종가)\r\n최저',
                              value: data.wk52LwstPrc,
                              isNumber: true),
                          DetailInfoItem(
                              name: '대용가', value: data.sbPrc, isNumber: true),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          DetailInfoItem(
                              name: '거래량(주)',
                              value: data.sbPrc,
                              isNumber: true),
                          DetailInfoItem(
                              name: '거래대금(원)',
                              value: data.accTrdvol,
                              isNumber: true),
                          DetailInfoItem(
                              name: '시가총액(백만원)',
                              value: data.accTrdval,
                              isNumber: true),
                          DetailInfoItem(
                              name: '외국인비율',
                              value: data.fornRto,
                              isNumber: true),
                          DetailInfoItem(
                              name: 'PER/PBR',
                              value: data.perPbr,
                              isNumber: true),
                          DetailInfoItem(
                              name: '배당수익률', value: data.divYd, isNumber: true),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
class StockInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 3,
        ),
        child: Container(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '한세실업(105630) | KOSPI',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          '24,100',
                          style: TextStyle(fontSize: 35),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '▼550 (-2.23%)',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.grey.shade300,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                ),
                                child: Text("시가"),
                                alignment: Alignment.center,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                ),
                                child: Text("고가"),
                                alignment: Alignment.center,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                ),
                                child: Text("저가"),
                                alignment: Alignment.center,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                              color: Colors.grey.shade200),
                                        ),
                                      ),
                                      child: Text("52주\r\n(종가)"),
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    color:
                                                        Colors.grey.shade200),
                                              ),
                                            ),
                                            child: Text("최고"),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    color:
                                                        Colors.grey.shade200),
                                              ),
                                            ),
                                            child: Text("최저"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                ),
                                child: Text("대용가"),
                                alignment: Alignment.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade200)),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade200),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade200),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade200)),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade200)),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade200)),
                                ),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.grey.shade300,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                ),
                                child: Text("거래량(주)"),
                                alignment: Alignment.center,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                ),
                                child: Text("거래대금(원)"),
                                alignment: Alignment.center,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                ),
                                child: Text("시가총액\r\n(백만원)"),
                                alignment: Alignment.center,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                ),
                                child: Text("외국인비율"),
                                alignment: Alignment.center,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                ),
                                child: Text("PER/PBR"),
                                alignment: Alignment.center,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                ),
                                child: Text("배당금수익률"),
                                alignment: Alignment.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade200)),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade200),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade200),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade200)),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade200)),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade200)),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
